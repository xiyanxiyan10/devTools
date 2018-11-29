#!/bin/bash
sudo docker run -d \
    --hostname www.xiyanxiyan10.com \
    --name gitlab \
    --restart always \
    --publish 30001:22 --publish 30000:80 --publish 30002:443 \
    --volume $HOME/gitlab/data:/var/opt/gitlab \
    --volume $HOME/gitlab/logs:/var/log/gitlab \
    --volume $HOME/gitlab/config:/etc/gitlab gitlab/gitlab-ce
