FROM gcr.io/cloud-builders/gcloud
RUN apt-get update && apt-get install -y gnupg2 jq golang unzip
COPY cve-checker /root/go/src/cve-checker
COPY scripts/* /scripts/
RUN cd /root/go/src/cve-checker && \
    go build -o /usr/bin/cve-checker
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
    unzip awscli-bundle.zip && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws && \
    rm -rf awscli-bundle*
RUN git clone https://github.com/aws/aws-elastic-beanstalk-cli-setup.git && \
    ./aws-elastic-beanstalk-cli-setup/scripts/bundled_installer