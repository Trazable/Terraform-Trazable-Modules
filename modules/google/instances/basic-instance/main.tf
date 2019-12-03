variable "instance_name" {}
variable "machine_type" {}
variable "google_zone" {}
variable "google_project_id" {}
variable "machine_image" {}
variable "internal_address" {}

resource "google_compute_instance" "compute_instance" {
  name                      = var.instance_name
  machine_type              = var.machine_type
  zone                      = var.google_zone

  boot_disk {
    initialize_params {
      image = var.machine_image
    }
  }
  network_interface {
    network    = "default"
    network_ip = var.internal_address
    access_config {
    }
  }

  metadata = {
    google-logging-enabled = true
  }
}
