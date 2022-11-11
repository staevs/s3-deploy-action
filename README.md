# GitHub Action to Sync S3 Bucket and invalidate CloudFront Cache

> Uses official [amazon/aws-cli](https://hub.docker.com/r/amazon/aws-cli) Docker image to sync a directory with a S3 bucket.

Before start configure your [AWS credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-creds-create)

## Usage

Example `workflow.yml`:

```yaml

name: S3 Deployment
on: push

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
        with:
          fetch-depth: 0
      - name: Build App
        run: npm run build
      - name: S3/CloudFront Deploy
        uses: staevs/s3-deploy-action@1.0.0
        if: success()
        with:
          args: --follow-symlinks --delete --no-progress
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_REGION: ${{ secrets.AWS_REGION }}
          AWS_S3_BUCKET: ${{ secrets.AWS_S3_BUCKET }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          CLOUDFRONT_DISTRIBUTION_ID: ${{ secrets.CLOUDFRONT_DISTRIBUTION_ID }}
          S3_SOURCE_DIR: 'build'
```

## Configuration

> `args` would be passed directly to `aws s3` invocation. Refer to: [AWS S3 docs](https://docs.aws.amazon.com/cli/latest/userguide/cli-services-s3.html)

| Environment Variable       | Required                    | Description                                                                                                      | 
|----------------------------|-----------------------------|------------------------------------------------------------------------------------------------------------------|
| AWS_ACCESS_KEY_ID          | true                        | Access Key ID. A unique identifier that's associated with a secret access key                                    |
| AWS_SECRET_ACCESS_KEY      | true                        | Secret Access Key. A key that's used with the access key ID to cryptographically sign programmatic AWS requests. |
| AWS_REGION                 | true                        | Your AWS Region                                                                                                  |
| AWS_S3_BUCKET              | true                        | Your S3 Bucket name                                                                                              |
| S3_SOURCE_DIR              | true                        | Path to local folder                                                                                             |
| S3_DESTINATION_DIR         | false (defaults to S3 root) | Path to folder in a S3 bucket                                                                                    |
| CLOUDFRONT_DISTRIBUTION_ID | false                       | Your CloudFront distribution                                                                                     |
| CLOUDFRONT_PATHS           | false (defaults to /*)      | The paths to invalidate (relative to the distribution)                                                           |
| USE_GZIP                   | false (defaults to false)   | Use gzip for upload                                                                                              |
