#!/bin/bash

#!/bin/bash

# Update /etc/passwd to support arbitrary user IDs
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
envsubst < /home/appadmin/passwd.template > /tmp/passwd
export LD_PRELOAD=/usr/lib64/libnss_wrapper.so
export NSS_WRAPPER_PASSWD=/tmp/passwd
export NSS_WRAPPER_GROUP=/etc/group


# Check if AWS credentials are provided
if [[ -n "$AWS_ACCESS_KEY_ID" && -n "$AWS_SECRET_ACCESS_KEY" ]]; then
    # Configure AWS CLI
    aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
    aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
    aws configure set default.region $AWS_REGION

    # Download the artifact from AWS S3
    aws s3 cp s3://$S3_BUCKET/$S3_OBJECT /workspace --region $AWS_REGION
fi

# Execute the run.sh script with any arguments passed to this script
"$@"