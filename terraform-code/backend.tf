terraform {
  backend "gcs" {
    bucket  = "cta-tf-states" 
    prefix  = "env/prod"                 
    #project = "corded-fragment-442201-r2"
    credentials = file(var.gcp_credentials_file)
  }
}