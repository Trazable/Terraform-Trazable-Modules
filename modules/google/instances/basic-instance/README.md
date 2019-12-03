# Google VM_INSTANCE module

Basic template instance to create a vm machine in google cloud platform

## Required variables

  - instance_name (string)
  - machine_type (string) - Example: "g1-small"
  - google_zone (string)
  - google_project_id (string)
  - machine_image (string) - Example: "cos-cloud/cos-stable"
  - user_data_file (string) - File inserted on the metadata of the instance
  - service_accounts_scopes (list) - Roles attached to the service account instance
  - internal_address (string)

## Outputs

  - vm_machine_address - Output of the external ip address of one machine