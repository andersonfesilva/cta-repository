
# Bucket creation
resource "google_storage_bucket" "static_website_bucket" {
  name                        = "cafeteria-static-website"  # Unique bucket name
  location                    = "US"
  storage_class               = "STANDARD"
  force_destroy               = true  # To remove all object when the bucket is deleted
  uniform_bucket_level_access = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365  # Objetos mais antigos que 365 dias serão excluídos
    }
  }
}


# Public permissions configuration
resource "google_storage_bucket_iam_binding" "public_access" {
  bucket = google_storage_bucket.static_website_bucket.name

  role = "roles/storage.objectViewer"
  members = [
    "allUsers"  # Allows public access 
  ]
}

# Upload index.html file
resource "google_storage_bucket_object" "index_html" {
  name   = "index.html"
  bucket = google_storage_bucket.static_website_bucket.name
  source = "website/index.html"  # Path to local file
  content_type = "text/html"
}

# Upload 404.html file
resource "google_storage_bucket_object" "file_404_html" {
  name   = "404.html"
  bucket = google_storage_bucket.static_website_bucket.name
  source = "website/404.html"  # Path to local file
  content_type = "text/html"
}

# Bucket definition to backend
resource "google_compute_backend_bucket" "static_site_backend" {
  name        = "cafeteria-backend-bucket"
  bucket_name = google_storage_bucket.static_website_bucket.name
  enable_cdn  = true
}