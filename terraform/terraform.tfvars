project_id = "harness-466107"
region     = "us-east4"
zone       = "us-east4-c"

vm_name       = "todo-app-vm"
machine_type  = "e2-micro"
image         = "ubuntu-os-cloud/ubuntu-2204-lts"
network_name  = "todo-app-network"
firewall_ports = ["8080", "22"]

bucket_name     = "todo-app-bucket-jyotsna739es"
bucket_location = "US"

service_account_name = "todo-app-sa"
