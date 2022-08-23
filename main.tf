terraform {
  cloud {
    organization = "pcs-nym"

    workspaces {
      name = "infra-gcp-gke"
    }
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

# Create demo network
resource "google_compute_network" "demo-vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Create subnet in demo network
resource "google_compute_subnetwork" "demo-subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.demo-vpc.id
}
