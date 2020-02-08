{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:${aws_region}:${aws_account_number}:domain/${domain_name}/*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": ${es_whitelist_ips}
        }
      }
    }
  ]
}
