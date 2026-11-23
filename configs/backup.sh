#!/bin/bash
gitlab-backup create
cp /etc/gitlab/gitlab-secrets.json /var/opt/gitlab/backups/
cp /etc/gitlab/gitlab.rb /var/opt/gitlab/backups/

# crontab -e entry:
# 0 2 * * * /usr/local/bin/backup.sh
