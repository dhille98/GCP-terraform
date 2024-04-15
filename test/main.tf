

# Create a health check
resource "google_compute_http_health_check" "example_health_check" {
  name               = "test-health-check"
  request_path       = "/"
  check_interval_sec = 5
  timeout_sec        = 5
}

# Create target pools in each region with instances
resource "google_compute_target_pool" "example_target_pool_us_central1" {
  name   = "test-target-pool-us-central1"
  region = "us-central1"

  health_checks = [google_compute_http_health_check.example_health_check.self_link]

  instances = [
    "us-central1-c/testing",
    //"projects/<your-project-id>/zones/us-central1-b/instances/<instance-name-2>",
  ]
}

resource "google_compute_target_pool" "example_target_pool_us_east1" {
  name   = "example-target-pool-us-east1"
  region = "us-west4"

  health_checks = [google_compute_http_health_check.example_health_check.self_link]

  instances = [
   "us-west4-b/dhille-jenkins",
    //"projects/<your-project-id>/zones/us-east1-c/instances/<instance-name-4>",
  ]
}

# Create forwarding rules for each region to forward traffic to the target pools
resource "google_compute_forwarding_rule" "example_forwarding_rule_us_central1" {
  name                  = "example-forwarding-rule-us-central1"
  region                = "us_central1"
  target                = google_compute_target_pool.example_target_pool_us_central1.self_link
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL"
}

resource "google_compute_forwarding_rule" "example_forwarding_rule_us_east1" {
  name                  = "example-forwarding-rule-us-east1"
  region                = "us-west4"
  target                = google_compute_target_pool.example_target_pool_us_east1.self_link
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL"
}
