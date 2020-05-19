#!/bin/sh
set -ex
ENCODED_TOKEN=$(echo -n "$TOKEN" | base64 -w0 );

/scripts/deploy.sh -t helm -c engineering -a "\
 --set rclone.config.driveName=$DRIVE_NAME\
 --set rclone.config.scope=$DRIVE_SCOPE\
 --set rclone.config.rootFolderID=$ROOT_FOLDER_ID\
 --set rclone.config.token=$ENCODED_TOKEN\
 --set rclone.config.github=$GITHUB_BOT_TOKEN\
 assets --namespace=assets w3f/assets"
