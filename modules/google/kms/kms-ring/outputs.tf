# ONLY IF USE ONE KEY RING TO MULTIPLE KEYS
output "kms_ring_path" {
  description = "Google path where the key_ring is stored" 
  value       = google_kms_key_ring.kms_ring[0].self_link
}

# ALL KEY RINGS PATHS
output "kms_all_rings_paths" {
  value       = google_kms_key_ring.kms_ring[*].self_link
}