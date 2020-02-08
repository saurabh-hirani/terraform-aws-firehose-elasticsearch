variable metrics_dashboard_name {
  description = "AWS Cloudwatch metrics dashboard name"
}

variable insights_dashboard_name {
  description = "AWS Cloudwatch insights dashboard name"
}


variable dashboard_vars {
  description = "AWS Cloudwatch dashboard template vars"
  type        = map
  default     = {}
}
