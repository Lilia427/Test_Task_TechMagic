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
          "fileSystemId": "fs-0344ff2237ce52daf", 
          "rootDirectory": "/",
          "transitEncryption": "ENABLED"
        }
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/nginx",
        "awslogs-region": "us-east-1",
        "awslogs-stream-prefix": "nginx"
      }
    }
  }
]
