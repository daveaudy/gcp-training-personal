# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started
# Google Project - GCP and GKE Training - https://console.cloud.google.com/iam-admin/settings?project=rich-involution-303217

# The project field should be your personal project id. 
# The project indicates the default GCP project all of your resources will be created in. Most Terraform resources will have a project field.

# personal project
# export GOOGLE_APPLICATION_CREDENTIALS="C:\\Users\\T929417\\Documents\\Training\\Terraform\\personal-gcp.json"
provider "google" {

  credentials = "C:\\Users\\T929417\\Documents\\Training\\Terraform\\personal-gcp.json"
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

resource "google_compute_instance" "vm_instance" {
  count                     = var.vm_instance_count
  name                      = "gcp-lab-${count.index + 1}"
  machine_type              = "e2-micro"
  hostname                  = "gcp-lab-${count.index + 1}.emrlab.ca"
  allow_stopping_for_update = true
  desired_status            = "RUNNING"
  tags                      = ["ssh"]
  metadata = {
    enable-oslogin = "TRUE"
  }


  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}

# This will create VPC network resource with a subnetwork in each regio
resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}

# resource "google_compute_subnetwork" "vpc-network-subnet" {
#     name = "rx-services-lab-vpc"
#     ip_cidr_range = "10.0.0.0/9"
#     region = "northamerica-northeast1"
#     network = google_compute_network.vpc-network.id
# }


#  The preferred method of provisioning resources with Terraform is to use a GCP service account, a "robot account" that can be granted a limited set of IAM permissions.

