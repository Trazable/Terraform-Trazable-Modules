# EXTERNAL MACHINE ADDRESS OF ONE MACHINE
output "vm_machine_address" {
  value = google_compute_instance.compute_instance.network_interface.0.access_config.0.nat_ip
}