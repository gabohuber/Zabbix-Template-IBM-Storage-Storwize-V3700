#!/bin/bash

. /etc/zabbix/scripts/ibmv3700_discovery.sh

STORWIZEADDR=$(echo $1)
SLOTID=$(echo $2)

IFS=' '

status () {
	LINE=$(cat ${REPODIR}/${STORWIZEADDR}.drive.repo | cut -c4-10,102-108 | grep -w ${SLOTID})
	STATUS=$(echo ${LINE}| awk '{ print $1 }')
	echo ${STATUS}
}

use () {
	LINE=$(cat ${REPODIR}/${STORWIZEADDR}.drive.repo | cut -c33-39,102-108 | grep -w ${SLOTID})
        USE=$(echo ${LINE}| awk '{ print $1 }')
        echo ${USE}
}

type () {
	LINE=$(cat ${REPODIR}/${STORWIZEADDR}.drive.repo | cut -c40-49,102-108 | grep -w ${SLOTID})
        TYPE=$(echo ${LINE}| awk '{ print $1 }')
	echo ${TYPE}
}

mdisk_name  () {
        LINE=$(cat ${REPODIR}/${STORWIZEADDR}.drive.repo | cut -c68-78,102-108 | grep -w ${SLOTID})
	if [ $(echo ${LINE} | grep -o " " | wc -l) -gt 0  ] ; then
	        MDISK_NAME=$(echo ${LINE}| awk '{ print $1 }')
	fi
	echo ${MDISK_NAME}
}

enclosure_id () {
	LINE=$(cat ${REPODIR}/${STORWIZEADDR}.drive.repo | cut -c89-101,102-108 | awk -v SLOTID=${SLOTID} '{if ($2==SLOTID){print $0}}')
	ENCLOUSURE_ID=$(echo ${LINE}| awk '{ print $1 }')
	echo ${ENCLOUSURE_ID}
}

$3
