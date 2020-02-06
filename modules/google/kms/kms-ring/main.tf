variable "google_project_id" {}
variable "google_region" {}
variable "kms_ring_name" { type = list }

resource "google_kms_key_ring" "kms_ring" {
  count    = length(var.kms_ring_name)
  project  = var.google_project_id
  name     = var.kms_ring_name[count.index]
  location = var.google_region

  depends_on = [null_resource.dependency_getter]
}

# TERRAFORM DEPENDENCIES
#
# Module A : JERARCHY = VAR DEPENDENCIES > DEPENDENCY_GETTER > REAL RESOURCE > DEPENDENCY SETTER > OUTPUT DEPENDED_ON (ID)
# 1 - Dependency created with the value of the variable dependencies from external module (MODULE B) (null_resource.dependecy_getter => var.dependencies)
# 2 - Real resource (google_kms_key_ring.key_ring) has a dependency of null_resource_dependency_getter
# 3 - Output depended_on implicit dependency of null_resource.dependency_setter.id 
# To create a dependency add in your module: dependencies = [module.MODULE_B_name.depended_on]
# Solution created by medium.com/@aniket10051994
resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
    command = "echo ${length(var.dependencies)}"
  }
}

resource "null_resource" "dependency_setter" {
  depends_on = [google_kms_key_ring.kms_ring]
}

output "depended_on" {
  value = null_resource.dependency_setter.id
}

variable "dependencies" {
  type    = list
  default = []
}
