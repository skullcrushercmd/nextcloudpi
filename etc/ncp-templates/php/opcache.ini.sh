#! /bin/bash

set -e

PHPVER="${PHPVER?ERROR: PHPVER variable unset!}"

if [[ "$1" == "--defaults" ]]
then
  echo -e "INFO: Restoring template to default settings"

  TMP_DIR="/tmp"
else
  TMP_DIR="$(source "${BINDIR}/CONFIG/nc-datadir.sh"; tmpl_opcache_dir)"
fi

  cat > "/etc/php/${PHPVER}/mods-available/opcache.ini" <<EOF
zend_extension=opcache.so
opcache.enable=1
opcache.enable_cli=1
opcache.fast_shutdown=1
opcache.interned_strings_buffer=8
opcache.max_accelerated_files=10000
opcache.memory_consumption=128
opcache.save_comments=1
opcache.revalidate_freq=1
opcache.file_cache=${TMP_DIR};
EOF