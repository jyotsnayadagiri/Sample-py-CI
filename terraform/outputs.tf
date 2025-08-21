
output "bucket_name" {
  description = "Name of the GCS bucket"
  value       = google_storage_bucket.todo_app_bucket.name
}

output "bucket_url" {
  description = "URL of the GCS bucket"
  value       = google_storage_bucket.todo_app_bucket.url
}

output "service_account_email" {
  description = "Email of the service account"
  value       = google_service_account.todo_app_sa.email
}

output "application_url" {
  description = "URL to access the Todo application"
  value       = "http://${module.gcp_infra.vm_instance_ip}:8080"
}

