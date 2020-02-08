# Receiver AWS account infra

Sample Terraform infrastructure to setup log receiver AWS account infra.

## Steps

1. Create the state bucket

    ```sh
    cd base/01-state_mgmt
    make init && make plan && make apply
    ```

    Output will be similar to:

    ```sh
    tf_bucket_id = aws-firehose-elasticsearch-state-bucket
    ```

    This will create an AWS S3 versioning enabled state bucket - which will be used as a foundation for storing remote
    state for further infra work. To read more about why to take this approach for creating state bucket, read [this](https://github.com/saurabh-hirani/terraform-aws-state-mgmt).

2. Export the state bucket variable

    ```sh
    export TF_STATE_S3=aws-firehose-elasticsearch-state-bucket
    ```

3. Export the sender AWS account number i.e. the AWS account number from which logs are going to be sent to the Firehose in the
   receiver account:

    ```sh
    TF_VAR_sender_aws_account_number=56781234
    ```

4. Export the AWS Kinesis Firehose transformation Lambda zip file path. Follow [these](https://github.com/saurabh-hirani/aws-firehose-xformation-lambda#package-for-uploading-to-aws)
   instructions to create the zip file.

    ```sh
   export TF_VAR_xformation_lambda_zip_file_path=/parent_dir_of_lambda_dir/aws-firehose-xformation-lambda/xformation_lambda.zip
    ```

5. Update any tags you want to apply to all infra components by changing [common.tfvars](./common.tfvars) file.

6. Change to the ```app``` dir and create the infra

    ```sh
    cd - && cd app
    make init && make plan && make apply
    ```

    Output will be similar to

    ```sh
    firehose_arn           = arn:aws:firehose:us-east-1:12345678:deliverystream/test-firehose
    s3_arn                 = arn:aws:s3:::test-firehose-es-backup
    kinesis_agent_role_arn = arn:aws:iam::12345678:role/test-firehose-kinesis_agent
    xformation_lambda_arn  = arn:aws:lambda:us-east-1:12345678:function:test-firehose-xformation-lambda

    elasticsearch_arn      = arn:aws:es:us-east-1:12345678:domain/test-es
    elasticsearch_endpoint = search-test-es-abcd.us-east-1.es.amazonaws.com
    kibana_endpoint        = search-test-es-abcd.us-east-1.es.amazonaws.com/_plugin/kibana/

    metrics_dashboard_arn  = arn:aws:cloudwatch::12345678:dashboard/test-es-firehose-metrics
    insights_dashboard_arn = arn:aws:cloudwatch::12345678:dashboard/test-es-firehose-insights
    ```

    The above output has been formatted for readability.

    | Sr. No. | Item                    |                  Description                                                         |
    |:-------:|:-----------------------:|:------------------------------------------------------------------------------------ |
    |    1    | firehose_arn            | AWS Kinesis Firehose ARN                                                             |
    |    2    | s3_arn                  | AWS Kinesis Firehose backup S3 bucket ARN                                            |
    |    3    | kinesis_agent_role_arn  | AWS Kinesis Firehose agent role which will be used by the sender AWS account Lambda  |
    |    4    | xformation_lambda_arn   | AWS Kinesis Firehose transformation Lambda ARN                                       |
    |    5    | elasticsearch_arn       | AWS Elasticsearch domain ARN                                                         |
    |    6    | elasticsearch_endpoint  | AWS Elasticsearch domain endpoint                                                    |
    |    7    | kibana_endpoint         | AWS Elasticsearch Kibana UI endpoint                                                 |
    |    8    | metrics_dashboard_arn   | AWS Cloudwatch monitoring metrics dashboard ARN                                      |
    |    9    | insights_dashboard_arn  | AWS Cloudwatch insights dashboard ARN                                                |

    We will be using **kinesis_agent_role_arn** in the **sender** AWS infra creation so that it can **assume** the role to access
    the receiver AWS account. Read [this](https://aws.amazon.com/blogs/security/how-to-enable-cross-account-access-to-the-aws-management-console/) to understand
    how assume role works.

    For security purposes AWS Elasticsearch and Kibana endpoints are set to be accessible only from the public IP of the machine
    from which Terraform is run. The IP is inferred and set in Elasticsearch acccess policy as described [here](https://github.com/saurabh-hirani/terraform-aws-firehose-elasticsearch/blob/master/examples/receiver/app/main.tf#L30).

    You can change it to a comma separated string of IPs if you want to provide your own list.

7. Access Elasticsearch endpoint, Kibana endpoint and the dashboards to verify their creation.

## Known issues

1. The AWS Cloudwatch insights dashboard uses **timestamp()** function to filter logs for metric for the date on which Terraform is run. Because
   this leads to dynamic interpretation, it will cause **terraform plan** to recreate the AWS Cloudwatch insights dashboard on every run. To have
   a static value, update **target_date** variable as described [here](https://github.com/saurabh-hirani/terraform-aws-firehose-elasticsearch/blob/master/examples/receiver/app/main.tf#L88).
