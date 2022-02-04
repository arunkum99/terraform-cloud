provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = file("/home/arun/Desktop/terraform/learning-245417-terraform.json")
}

module "test-vpc-module" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 4.0"
  project_id   = var.project_id # Replace this with your project ID in quotes
  network_name = "custom-network1"
  mtu          = 1460

  subnets = [
    {
      subnet_name   = "subnet-us-central-192"
      subnet_ip     = "192.168.1.0/24"
      subnet_region = var.region
    }
  ]
}

resource "google_compute_instance" "vm_instance" {
  project      = var.project_id
  zone         = var.zone
  name         = "terraform-instance"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
  network = module.test-vpc-module.network_name
  subnetwork = "subnet-us-central-192"
}
}