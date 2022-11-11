#!/bin/sh

aws --version

set -e

if [ -z "$AWS_S3_BUCKET" ]; then
  echo "AWS_S3_BUCKET is not set. Quitting."
  exit 1
fi

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo "AWS_ACCESS_KEY_ID is not set. Quitting."
  exit 1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "AWS_SECRET_ACCESS_KEY is not set. Quitting."
  exit 1
fi

if [ -z "$AWS_REGION" ]; then
  echo "$AWS_REGION is not set. Quitting."
  exit 1
fi

if [ -z "$S3_SOURCE_DIR" ]; then
  echo "$S3_SOURCE_DIR is not set. Quitting."
  exit 1
fi

if [ "$USE_GZIP_COMPRESSION" = true ]; then
  echo "Gzipping files..."

  find "./$S3_SOURCE_DIR" -type f

  find "./$S3_SOURCE_DIR" -type f -exec gzip "{}" \; -exec mv "{}.gz" "{}" \;
fi

echo "Uploading files..."

sh -c "aws s3 sync $S3_SOURCE_DIR s3://$AWS_S3_BUCKET/$DESTINATION_DIR $([ "$USE_GZIP_COMPRESSION" = true ] && echo "--content-encoding gzip" || echo "") $*"

if [ -n "$CLOUDFRONT_DISTRIBUTION_ID" ]; then
  echo "Creating CloudFront invalidation"
  aws cloudfront create-invalidation --distribution-id "$CLOUDFRONT_DISTRIBUTION_ID" --paths "${CLOUDFRONT_PATHS:-/*}"
fi
