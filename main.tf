provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "gke_subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_ip_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_container_cluster" "gke_cluster" {
  name               = var.cluster_name
  location           = var.zone
  network            = google_compute_network.vpc_network.id
  subnetwork         = google_compute_subnetwork.gke_subnet.id
  initial_node_count = "1"
  remove_default_node_pool = "true"

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/14"
    services_ipv4_cidr_block = "/20"
  }
}

resource "google_container_node_pool" "primary_nodes" {
  cluster    = google_container_cluster.gke_cluster.name
  location   = google_container_cluster.gke_cluster.location
  node_count = var.node_count

  node_config {
    machine_type = var.node_machine_type
    disk_size_gb = 50
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

resource "google_service_account" "gke_sa" {
  account_id   = "gke-sa"
  display_name = "GKE Service Account"
}

resource "google_project_iam_member" "gke_sa_roles" {
  for_each = toset([
    "roles/container.admin",
    "roles/compute.networkAdmin",
  ])

  project = var.project_id
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
  role    = each.value
}

resource "google_compute_firewall" "allow_github" {
  name    = "allow-github-access"
  network = "var.network_name"  

  allow {
    protocol = "tcp"
    ports    = ["443"]  
  }

  source_ranges = [
    "192.30.252.0/22",  # GitHub IP ranges
    "185.199.108.0/22",  # GitHub IP ranges
    "143.55.64.0/22",    # Additional GitHub IP ranges
    "185.199.109.0/22"   # GitHub IP ranges
  ]

}