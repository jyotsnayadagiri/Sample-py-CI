provider "google" {
  project = "harness-466107"
  region  = "us-west1"  # Changed region
  zone    = "us-west1-a"
}

resource "google_compute_instance" "vm" {
  name         = "notes-vm"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network       = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y docker.io git
    docker run -d -p 80:5000 docker.io/jyotsnayadagiri/python-ci:latest
  EOT
}

output "app_url" {
  value = "http://${google_compute_instance.vm.network_interface[0].access_config[0].nat_ip}"
}
