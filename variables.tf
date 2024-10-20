variable "project_id" {
  description = "The GCP project ID."
  type        = string
  default     = "devops-asm"
}

variable "region" {
  description = "The region."
  type        = string
  default     = "asia-southeast1"  
}

variable "zone" {
  description = "The Zone."
  type        = string
  default     = "asia-southeast1-b"  
}

variable "cluster_name" {
  description = "The name of the GKE cluster."
  type        = string
  default     = "gke-cluster"
}

variable "router_name" {
  description = "The name of the router."
  type        = string
  default     = "gke-rt"
}

variable "nat_name" {
  description = "The name of the nat."
  type        = string
  default     = "nat-gw"
}

variable "network_name" {
  description = "The name of the VPC network."
  type        = string
  default     = "gke-vpc"
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
  default     = "gke-subnet"
}

variable "subnet_ip_cidr" {
  description = "The IP CIDR range for the subnet."
  type        = string
  default     = "10.0.0.0/16"
}

variable "node_count" {
  description = "The number of nodes in the GKE cluster."
  type        = number
  default     = 3
}

variable "node_machine_type" {
  description = "The machine type."
  type        = string
  default     = "e2-medium" 
}

