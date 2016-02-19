#!/bin/bash

. /etc/zabbix/scripts/ibmv3700_discovery.sh

STORWIZEADDR=$(echo $1)
VOLNAME=$(echo $2)

IFS=' '

status () {
	LINE=$(cat ${REPODIR}/${STORWIZEADDR}.volume.repo | awk '{ print $2, $5}' | grep -w ${VOLNAME})
	STATUS=$(echo ${LINE}| awk '{ print $2 }')
	echo ${STATUS}
}

size () {
        LINE=$(cat ${REPODIR}/${STORWIZEADDR}.volume.repo | awk '{ print $2, $8}' | grep -w ${VOLNAME})
        VALUE=$(echo ${LINE}| awk '{ print $2 }')

	if [ $(echo ${VALUE} | grep TB) ] ; then
		VCALC=$(echo ${VALUE} | awk -F'TB' '{ print $1 }')
		SIZE=$(echo "scale=0; ${VCALC} * 1000" | bc)
	else
		VCALC=$(echo ${VALUE} | awk -F'GB' '{ print $1 }')
		SIZE=$(echo "scale=0; ${VCALC}" | bc)
	fi

	echo ${SIZE}
}

$3
