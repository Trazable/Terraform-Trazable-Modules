# Google storage Bucket module

This module allow the multiple creation of storage buckets.

## Required variables

  - google_project_id (string)
  - google_region (string)
  - bucket_name (list) - The dynamic creation iterate by the length of this list.

## Outputs

  - storage_bucket_names - List of all buckets