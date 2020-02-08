{
  "widgets": [
  {
    "type": "log",
      "x": 0,
      "y": 0,
      "width": 24,
      "height": 6,
      "properties": {
        "query": "SOURCE '/aws/lambda/${xformation_lambda_name}' | filter @message like /true|false/ | stats sum(total_records) as @totalRecords, avg(total_records) as @avgBatchSize, sum(total_processed) as @totalProcessed, sum(total_failed) as @totalFailed, max(max_event_record_size_bytes) as @maxSize, sum(total_failed_b64_decode) as @failedB64, sum(total_failed_json_load) as @failedJson", 
        "region": "${aws_region}", 
        "stacked": false, 
        "title": "xformation-stats", 
        "view": "table" 
      }
  },
  {
    "type": "log",
    "x": 0,
    "y": 6,
    "width": 24,
    "height": 6,
    "properties": {
      "query": "SOURCE '/aws/lambda/${xformation_lambda_name}' | filter @message like /true|false/ | filter index_dates like /${target_date}/ | stats sum(total_records) as @totalRecords, avg(total_records) as @avgBatchSize, sum(total_processed) as @totalProcessed, sum(total_failed) as @totalFailed, max(max_event_record_size_bytes) as @maxSize, sum(total_failed_b64_decode) as @failedB64, sum(total_failed_json_load) as @failedJson",
      "region": "${aws_region}",
      "title": "target-date-xformation-stats"
    }
  },
  {
    "type": "log",
    "x": 0,
    "y": 12,
    "width": 24,
    "height": 6,
    "properties": {
      "query": "SOURCE '/aws/lambda/${xformation_lambda_name}' | filter @message like /true|false/ | filter index_dates like /,/ ",
      "region": "${aws_region}",
      "stacked": false,
      "title": "check-mulitple-index-dest",
      "view": "table"
    }
  }
  ]
}
