#!/bin/bash

set -e

echo "  creating symlinks, any existing files/dirs will be backed up with <file>.bkp/<dir>_bkp"
sleep 0.2
echo '  linking dirs to ~/.config'
sleep 2
for DIR in $(echo */); do
	LINK_TO=${HOME}/.config/${DIR}
	echo "  linking ${LINK_TO} to ${DIR}"
	if [[ -d ${LINK_TO} ]]; then
		echo "  ${LINK_TO} already exists, making a backup"
		mv ${LINK_TO} $(realpath ${LINK_TO})_bkp
	fi
	echo "ln -s $(realpath ${DIR}) ${LINK_TO}"
	sleep 1
done

echo '=> linking files to ~/'
sleep 2
for FILE in $(ls -p | grep -v '/' | grep -v README | grep -v osx.defaults | grep LICENSE); do
	LINK_TO=${HOME}/.${FILE}
	echo "  linking ${LINK_TO} to ${FILE} "
	if [[ -f ${LINK_TO} ]]; then
		echo "  ${LINK_TO} already exists, making a backup"
		mv ${LINK_TO} ${LINK_TO}.bkp
	fi
	ln -s $(realpath ${FILE}) ${LINK_TO}
	sleep 1
done
