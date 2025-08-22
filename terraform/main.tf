provider "google" {
  project = "harness-466107"
  region  = "us-west1"
  zone    = "us-west1-a"
}
module "gcp_infra" {
  source = "./modules/gcp_infra"
}
