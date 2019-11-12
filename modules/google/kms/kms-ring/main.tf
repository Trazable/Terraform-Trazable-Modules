variable "google_project_id" {}
variable "google_region" {}
variable "kms_ring_name" { type = list }

resource "google_kms_key_ring" "kms_ring" {
  count    = length(var.kms_ring_name)
  project  = var.google_project_id
  name     = var.kms_ring_name[count.index]
  location = var.google_region
}


