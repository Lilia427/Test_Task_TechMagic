FROM nginx:latest

RUN apt-get update && apt-get install -y curl unzip && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && ./aws/install && \
    rm -rf awscliv2.zip ./aws

ENV S3_BUCKET_NAME=my-default-bucket

CMD ["sh", "-c", "aws s3 cp s3://${S3_BUCKET_NAME}/index.html /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"]
