variable domain_name {
  description = "AWS Elasticsearch domain name"
}

variable "aws_region" {
  description = "AWS Elasticsearch region"
  default     = "us-east-1"
}


variable elasticsearch_version {
  description = "AWS Elasticsearch version"
}

variable instance_type {
  description = "AWS Elasticsearch data nodes instance count"
}

variable instance_count {
  description = "AWS Elasticsearch data nodes instance count"
}

variable dedicated_master_type {
  description = "AWS Elasticsearch master instance type"
}

variable dedicated_master_count {
  description = "AWS Elasticsearch master instance count"
}

variable automated_snapshot_start_hour {
  description = "AWS Elasticsearch automated snapshot start hour"
  default     = 23
}

variable es_whitelist_ips {
  description = "AWS Elasticsearch whitelist IPs"
}

variable es_advanced_options {
  type    = map
  default = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}
