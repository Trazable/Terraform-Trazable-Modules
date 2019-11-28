variable "kms_key_name" {}
variable "kms_key_ring_name" {}
variable "local_exec_command" {}

resource "google_kms_crypto_key" "kms_key" {
  name     = var.kms_key_name
  key_ring = var.kms_key_ring_name

  provisioner "local-exec" {
    command = var.local_exec_command
  }
}