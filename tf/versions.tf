terraform {
  backend "gcs" {
    bucket  = "masondenney-my-gke"
    prefix  = "terraform/state"
  }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.47.0"
    }
  }
}