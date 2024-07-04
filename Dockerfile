FROM ubuntu:20.04
ARG SPLUNK_PASSWORD
ARG DEBIAN_FRONTEND=noninteractive


RUN apt-get update && apt-get install -y \
    software-properties-common \
    apt-transport-https \
    wget \
    curl \
    procps \
    sudo \
    vim \
    git \
    net-tools \
    jq \
    make

# Create a new user with user id 1000 and add it to the 'sudo' group
RUN useradd -m -u 1000 splunk && echo "splunk:${SPLUNK_PASSWORD}" | chpasswd && adduser splunk sudo

# Install splunk beta
COPY ./splunkbeta-9.2.2.20240415-51a9cf8e4d88-linux-2.6-amd64.deb /tmp/splunk.deb
RUN dpkg -i /tmp/splunk.deb
RUN apt-get install -f

USER splunk
# add splunk to path
ENV SPLUNK_HOME="/opt/splunkbeta"
ENV PATH="/opt/splunkbeta/bin:$PATH"
ENV SPLUNK_PASSWORD="${SPLUNK_PASSWORD}"

# disable locktest tool (not working)
RUN echo "OPTIMISTIC_ABOUT_FILE_LOCKING=1" >> "/opt/splunkbeta/etc/splunk-launch.conf"
# RUN sed -i 's/9800/9888/g' "/opt/splunkbeta/etc/splunk-launch.conf"
# create var folder - so that it can be mapped to a docker volume
RUN mkdir /opt/splunkbeta/var/

COPY ./entrypoint.sh $SPLUNK_HOME/bin/entrypoint.sh

ENTRYPOINT ["/opt/splunkbeta/bin/entrypoint.sh"]