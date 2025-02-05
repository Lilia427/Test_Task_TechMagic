[
  {
    "name": "default-tm-devops-trainee-container",
    "image": "767828737655.dkr.ecr.us-east-1.amazonaws.com/nginx-with-awscli:latest",
    "essential": true,
    "memory": 512,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp"
      }
    ],
    "mountPoints": [
      {
        "sourceVolume": "efs-volume",
        "containerPath": "/usr/share/nginx/html"
      }
    ],
    "volumes": [
      {
        "name": "efs-volume",
        "efsVolumeConfiguration": {
          "fileSystemId": "${efs_id}",
          "rootDirectory": "/",
          "transitEncryption": "ENABLED"
        }
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${log_group_name}",
        "awslogs-region": "${log_group_region}",
        "awslogs-stream-prefix": "nginx"
      }
    },
    "command": [
      "aws s3 cp s3://${s3_bucket_name}/index.html /usr/share/nginx/html/index.html && nginx -g 'daemon off;'"
    ]
  }
]
