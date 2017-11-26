FROM docker.artifactory.weedon.org.au/redwyvern/java-devenv-base
MAINTAINER Nick Weedon <nick@weedon.org.au>

ARG GIT_USER=Jenkins
ARG GIT_EMAIL=jenkins@weedon.org.au

RUN apt-get clean && apt-get update && apt-get install -y --no-install-recommends \
    git \
    debhelper \
    devscripts \
    fakeroot && \
    apt-get -q autoremove && \
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin

# Set user jenkins to the image
RUN useradd -m -d /home/jenkins -s /bin/bash jenkins

USER jenkins
COPY authorized_keys /home/jenkins/.ssh/authorized_keys

RUN git config --global user.name "${GIT_USER}" && \
    git config --global user.email "${GIT_EMAIL}"

USER root

# Copy over the Maven settings.xml file and make sure all jenkins files are owned by jenkins
RUN 	mkdir /home/jenkins/.m2 2>/dev/null && cp /root/.m2/settings.xml /home/jenkins/.m2 && \
        chown -R jenkins.jenkins /home/jenkins

# Standard SSH port
EXPOSE 22

# Default command
CMD ["/usr/sbin/sshd", "-D"]

