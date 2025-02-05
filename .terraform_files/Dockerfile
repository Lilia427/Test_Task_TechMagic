FROM nginx:bullseye

RUN apt-get update && apt-get install -y curl unzip && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && ./aws/install && \
    rm -rf awscliv2.zip ./aws

ENV S3_BUCKET_NAME=default-tm-devops-trainee-html-bucket

RUN echo "PATH=$PATH" && aws --version

CMD ["sh", "-c", "\
    if aws s3 cp s3://${S3_BUCKET_NAME}/index.html /usr/share/nginx/html/index.html; then \
    echo 'File copied successfully'; \
    else \
    echo 'Error: Failed to copy file from S3'; \
    fi && \
    nginx -g 'daemon off;'"]
