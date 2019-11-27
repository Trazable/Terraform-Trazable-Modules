variable "google_project_id" {}
variable "google_bucket_object_name" { type = list }
variable "google_bucket_name" {}

resource "google_storage_bucket_object" "bucket_object" {
  count      = length(var.google_bucket_object_name)
  name       = "${var.google_project_id}-${var.google_bucket_object_name[count.index]}"
  bucket     = var.google_bucket_name
}
