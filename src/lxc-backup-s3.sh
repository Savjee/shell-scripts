#!/bin/bash
#
# This script goes into the LXC storage directory and compresses
# each subfolder with tar. It then uploads the backups to Amazon S3 with s3cmd
#
# Author: Xavier Decuyper <www.savjee.be>
# ---------------------------------------------------------------------------

cd /lxc-host/

for dir in */
do
  echo "Compressing $dir ..."
  base=$(basename "$dir")_$(date +"%Y%m%d")
  tar --numeric-owner -czf "/root/lxc-backup/${base}.tar.gz" "$dir"

  #echo "Uploading $dir to B2..."
  #b2 upload_file savjee-be-screencasts "/root/lxc-backup/${base}.tar.gz" "$base"

  echo "Uploading $dir to S3..."
  s3cmd --storage-class=STANDARD_IA put "/root/lxc-backup/${base}.tar.gz" s3://backup-lxc-container

  echo "Deleting local backup..."
  rm "/root/lxc-backup/${base}.tar.gz"
done