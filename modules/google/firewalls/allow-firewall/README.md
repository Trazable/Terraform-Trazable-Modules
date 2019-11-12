# Google Allow-firewall module

Basic firewall template to allow the desired ports and source ranges.

## Required variables

  - firewall_name (string)
  - network_name (string) - default = "default"
  - protocol_type (string)
  - ports type (list)
  - source_ranges (list)
  - target_tags (list)