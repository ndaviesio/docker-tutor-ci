# This image is specifically built for container based CI 
# pipelines to deploy openedx, via Overhang.io's Tutor Application
# into AWS.

FROM alpine:3.12

# Install additional dependencies
RUN apk add jq git curl docker alpine-sdk

# Install Python Dependencies
RUN apk add python3 
RUN pip3 install awscli tutor-openedx

# Install Node Dependencies
RUN apk add nodejs npm

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN mv ./kubectl /usr/local/bin
RUN chmod +c /usr/local/bin/kubectl

COPY scripts/aws_assume_role.sh /entrypoint_aws_assume_role.sh
RUN chmod +x /entrypoint_aws_assume_role.sh

ENTRYPOINT ["/entrypoint_aws_assume_role.sh"]