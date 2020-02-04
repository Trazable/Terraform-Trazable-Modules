# SIMPLE NODE HELLO WORLD APPLICATION TO ENABLE APP-ENGINE

variable "google_project_id" {}
variable "zip_location" {}
variable "google_region" {}
variable "google_location" {}

resource "google_app_engine_application" "app_engine_application" {
  project     = var.google_project_id
  location_id = var.google_location
}

resource "google_app_engine_standard_app_version" "initial_version" {
  version_id      = "initial"
  service         = "default"
  runtime         = "nodejs10"
  noop_on_destroy = true
  entrypoint {
    shell = "npm start"
  }
  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.standard_app_bucket.name}/${google_storage_bucket_object.standard_app_bucket_object.name}"
    }
  }
  depends_on = [google_app_engine_application.app_engine_application]
}

resource "google_storage_bucket" "standard_app_bucket" {
  name     = "${var.google_project_id}-app-engine-app-bucket"
  location = var.google_region
}

resource "google_storage_bucket_object" "standard_app_bucket_object" {
  name   = "${var.google_project_id}-app-engine-application"
  bucket = google_storage_bucket.standard_app_bucket.name
  source = "${path.module}/${var.zip_location}"
}

