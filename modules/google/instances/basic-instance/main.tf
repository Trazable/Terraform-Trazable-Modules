resource "google_compute_instance" "compute_instance" {
  name                      = var.instance_name
  machine_type              = var.machine_type
  zone                      = var.google_zone

  boot_disk {
    initialize_params {
      image = var.machine_image
    }
  }
  network_interface {
    network    = "default"
    network_ip = var.internal_address
    access_config {
    }
  }

  metadata = {
    google-logging-enabled = true
    user-data              = file("${path.module}/${var.user_data_file}")
  }

  depends_on = [null_resource.dependency_getter]
}

# TERRAFORM DEPENDENCIES
#
# Module A : JERARCHY = VAR DEPENDENCIES > DEPENDENCY_GETTER > REAL RESOURCE > DEPENDENCY SETTER > OUTPUT DEPENDED_ON (ID)
# 1 - Dependency created with the value of the variable dependencies from external module (MODULE B) (null_resource.dependecy_getter => var.dependencies)
# 2 - Real resource (google_compute_instance.compute_instance) has a dependency of null_resource_dependency_getter
# 3 - Output depended_on implicit dependency of null_resource.dependency_setter.id 
# To create a dependency add in your module: dependencies = [module.MODULE_B_name.depended_on]
# Solution created by medium.com/@aniket10051994
resource "null_resource" "dependency_getter" {
  provisioner "local-exec" {
    command = "echo ${length(var.dependencies)}"
  }
}

resource "null_resource" "dependency_setter" {
  depends_on = [google_compute_instance.compute_instance]
}

output "depended_on" {
  value = null_resource.dependency_setter.id
}

variable "dependencies" {
  type    = list
  default = []
}
