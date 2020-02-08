{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${src_aws_account_number}:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
