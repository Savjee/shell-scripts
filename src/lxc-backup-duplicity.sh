#!/bin/bash
#
# This script goes into the LXC storage directory and takes a backup of
# each subfolder with duplicity. It then uploads the backups (incrementally) to Backblaze B2
#
# Author: Xavier Decuyper <www.savjee.be>
# ---------------------------------------------------------------------------

cd /lxc-host/

# Used to encrypt backups
export PASSPHRASE="xxxxxxxxx"

B2_BUCKET="xxxxxxxxx"
B2_ACCOUNT="xxxxxxxxx"
B2_KEY="xxxxxxxxx"

if ! [ $(which duplicity 2>/dev/null) ]; then
   echo "Duplicity is not installed. Can't continue."
   exit 1;
fi

for dir in */
do
  dir=$(basename "$dir")

  echo "Starting backup for $dir ..."
  duplicity --exclude-filelist /root/exclude-backup.txt $dir b2://${B2_ACCOUNT}:${B2_KEY}@${B2_BUCKET}/$dir/ --full-if-older-than 15D --numeric-owner

  echo "Deleting old backups on B2..."
  duplicity remove-all-but-n-full 4 --force b2://${B2_ACCOUNT}:${B2_KEY}@${B2_BUCKET}/$dir/
done

unset PASSPHRASE