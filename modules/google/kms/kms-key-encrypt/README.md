# Google KMS-key-encrypt module

This module allows create a one key that when the creation finish it can execute a local command on the machine running terraform.
You can encrypt a file with this key after it creation. (egg Chicken)

## Required variables

  - kms_key_name (string)
  - kms_key_ring_name (string)
  - local_exec_command (string)

## Example

The case of use is encrypt a file with the key and push this file encrypted with a bucket to the google cloud project.

Command example (This command must be typed in the main.tf of the project not in the module):

```
gcloud kms encrypt --location ${var.google_region} --keyring ${var.kms_ring_name} --key ${var.kms_key_encrypt_name} --plaintext-file ${var.file_name} --ciphertext-file ${var.storage_object_source}
```