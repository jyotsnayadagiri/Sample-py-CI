variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "zone" {
  description = "The GCP zone"
  type        = string
}

variable "vm_name" {
  description = "Name of the VM instance"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the VM"
  type        = string
}

variable "image" {
  description = "Boot image for the VM"
  type        = string
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "firewall_ports" {
  description = "List of ports to open in firewall"
  type        = list(string)
}

variable "service_account_name" {
  description = "Name of the service account"
  type        = string
  default     = "todo-app-sa"
}