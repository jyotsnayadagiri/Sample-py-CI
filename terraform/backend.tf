terraform {
  backend "gcs" {
    bucket = "jyotsna-bucket-2"

    prefix = "terraform/state"

  }
}

