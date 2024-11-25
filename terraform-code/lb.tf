
# URLs map to appoint bucket backend
resource "google_compute_url_map" "static_site_url_map" {
  name            = "cafeteria-url-map"
  default_service = google_compute_backend_bucket.static_site_backend.id
}

# Target proxy http to forward trafic to url map
resource "google_compute_target_http_proxy" "static_site_proxy" {
  name   = "cafeteria-http-proxy"
  url_map = google_compute_url_map.static_site_url_map.id
}

# Static ip address to load balancer
resource "google_compute_global_address" "static_site_ip" {
  name = "cafeteria-lb-ip"
}

# Expose Load Balancer  in an specific port http 80
resource "google_compute_global_forwarding_rule" "static_site_forwarding_rule" {
  name       = "cafeteria-forwarding-rule"
  port_range = "80"
  target     = google_compute_target_http_proxy.static_site_proxy.id
  ip_address = google_compute_global_address.static_site_ip.address
}