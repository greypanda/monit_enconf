#!/bin/bash
CURR_DIR=`pwd`/
cd $CURR_DIR
if [ "$(whoami)" != 'root' ]; then
   echo "you need use it with sudo: sudo ./install.sh"
else
   mkdir -p /usr/local/share/man/man8/monitenconf/
   cp ./mont_* 		/usr/sbin
   cp ./bash_completion.d/* 	/etc/bash_completion.d
   cp ./man/* /usr/local/share/man/man8/monitenconf
   echo "Success!"
fi

