terraform {
  backend "gcs" {
    bucket = "drakon64-tfstate"
    prefix = "nixos-config"
  }
  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.32"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 7.32"
    }
  }
}

provider "google" {
  region  = "europe-west2"
}

provider "google-beta" {
  region  = "europe-west2"
}
