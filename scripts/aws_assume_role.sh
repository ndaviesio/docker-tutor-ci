#!/usr/bin/env bash
if [[ -n "${AWS_ASSUME_ROLE_ARN}" ]]; then
  # Assume the role provided, and override credentials (if provided)
  CREDENTIALS=$(aws sts assume-role \
                  --role-arn ${AWS_ASSUME_ROLE_ARN} \
                  --role-session-name docker-tutor-ci)
  echo "$CREDENTIALS"
  export AWS_ACCESS_KEY_ID=$(echo "${CREDENTIALS}" | jq -r '.Credentials.AccessKeyId')
  export AWS_SECRET_ACCESS_KEY=$(echo "${CREDENTIALS}" | jq -r '.Credentials.SecretAccessKey')
  export AWS_SESSION_TOKEN=$(echo "${CREDENTIALS}" | jq -r '.Credentials.SessionToken')
fi