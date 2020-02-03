# DYNAMIC CREATION FOR EACH API SERVICE NAME

variable "google_project_id" {}
variable "google_api_service" { type = list }

resource "google_project_service" "api_service" {
  count = length(var.google_api_service)
  
  project = var.google_project_id
  service = var.google_api_service[count.index]
  disable_on_destroy = true
  disable_dependent_services = true
}