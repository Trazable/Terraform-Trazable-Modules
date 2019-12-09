variable "instance_name" {}
variable "machine_type" {}
variable "google_zone" {}
variable "google_project_id" {}
variable "machine_image" {}
variable "user_data_file" {}
variable "service_accounts_scopes" { type = list }
variable "internal_address" {}
variable "allow_stop_update" { 
  type = bool 
  default = true
}

resource "google_compute_instance" "compute_instance" {
  name                      = var.instance_name
  machine_type              = var.machine_type
  zone                      = var.google_zone
  allow_stopping_for_update = var.allow_stop_update

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
    user-data              = file(var.user_data_file)
  }

  service_account {
    scopes = var.service_accounts_scopes
  }
}
