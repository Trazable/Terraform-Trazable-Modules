# Google storage Bucket with object module

This module create a bucket with the possibility to add dynamically bucket objects, this creation is necessary because terraform doesn't have modules dependencies (yet)

## Required variables

  - google_project_id (string)
  - google_region (string)
  - bucket_name (string)
  - google_bucket_object_name (list)
  - object_source (string)