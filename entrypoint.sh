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

aws s3 sync "${S3_SOURCE_DIR}" "s3://${AWS_S3_BUCKET}/${DESTINATION_DIR}" --follow-symlinks --delete