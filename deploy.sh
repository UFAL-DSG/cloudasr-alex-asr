#!/bin/bash
set -x

curl -X POST -H "Content-type: application/json"  "${MARATHON_URL}" -d '
{
    "id": "cloudasr.com/alex-asr-'"${MODEL_NAME}"'",
    "container": {
        "docker": {
            "image": "ufaldsg/cloudasr-alex-asr",
            "portMappings": [{"containerPort": 5678, "hostPort": 0, "protocol": "tcp"}],
            "network": "BRIDGE"
        },
        "type": "DOCKER"
    },
    "env": {
        "MASTER_ADDR": "'"${MASTER_ADDR}"'",
        "MODEL": "'"${MODEL_NAME}"'",
        "MODEL_URL": "'"${MODEL_URL}"'"
    },
    "mem": '"${MEM-512}"',
    "cpus": '"${CPU-1.0}"',
    "instances": 1,
    "cmd": "bash download_models.sh; while true; do python run.py; done"
}'
