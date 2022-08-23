# GKE cluster
resource "google_container_cluster" "primary" {
  name                     = "${var.gcp_project}-gke"
  location                 = var.gcp_region
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.demo-vpc.name
  subnetwork = google_compute_subnetwork.demo-subnet.name
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-node-pool"
  location   = var.gcp_region
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.gcp_project
    }

    # preemptible  = true
    machine_type = "n1-standard-1"
    tags         = ["gke-node", "${var.gcp_project}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}