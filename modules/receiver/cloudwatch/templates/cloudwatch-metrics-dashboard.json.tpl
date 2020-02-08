{
    "widgets": [
        {
            "type": "metric",
            "x": 12,
            "y": 12,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [
                        "AWS/ES",
                        "5xx",
                        "DomainName",
                        "${es_domain_name}",
                        "ClientId",
                        "${aws_account_number}",
                        {
                            "period": 60
                        }
                    ],
                    [
                        ".",
                        "4xx",
                        ".",
                        ".",
                        ".",
                        ".",
                        {
                            "period": 60
                        }
                    ],
                    [
                        ".",
                        "2xx",
                        ".",
                        ".",
                        ".",
                        ".",
                        {
                            "period": 60
                        }
                    ],
                    [
                        ".",
                        "3xx",
                        ".",
                        ".",
                        ".",
                        ".",
                        {
                            "period": 60
                        }
                    ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "${aws_region}",
                "title": "http-response-status",
                "period": 300
            }
        },
        {
            "type": "metric",
            "x": 6,
            "y": 18,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [
                        "AWS/ES",
                        "IndexingRate",
                        "DomainName",
                        "${es_domain_name}",
                        "ClientId",
                        "${aws_account_number}"
                    ],
                    [
                        ".",
                        "IndexingLatency",
                        ".",
                        ".",
                        ".",
                        "."
                    ],
                    [
                        ".",
                        "SearchLatency",
                        ".",
                        ".",
                        ".",
                        "."
                    ],
                    [
                        ".",
                        "SearchRate",
                        ".",
                        ".",
                        ".",
                        "."
                    ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "${aws_region}",
                "title": "indexing-search-rate-latency",
                "period": 60,
                "stat": "Maximum"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 12,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [
                        "AWS/ES",
                        "CPUUtilization",
                        "DomainName",
                        "${es_domain_name}",
                        "ClientId",
                        "${aws_account_number}",
                        {
                            "stat": "Maximum"
                        }
                    ],
                    [
                        "..."
                    ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "${aws_region}",
                "title": "max-avg-cpu",
                "period": 60,
                "stat": "Average"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 24,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [
                        "AWS/ES",
                        "ThreadpoolBulkQueue",
                        "DomainName",
                        "${es_domain_name}",
                        "ClientId",
                        "${aws_account_number}"
                    ],
                    [
                        ".",
                        "ThreadpoolBulkRejected",
                        ".",
                        ".",
                        ".",
                        "."
                    ],
                    [
                        ".",
                        "ThreadpoolBulkThreads",
                        ".",
                        ".",
                        ".",
                        "."
                    ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "${aws_region}",
                "title": "ThreadpoolBulk-metrics",
                "period": 60,
                "stat": "Maximum"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 18,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [
                        "AWS/Lambda",
                        "Throttles",
                        "FunctionName",
                        "${xformation_lambda_name}",
                        {
                            "stat": "Sum",
                            "period": 86400
                        }
                    ],
                    [
                        ".",
                        "Invocations",
                        ".",
                        ".",
                        {
                            "stat": "Sum",
                            "period": 86400
                        }
                    ],
                    [
                        ".",
                        "ConcurrentExecutions",
                        ".",
                        ".",
                        {
                            "stat": "Average",
                            "period": 86400
                        }
                    ]
                ],
                "view": "singleValue",
                "stacked": false,
                "region": "${aws_region}",
                "title": "xformation-lambda-invocations-throttles",
                "period": 300
            }
        },
        {
            "type": "metric",
            "x": 18,
            "y": 6,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [
                        "AWS/Firehose",
                        "DeliveryToElasticsearch.Success",
                        "DeliveryStreamName",
                        "${firehose_delivery_stream_name}"
                    ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "${aws_region}",
                "title": "DeliveryESSuccess",
                "period": 60,
                "stat": "Average"
            }
        },
        {
            "type": "metric",
            "x": 12,
            "y": 18,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [
                        "AWS/Firehose",
                        "DeliveryToElasticsearch.Bytes",
                        "DeliveryStreamName",
                        "${firehose_delivery_stream_name}",
                        {
                            "period": 60,
                            "stat": "Sum"
                        }
                    ],
                    [
                        ".",
                        "IncomingBytes",
                        ".",
                        ".",
                        {
                            "period": 60,
                            "stat": "Sum"
                        }
                    ],
                    [
                        ".",
                        "SucceedProcessing.Bytes",
                        ".",
                        ".",
                        {
                            "period": 60,
                            "stat": "Sum"
                        }
                    ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "${aws_region}",
                "title": "1min-sum-fh-bytes",
                "period": 300
            }
        },
        {
            "type": "metric",
            "x": 18,
            "y": 12,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [
                        {
                            "expression": "m1 + m2",
                            "label": "TotalStorageSpace",
                            "id": "e1",
                            "region": "${aws_region}"
                        }
                    ],
                    [
                        {
                            "expression": "(m1 / (m1 + m2)) * 100",
                            "label": "FreePercent",
                            "id": "e2"
                        }
                    ],
                    [
                        "AWS/ES",
                        "FreeStorageSpace",
                        "DomainName",
                        "${es_domain_name}",
                        "ClientId",
                        "${aws_account_number}",
                        {
                            "id": "m1"
                        }
                    ],
                    [
                        ".",
                        "ClusterUsedSpace",
                        ".",
                        ".",
                        ".",
                        ".",
                        {
                            "id": "m2"
                        }
                    ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "${aws_region}",
                "title": "system-free-storage",
                "period": 60,
                "stat": "Sum"
            }
        },
        {
            "type": "metric",
            "x": 6,
            "y": 12,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [
                        "AWS/ES",
                        "JVMMemoryPressure",
                        "DomainName",
                        "${es_domain_name}",
                        "ClientId",
                        "${aws_account_number}"
                    ],
                    [
                        "...",
                        {
                            "stat": "Average"
                        }
                    ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "${aws_region}",
                "title": "max-avg-jvm-memory-pressure",
                "period": 60,
                "stat": "Maximum"
            }
        },
        {
            "type": "metric",
            "x": 18,
            "y": 18,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [
                        "AWS/Firehose",
                        "IncomingRecords",
                        "DeliveryStreamName",
                        "${firehose_delivery_stream_name}",
                        {
                            "stat": "Sum",
                            "period": 60
                        }
                    ],
                    [
                        ".",
                        "DeliveryToElasticsearch.Records",
                        ".",
                        ".",
                        {
                            "stat": "Sum",
                            "period": 60
                        }
                    ],
                    [
                        ".",
                        "SucceedProcessing.Records",
                        ".",
                        ".",
                        {
                            "stat": "Sum",
                            "period": 60
                        }
                    ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "${aws_region}",
                "title": "1min-sum-fh-records",
                "period": 300
            }
        },
        {
            "type": "metric",
            "x": 18,
            "y": 0,
            "width": 6,
            "height": 6,
            "properties": {
                "metrics": [
                    [
                        "AWS/ES",
                        "Nodes",
                        "DomainName",
                        "${es_domain_name}",
                        "ClientId",
                        "${aws_account_number}"
                    ],
                    [
                        ".",
                        "MasterReachableFromNode",
                        ".",
                        ".",
                        ".",
                        ".",
                        {
                            "stat": "Minimum"
                        }
                    ],
                    [
                        ".",
                        "KibanaHealthyNodes",
                        ".",
                        ".",
                        ".",
                        ".",
                        {
                            "stat": "Sum",
                            "period": 60
                        }
                    ]
                ],
                "view": "timeSeries",
                "stacked": false,
                "region": "${aws_region}",
                "title": "Nodes",
                "period": 300,
                "stat": "Maximum"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 6,
            "width": 12,
            "height": 6,
            "properties": {
                "metrics": [
                    [
                        {
                            "expression": "(m2*100) / m1",
                            "label": "DeliveryPercent",
                            "id": "percent",
                            "yAxis": "left",
                            "region": "${aws_region}",
                            "period": 86400
                        }
                    ],
                    [
                        "AWS/Firehose",
                        "IncomingRecords",
                        "DeliveryStreamName",
                        "${firehose_delivery_stream_name}",
                        {
                            "id": "m1",
                            "yAxis": "left",
                            "label": "IncomingRecords"
                        }
                    ],
                    [
                        ".",
                        "SucceedProcessing.Records",
                        ".",
                        ".",
                        {
                            "id": "m5",
                            "label": "SucceededProcessing.Records"
                        }
                    ],
                    [
                        ".",
                        "DeliveryToElasticsearch.Records",
                        ".",
                        ".",
                        {
                            "id": "m2",
                            "label": "DeliveryToES.Records"
                        }
                    ],
                    [
                        ".",
                        "IncomingBytes",
                        ".",
                        ".",
                        {
                            "id": "m3",
                            "label": "FirehoseIncomingBytes"
                        }
                    ],
                    [
                        ".",
                        "DeliveryToElasticsearch.DataFreshness",
                        ".",
                        ".",
                        {
                            "stat": "Average",
                            "id": "m4",
                            "label": "AvgESDataFreshness"
                        }
                    ],
                    [
                        "...",
                        {
                            "stat": "Maximum",
                            "id": "m6",
                            "label": "MaxESDataFreshness"
                        }
                    ],
                    [
                        {
                            "expression": "(m1-m2)",
                            "label": "UndeliveredRecords",
                            "id": "difference",
                            "region": "${aws_region}",
                            "period": 86400
                        }
                    ]
                ],
                "view": "singleValue",
                "stacked": false,
                "region": "${aws_region}",
                "title": "1-day",
                "period": 86400,
                "stat": "Sum"
            }
        },
        {
            "type": "metric",
            "x": 12,
            "y": 0,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [
                        "AWS/ES",
                        "ClusterStatus.green",
                        "DomainName",
                        "${es_domain_name}",
                        "ClientId",
                        "${aws_account_number}"
                    ],
                    [
                        ".",
                        "ClusterStatus.yellow",
                        ".",
                        ".",
                        ".",
                        "."
                    ],
                    [
                        ".",
                        "ClusterStatus.red",
                        ".",
                        ".",
                        ".",
                        "."
                    ]
                ],
                "region": "${aws_region}",
                "title": "ClusterStatus",
                "period": 300
            }
        },
        {
            "type": "metric",
            "x": 12,
            "y": 6,
            "width": 6,
            "height": 6,
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [
                        "AWS/Firehose",
                        "DeliveryToElasticsearch.DataFreshness",
                        "DeliveryStreamName",
                        "${firehose_delivery_stream_name}"
                    ]
                ],
                "region": "${aws_region}",
                "title": "ESDataFreshness"
            }
        },
        {
            "type": "metric",
            "x": 0,
            "y": 0,
            "width": 12,
            "height": 6,
            "properties": {
                "metrics": [
                    [
                        {
                            "expression": "(m2*100) / m1",
                            "label": "DeliveryPercent",
                            "id": "percent",
                            "yAxis": "left",
                            "region": "${aws_region}",
                            "period": 3600
                        }
                    ],
                    [
                        "AWS/Firehose",
                        "IncomingRecords",
                        "DeliveryStreamName",
                        "${firehose_delivery_stream_name}",
                        {
                            "id": "m1",
                            "yAxis": "left",
                            "label": "IncomingRecords"
                        }
                    ],
                    [
                        ".",
                        "SucceedProcessing.Records",
                        ".",
                        ".",
                        {
                            "id": "m5",
                            "label": "SucceededProcessing.Records"
                        }
                    ],
                    [
                        ".",
                        "DeliveryToElasticsearch.Records",
                        ".",
                        ".",
                        {
                            "id": "m2",
                            "label": "DeliveryToES.Records"
                        }
                    ],
                    [
                        ".",
                        "IncomingBytes",
                        ".",
                        ".",
                        {
                            "id": "m3",
                            "label": "FirehoseIncomingBytes"
                        }
                    ],
                    [
                        ".",
                        "DeliveryToElasticsearch.DataFreshness",
                        ".",
                        ".",
                        {
                            "stat": "Average",
                            "id": "m4",
                            "label": "AvgESDataFreshness"
                        }
                    ],
                    [
                        "...",
                        {
                            "stat": "Maximum",
                            "id": "m6",
                            "label": "MaxESDataFreshness",
                            "visible": false
                        }
                    ],
                    [
                        {
                            "expression": "(m1-m2)",
                            "label": "UndeliveredRecords",
                            "id": "difference",
                            "region": "${aws_region}",
                            "period": 3600
                        }
                    ]
                ],
                "view": "singleValue",
                "stacked": false,
                "region": "${aws_region}",
                "title": "1-hour",
                "period": 3600,
                "stat": "Sum"
            }
        }
    ]
}
