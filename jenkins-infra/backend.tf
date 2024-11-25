terraform {
  backend "gcs" {
    bucket  = "cta-tf-states" 
    prefix  = "env/tools"                 
    #project = "corded-fragment-442201-r2"
    credentials = "key-cta-user.json"
  }
}