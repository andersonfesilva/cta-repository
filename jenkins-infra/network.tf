# Firewall rules to allow HTTP and SSH trafic
resource "google_compute_firewall" "jenkins_firewall" {
  name    = "allow-jenkins"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080", "22"]  # Default port Jenkins and SSH
  }

  source_ranges = ["0.0.0.0/0"]  # Allow all trafic IP
  target_tags   = ["jenkins"]
}