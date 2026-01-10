#!/bin/sh

# Redirect output to log
exec > $HOME/.backup-log.txt
exec 2>&1

# Should include the following variables:
# B2_KEY_ID - Backblaze B2 keyID
# B2_KEY - Backblaze B2 key
# B2_BUCKET - Backblaze B2 bucket name
# ENC_KEY - GPG encryption key fingerprint
# SGN_KEY - GPG signing key fingerprint
# export PASSPHRASE - GPG encryption key PASSPHRASE
# export SIGN_PASSPHRASE - GPG signing key PASSPHRASE
. $HOME/.backup-config.sh

# Backblaze B2 directory
B2_DIR="$(uname -n)/$(whoami)"

# Local directory to backup
LOCAL_DIR=$HOME

# Retention settings
KEEP_BACKUPS_FOR="90D"
FULL_BACKUP_EVERY="30D"

echo "REMOVE OLDER FILES:"
duplicity \
 --sign-key $SGN_KEY --encrypt-key $ENC_KEY \
 remove-older-than $KEEP_BACKUPS_FOR --force \
 b2://${B2_KEY_ID}:${B2_KEY}@${B2_BUCKET}/${B2_DIR}

echo "PERFORM THE BACKUP:"
duplicity \
 --sign-key $SGN_KEY --encrypt-key $ENC_KEY \
 --full-if-older-than $FULL_BACKUP_EVERY \
 ${LOCAL_DIR} b2://${B2_KEY_ID}:${B2_KEY}@${B2_BUCKET}/${B2_DIR}

echo "CLEANUP FAILURES:"
duplicity \
 cleanup --force \
 --sign-key $SGN_KEY --encrypt-key $ENC_KEY \
 b2://${B2_KEY_ID}:${B2_KEY}@${B2_BUCKET}/${B2_DIR}

echo "COLLECTION STATUS:"
duplicity collection-status \
 --sign-key $SGN_KEY --encrypt-key $ENC_KEY \
  b2://${B2_KEY_ID}:${B2_KEY}@${B2_BUCKET}/${B2_DIR}

# Unset variables
unset B2_KEY_ID
unset B2_KEY
unset B2_BUCKET
unset B2_DIR
unset LOCAL_DIR
unset ENC_KEY
unset SGN_KEY
unset PASSPHRASE
unset SIGN_PASSPHRASE
unset KEEP_BACKUPS_FOR
unset FULL_BACKUP_EVERY

echo "SUCCESS!"
echo $(date)
