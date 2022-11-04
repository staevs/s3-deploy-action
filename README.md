# GitHub Action to Sync S3 Bucket and invalidate CloudFront Cache

Uses official [amazon/aws-cli](https://hub.docker.com/r/amazon/aws-cli) Docker image to sync a directory with a S3 bucket.

Before start configure your [AWS credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-creds-create)


| Environment Variable  | Required                    | Description                                                                                                      | 
|-----------------------|-----------------------------|------------------------------------------------------------------------------------------------------------------|
| AWS_ACCESS_KEY_ID     | true                        | Access Key ID. A unique identifier that's associated with a secret access key                                    |
| AWS_SECRET_ACCESS_KEY | true                        | Secret Access Key. A key that's used with the access key ID to cryptographically sign programmatic AWS requests. |
| AWS_REGION            | true                        | Your AWS Region                                                                                                  |
| AWS_S3_BUCKET         | true                        | Your S3 Bucket name                                                                                              |
| S3_SOURCE_DIR         | true                        | Path to local folder                                                                                             |
| S3_DESTINATION_DIR    | false (defaults to S3 root) | Path to folder in a S3 bucket                                                                                    |
