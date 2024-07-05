#!/bin/bash
set -e

splunk_cmd=${SPLUNK_HOME}/bin/splunk

teardown() {
	${splunk_cmd} stop || true
}

trap teardown SIGINT SIGTERM


# Define the path of the temp file
INITIALIZED_FILE="${SPLUNK_HOME}/etc/initialized.mark"

# Check if the temp file exists
if [ ! -f "$INITIALIZED_FILE" ]; then
    echo "Start splunk - first start....."

	${splunk_cmd} start --accept-license --answer-yes --no-prompt --seed-passwd ${SPLUNK_PASSWORD}

	if [[ -f "/tmp/deploy/splunk.License" ]]; then
		${splunk_cmd} login -auth "admin:$SPLUNK_PASSWORD"
		${splunk_cmd} add license "/tmp/deploy/splunk.License"
	else
		echo "License file not found."
	fi
	# following does not seem to work... apps need to be installed via Web UI
	if [ -d "/tmp/deploy/apps" ] ; then
		for file in /tmp/deploy/apps/*.tar.gz; do
			if [ -f "$file" ]; then
				${splunk_cmd} install app "$file"
			fi
		done
	fi
	${splunk_cmd} restart

    touch "$INITIALIZED_FILE"
else
    echo "Start splunk..."

	${splunk_cmd} start
fi

# stream log and keep splunk running
echo Streaming ${SPLUNK_HOME}/var/log/splunk/splunkd_stderr.log...
tail -n 0 -f ${SPLUNK_HOME}/var/log/splunk/splunkd_stderr.log &
wait