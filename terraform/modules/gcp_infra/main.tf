resource "google_service_account" "provisioner_sa" {
  account_id   = "provisioner-sa"
  display_name = "Provisioner Service Account"
}

resource "google_compute_instance" "vm" {
  name         = "notes-vm"
  machine_type = "e2-micro"
  zone         = "us-west1-a"
  
  # TAGS MUST BE INSIDE THE RESOURCE BLOCK
  tags = ["http-server", "ssh"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  service_account {
    email  = google_service_account.provisioner_sa.email
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y docker.io
    
    # Run the Docker container
    docker run -d \
      --name todo-app \
      -p 80:8080 \
      -e SPRING_DATASOURCE_URL=jdbc:h2:mem:testdb \
      -e SPRING_DATASOURCE_DRIVER_CLASS_NAME=org.h2.Driver \
      -e SPRING_DATASOURCE_USERNAME=sa \
      -e SPRING_DATASOURCE_PASSWORD=password \
      -e SPRING_JPA_HIBERNATE_DDL_AUTO=create-drop \
      -e SPRING_JPA_DATABASE_PLATFORM=org.hibernate.dialect.H2Dialect \
      jyotsnayadagiri/mavenjy:latest
  EOT
}

# Firewall rules outside the instance resource
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-80"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}
output "vm_instance_ip" {
  description = "Public IP address of the VM instance"
  value       = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}
