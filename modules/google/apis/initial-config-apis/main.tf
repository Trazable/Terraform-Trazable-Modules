variable "google_project_id" {}

resource "google_project_service" "project_cloud" {
  project = var.google_project_id
  service = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true
    provisioner "local-exec" {
      command = "sleep 60"
    }
}

resource "google_project_service" "project_compute" {
  project = var.google_project_id
  service = "compute.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true

  depends_on = ["google_project_service.project_cloud"]
}

resource "google_project_service" "project_iam" {
  project = var.google_project_id
  service = "iam.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true

  depends_on = ["google_project_service.project_cloud"]
}

resource "google_project_service" "project_app_engine" {
  project = var.google_project_id
  service = "appengine.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true

  depends_on = ["google_project_service.project_cloud"]
}

resource "google_project_service" "project_app_kms" {
  project = var.google_project_id
  service = "cloudkms.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true

  depends_on = ["google_project_service.project_cloud"]
}