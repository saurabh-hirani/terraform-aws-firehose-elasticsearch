variable "bucket_name" {
  type        = string
  description = "AWS S3 bucket name"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}

variable "expiration_days" {
  description = "Bucket content expiration days"
  default     = 365
}
