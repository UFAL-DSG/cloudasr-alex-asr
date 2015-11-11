#!/bin/bash

curl -X POST -H "Content-type: application/json"  "${MARATHON_URL}" -d '{
    "id": "cloudasr.com/pykaldi2-${MODEL_NAME}",
    "container": {
        "docker": {
            "image": "ufaldsg/pykaldi2-cloudasr",
            "portMappings": [{"containerPort": 5678, "hostPort": 0, "protocol": "tcp"}],
            "network": "BRIDGE"
        },
        "type": "DOCKER"
    },
    "env": {
        "MASTER_ADDR": "${MASTER_ADDR}",
        "MODEL": "${MODEL_NAME}",
        "MODEL_URL": "${MODEL_URL}"
    },
    "mem": 512,
    "cpus": 0.25,
    "instances": 1
}'