variable "google_project_id" {}
variable "google_region" {}
variable "bucket_name" { type = list }

resource "google_storage_bucket" "bucket" {
  count    = length(var.bucket_name)
  name     = "${var.google_project_id}-${var.bucket_name[count.index]}"
  location = var.google_region
}
