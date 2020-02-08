module "remote_state" {
  source            = "git::https://github.com/saurabh-hirani/terraform-aws-state-mgmt.git?ref=v0.0.2"
  state_bucket_name = "aws-firehose-elasticsearch-state-bucket"
  force_destroy     = true
  versioning_config = {
    enabled = true
  }
  tags = var.tags
}
