variable "firewall_name" {}
variable "network_name" { default = "default" }
variable "protocol_type" {}
variable "ports" { type = list }
variable "source_ranges" { type = list}
variable "target_tags" { type = list }

resource "google_compute_firewall" "allow-rule" {
  name    = var.firewall_name
  network = var.network_name

  allow {
    protocol = var.protocol_type
    ports    = var.ports
  }

  source_ranges = var.source_ranges
  target_tags   = var.target_tags
}
