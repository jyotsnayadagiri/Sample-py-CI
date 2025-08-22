

resource "google_compute_instance" "vm" {
  name         = "notes-vm"
  machine_type = "e2-micro"

  # ADDED: Assign a network tag to the VM
  tags = ["http-server"]

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

# ADDED: This resource creates a firewall rule to allow HTTP traffic
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-80"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  # This allows traffic from anywhere
  source_ranges = ["0.0.0.0/0"]

  # This applies the rule to the VM with the "http-server" tag
  target_tags   = ["http-server"]
}


output "vm_instance_ip" {
  description = "Public IP address of the VM instance"
  value = "http://${google_compute_instance.vm.network_interface[0].access_config[0].nat_ip}"

}




