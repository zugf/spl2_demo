#!/bin/bash
set -e

splunk_cmd=${SPLUNK_HOME}/bin/splunk

teardown() {
	${splunk_cmd} stop || true
}

trap teardown SIGINT SIGTERM

echo "Start splunk..."

${splunk_cmd} start --accept-license --answer-yes --no-prompt --seed-passwd ${SPLUNK_PASSWORD}

# stream log and keep splunk running
echo Streaming ${SPLUNK_HOME}/var/log/splunk/splunkd_stderr.log...
tail -n 0 -f ${SPLUNK_HOME}/var/log/splunk/splunkd_stderr.log &
wait