
provider "google" {
  credentials = file(home/dell/acoustic-cargo-416714-c04b9fca2f30.json)
  project     = "acoustic-cargo-416714"
  region      = "us-central1-a"
}