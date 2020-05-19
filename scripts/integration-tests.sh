#!/bin/bash

source /scripts/common.sh
source /scripts/bootstrap-helm.sh
set -ex


run_tests() {
  echo Running tests...
  wait_pod_ready assets default 1/1
}

teardown() {
  helm delete assets
}

main(){
  if [ -z "$KEEP_W3F_ASSETS" ]; then
      trap teardown EXIT
  fi
  ENCODED_TOKEN=$(echo -ne "$TOKEN" | base64);
  echo Installing...
  helm install --set rclone.config.driveName="${DRIVE_NAME}" --set rclone.config.scope="${DRIVE_SCOPE}" --set rclone.config.rootFolderID="${ROOT_FOLDER_ID}" --set rclone.config.token="${ENCODED_TOKEN}" --set rclone.config.github="${GITHUB_BOT_TOKEN}" assets ./charts/assets

  run_tests

}

main
set +x
