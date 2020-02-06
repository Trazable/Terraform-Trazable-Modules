# SIMPLE NODE HELLO WORLD APPLICATION TO ENABLE APP-ENGINE

variable "google_project_id" {}
variable "zip_location" {}
variable "google_region" {}
variable "google_location" {}

resource "google_app_engine_application" "app_engine_application" {
  project     = var.google_project_id
  location_id = var.google_location

  depends_on = [null_resource.dependency_getter]
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

# TERRAFORM DEPENDENCIES
#
# Module A : JERARCHY = VAR DEPENDENCIES > DEPENDENCY_GETTER > REAL RESOURCE > DEPENDENCY SETTER > OUTPUT DEPENDED_ON (ID)
# 1 - Dependency created with the value of the variable dependencies from external module (MODULE B) (null_resource.dependecy_getter => var.dependencies)
# 2 - Real resource (google_app_engine_application.app_engine_application) has a dependency of null_resource_dependency_getter
# 3 - Output depended_on implicit dependency of null_resource.dependency_setter.id 
# To create a dependency add in your module: dependencies = [module.MODULE_B_name.depended_on]
# Solution created by medium.com/@aniket10051994
resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
    command = "echo ${length(var.dependencies)}"
  }
}

resource "null_resource" "dependency_setter" {
  depends_on = [google_app_engine_standard_app_version.initial_version]
}

output "depended_on" {
  value = null_resource.dependency_setter.id
}

variable "dependencies" {
  type    = list
  default = []
}

