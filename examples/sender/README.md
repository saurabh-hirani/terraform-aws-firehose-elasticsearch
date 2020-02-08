# Sender AWS account infra

Sample Terraform infrastructure to setup log sender AWS account infra.

## Pre-requisites

1. Setup a receiver AWS account with AWS Kinesis Firehose as described [here](https://github.com/saurabh-hirani/terraform-aws-firehose-elasticsearch/tree/master/examples/receiver).

## Steps

1. Create the state bucket

    ```sh
    cd base/01-state_mgmt
    make init && make plan && make apply
    ```

    Output will be similar to:

    ```sh
    tf_bucket_id = aws-firehose-sender-state-bucket
    ```

    This will create an AWS S3 versioning enabled state bucket - which will be used as a foundation for storing remote
    state for further infra work. To read more about why to take this approach for creating state bucket, read [this](https://github.com/saurabh-hirani/terraform-aws-state-mgmt).

2. Export the state bucket variable

    ```sh
    export TF_STATE_S3=aws-firehose-sender-state-bucket
    ```

3. Export the receiver AWS account number i.e. the AWS account number to which logs are going to be sent:

    ```sh
    TF_VAR_receiver_aws_account_number=12345678
    ```

4. Export the receiver AWS account assume role for accessing AWS Kinesis Firehose. You should obtain the value as one of the outputs (```kinesis_agent_role_arn```) when
   setting up the **receiver** AWS account as described [here](https://github.com/saurabh-hirani/terraform-aws-firehose-elasticsearch/tree/master/examples/receiver)

    ```sh
    TF_VAR_receiver_aws_assume_role=arn:aws:iam::12345678:role/test-firehose-kinesis_agent
    ```

5. Export the recevier AWS account Firehose name for sending data to the Firehose. You should obtain the value as one of the outputs (just the last part of ```firehose_arn```) when
   setting up the **receiver** AWS account as described [here](https://github.com/saurabh-hirani/terraform-aws-firehose-elasticsearch/tree/master/examples/receiver)

    ```sh
    TF_VAR_receiver_aws_firehose_name=test-firehose
    ```

6. Export the AWS Kinesis Firehose log sender Lambda zip file path. Follow [these](https://github.com/saurabh-hirani/aws-firehose-log-sender#package-for-uploading-to-aws)
   instructions to create the zip file.

    ```sh
   export TF_VAR_xformation_lambda_zip_file_path=/parent_dir_of_lambda_dir/aws-firehose-xformation-lambda/xformation_lambda.zip
    ```

7. Update any tags you want to apply to all infra components by changing [common.tfvars](./common.tfvars) file.

8. Change to the ```app``` dir and create the infra

    ```sh
    cd - && cd app
    make init && make plan && make apply
    ```

    Output will be similar to

    ```sh
    firehose_log_sender_lambda_arn = arn:aws:lambda:us-east-1:56781234:function:test-firehose-log-sender-lambda
    ```

    This is the Lambda ARN which you can use to send logs to the Firehose by following the instructions described [here](https://github.com/saurabh-hirani/aws-firehose-log-sender#test-cross-account---sender-aws-account-to-receiver-aws-account)
