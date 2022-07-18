# This image is specifically built for container based CI
# pipelines to deploy openedx, via Overhang.io's Tutor Application
# into AWS.
FROM alpine:3.12

# Install additional dependencies
RUN apk add jq git openssh-client curl docker alpine-sdk

# Install Python Dependencies
RUN apk add python3 py-pip python3-dev
RUN pip install awscli tutor boto3

# Install Node Dependencies
RUN apk add nodejs npm

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN mv ./kubectl /usr/local/bin
RUN chmod +x /usr/local/bin/kubectl

# Copy over entrypoint and AWS auth scripts
COPY scripts/ .

RUN chmod +x ./aws_assume_role.sh
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
