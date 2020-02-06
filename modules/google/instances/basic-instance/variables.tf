variable "instance_name" { type = string }
variable "machine_type" { type = string }
variable "google_zone" { type = string }
variable "google_project_id" { type = string }
variable "machine_image" { type = string }
variable "user_data_file" {
  type = string
  default = "default.txt"
}
variable "internal_address" {
  type = string
  default = ""
}
variable "allow_stop_update" { 
  type = bool 
  default = true
}