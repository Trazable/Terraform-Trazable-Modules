variable "google_project_id" {}

# CLOUD RESOURCE MANAGER, WRITE, READ AND UPDATE RESOURCE CONTAINERS
resource "google_project_service" "project_cloud" {
  project = var.google_project_id
  service = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true
  depends_on = [null_resource.dependency_getter]
}

# COMPUTE ENGINE
resource "google_project_service" "project_compute_os_login" {
  project = var.google_project_id
  service = "oslogin.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true

  depends_on = [google_project_service.project_cloud]
}

resource "google_project_service" "project_compute" {
  project = var.google_project_id
  service = "compute.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true

  depends_on = [google_project_service.project_compute_os_login]
}

# KMS
resource "google_project_service" "project_app_kms" {
  project = var.google_project_id
  service = "cloudkms.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true

  depends_on = [google_project_service.project_cloud]
}

# APP ENGINE
resource "google_project_service" "project_container_registry" {
  project = var.google_project_id
  service = "containerregistry.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true

  depends_on = [google_project_service.project_cloud]
}

resource "google_project_service" "project_pub_sub" {
  project = var.google_project_id
  service = "pubsub.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true

  depends_on = [google_project_service.project_container_registry]
}

resource "google_project_service" "project_cloud_build" {
  project = var.google_project_id
  service = "cloudbuild.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true

  depends_on = [google_project_service.project_pub_sub]
}

resource "google_project_service" "project_app_engine" {
  project = var.google_project_id
  service = "appengine.googleapis.com"
  disable_on_destroy = true
  disable_dependent_services = true

  depends_on = [google_project_service.project_cloud_build]
}


# TERRAFORM DEPENDENCIES
#
# Module A : JERARCHY = VAR DEPENDENCIES > DEPENDENCY_GETTER > REAL RESOURCE > DEPENDENCY SETTER > OUTPUT DEPENDED_ON (ID)
# 1 - Dependency created with the value of the variable dependencies from external module (MODULE B) (null_resource.dependecy_getter => var.dependencies)
# 2 - Real resource (google_compute_instance.compute_instance) has a dependency of null_resource_dependency_getter
# 3 - Output depended_on implicit dependency of null_resource.dependency_setter.id 
# To create a dependency add in your module: dependencies = [module.MODULE_B_name.depended_on]
resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
    command = "echo ${length(var.dependencies)}"
  }
}

resource "null_resource" "dependency_setter" {
  depends_on = [google_project_service.project_compute, google_project_service.project_app_kms, google_project_service.project_app_engine]
}

output "depended_on" {
  value = null_resource.dependency_setter.id
}

variable "dependencies" {
  type    = list
  default = []
}
