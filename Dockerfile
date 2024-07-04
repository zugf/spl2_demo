FROM debian:buster-slim
ARG DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt-get install -y \
    software-properties-common \
    apt-transport-https \
    wget \
    curl \
    procps


# Install splunk beta
COPY ./splunkbeta-9.2.2.20240415-51a9cf8e4d88-linux-2.6-amd64.deb /tmp/splunk.deb
RUN dpkg -i /tmp/splunk.deb
RUN apt-get install -f

# disable locktest tool (not working)
RUN echo "OPTIMISTIC_ABOUT_FILE_LOCKING=1" >> "/opt/splunkbeta/etc/splunk-launch.conf"

# add splunk to path
ENV SPLUNK_HOME="/opt/splunkbeta"
ENV PATH="/opt/splunkbeta/bin:$PATH"

COPY ./entrypoint.sh $SPLUNK_HOME/bin/entrypoint.sh

ENTRYPOINT ["/opt/splunkbeta/bin/entrypoint.sh"]