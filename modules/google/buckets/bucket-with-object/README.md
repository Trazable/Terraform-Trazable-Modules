# Google storage Bucket with object module

This module create a bucket with their bucket object, this creation is necessary because terraform doesn't have modules dependencies (yet)

## Required variables

  - google_project_id (string)
  - google_region (string)
  - bucket_name (string)
  - google_bucket_object_name (string)
  - object_source (string)