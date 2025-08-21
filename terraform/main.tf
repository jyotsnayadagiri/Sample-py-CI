
# Create a service account
resource "google_service_account" "todo_app_sa" {
  account_id   = var.service_account_name
  display_name = "Service Account for Todo App"
}



# Create a storage bucket
resource "google_storage_bucket" "todo_app_bucket" {
  name          = var.bucket_name
  location      = var.bucket_location
  force_destroy = true

  uniform_bucket_level_access = true
}

# Call the infrastructure module
module "gcp_infra" {
  source = "./modules/gcp_infra"

  project_id    = var.project_id
  region        = var.region
  zone          = var.zone
  vm_name       = var.vm_name
  machine_type  = var.machine_type
  image         = var.image
  network_name  = var.network_name
  firewall_ports = var.firewall_ports
}
