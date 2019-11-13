# Google KMS-Ring module

This module allow the dynamic creation of KMS rings.

## Required variables
  - google_project_id (string)
  - google_region (string)
  - kms_ring_name (list) - The dynamic creation iterate by the length of this list

## Outputs

  - kms_ring_path - Only used if only existe ONE key ring for multiple keys (0)
  - kms_all_rings_paths - All of the paths of the key rings created (*)