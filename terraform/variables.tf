variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "credentials_file" {
  description = "Path to the GCP credentials file"
  type        = string
  default     = "~/.config/gcloud/application_default_credentials.json"
}

variable "vm_name" {
  description = "Name of the VM instance"
  type        = string
  default     = "todo-app-vm"
}

variable "machine_type" {
  description = "Machine type for the VM"
  type        = string
  default     = "e2-medium"
}

variable "image" {
  description = "Boot image for the VM"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "todo-app-network"
}

variable "firewall_ports" {
  description = "List of ports to open in firewall"
  type        = list(string)
  default     = ["8080", "22"]
}

variable "bucket_name" {
  description = "Name of the GCS bucket"
  type        = string
  default     = "todo-app-bucket"
}

variable "bucket_location" {
  description = "Location of the GCS bucket"
  type        = string
  default     = "US"
}

variable "service_account_name" {
  description = "Name of the service account"
  type        = string
  default     = "todo-app-sa"
}
