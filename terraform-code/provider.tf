provider "google" {
  project = "corded-fragment-442201-r2" # Substitua pelo ID do seu projeto GCP
  region  = "us-central1"    # Região do bucket
  credentials = file(var.GOOGLE_APPLICATION_CREDENTIALS)
}
