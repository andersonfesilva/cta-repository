
# Resource to create google instance
resource "google_compute_instance" "jenkins_instance" {
  name         = "jenkins-server"
  machine_type = "e2-medium"  
  zone         = "us-central1-a"

  # Disk configuration
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"  
      size  = 20                            
    }
  }

  # Network and IP 
  network_interface {
    network       = "default"               
    access_config {}                        
  }

  # Script to initialize to jenkins install.
  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y openjdk-11-jdk
    sudo curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    sudo echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y jenkins
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
  EOT

  tags = ["jenkins"]


}