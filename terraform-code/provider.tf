provider "google" {
  project = "corded-fragment-442201-r2" # Substitua pelo ID do seu projeto GCP
  region  = "us-central1"    # Região do bucket
  credentials = jsondecode(file("/var/jenkins_home/workspace/pipe-cta/terraform-code/key-cta-user.json"))
}
