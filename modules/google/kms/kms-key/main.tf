variable "kms_key_name" { type = list }
variable "kms_key_ring_name" {}

resource "google_kms_crypto_key" "kms_key" {
  count    = length(var.kms_key_name)
  name     = var.kms_key_name[count.index]
  key_ring = var.kms_key_ring_name
}