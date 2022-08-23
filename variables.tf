variable "gcp_project" {
  type = string
}
variable "gcp_region" {
  type = string
}
variable "vpc_name" {
  type = string
}
variable "subnet_name" {
  type = string
}
variable "subnet_cidr" {
  type = string
}
variable "gke_num_nodes" {
  default = 1
}
