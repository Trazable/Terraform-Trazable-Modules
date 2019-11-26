# Google VM_INSTANCE module

Basic template instance to create a vm machine in google cloud platform

## Required variables

  - instance_name (string)
  - machine_type (string) - Example: "g1-small"
  - google_zone (string)
  - google_project_id (string)
  - machine_image (string) - Example: "cos-cloud/cos-stable"
  
## Outputs

  - vm_machine_address - Output of the external ip address of one machine