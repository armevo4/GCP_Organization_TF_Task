terraform {
  required_version = ">= 0.13"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "kgkafalian-dev"
  region = "us-central1"
  zone = "us-central1-a"
  credentials = "keys.json"
}