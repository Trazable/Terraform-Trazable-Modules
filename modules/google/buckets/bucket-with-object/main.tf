variable "google_project_id" {}
variable "google_region" {}
variable "bucket_name" {}
variable "bucket_object_name" {}
variable "object_source" {}

resource "google_storage_bucket" "bucket" {
  name     = "${var.google_project_id}-${var.bucket_name}"
  location = var.google_region
}

resource "google_storage_bucket_object" "bucket_object" {
  name       = "${var.google_project_id}-${var.bucket_object_name}"
  bucket     = google_storage_bucket.bucket.name
  source     = var.object_source
}
