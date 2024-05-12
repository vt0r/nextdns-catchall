#!/bin/sh
# ---
# This file goes in /data/on_boot.d/10-nextdns-catchall.sh (mode a+x)

SERVICE_FILE="nextdns-catchall.service"
SOURCE_FILE_PATH="/data/${SERVICE_FILE}"
SYSTEMD_FILE_PATH="/etc/systemd/system/${SERVICE_FILE}"

# Exit right away if the source file is not present
if [ ! -f  $SOURCE_FILE_PATH ]; then
  echo "Can't find service file ${SOURCE_FILE_PATH}"
  exit 1
fi

sha256() {
  sha256sum $1 | cut -d' ' -f1
}

INSTALLED_SUM="$(sha256 $SYSTEMD_FILE_PATH)"
SOURCE_SUM="$(sha256 $SOURCE_FILE_PATH)"

if [ "$INSTALLED_SUM" = "$SOURCE_SUM" ]; then
  echo "Already installed and up to date. Doing nothing."
  exit 0
fi

cp $SOURCE_FILE_PATH $SYSTEMD_FILE_PATH
systemctl daemon-reload
systemctl enable $SERVICE_FILE
systemctl start $SERVICE_FILE
systemctl restart $SERVICE_FILE
