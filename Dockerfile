# Use Red Hat UBI 8 as the base image
FROM registry.access.redhat.com/ubi8/ubi:latest

#Maintainer
MAINTAINER "Amit Thakur" <amitthk>

# Update system and install necessary tools
RUN yum update -y && \
    yum install -y wget tar gzip unzip gettext nss_wrapper gcc gcc-c++ make git libffi-devel

# Create a non-root user 'appadmin'
RUN useradd -m -s /bin/bash appadmin


# Copy installation scripts from 'files' directory
COPY files/install-java.sh /install-java.sh
COPY files/install-maven.sh /install-maven.sh
COPY files/install-nodejs.sh /install-nodejs.sh
COPY files/install-yarn.sh /install-yarn.sh
COPY files/install-python.sh /install-python.sh
COPY files/install-golang.sh /install-golang.sh
COPY files/install-jupyter.sh /install-jupyter.sh
COPY files/install-awscli.sh /install-awscli.sh
COPY files/install-theia.sh /install-theia.sh

# Make scripts executable
RUN chmod +x /install-java.sh \
    && chmod +x /install-maven.sh \
    && chmod +x /install-nodejs.sh \
    && chmod +x /install-python.sh \
    && chmod +x /install-golang.sh \
    && chmod +x /install-jupyter.sh \
    && chmod +x /install-awscli.sh \
    && chmod +x /install-theia.sh \
    && chmod +x /install-yarn.sh 

# Execute installation scripts
RUN /install-java.sh \
    && /install-maven.sh \
    && /install-nodejs.sh \
    && /install-yarn.sh \
    && /install-python.sh \
    && /install-golang.sh

RUN install-jupyter.sh \
    && /install-awscli.sh \
    && /install-theia.sh

# Set environment variables for Java and Maven
ENV JAVA_HOME=/opt/zulu21.30.15-ca-jdk21.0.1-linux_x64
ENV MAVEN_HOME=/opt/maven-3.9
ENV PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH

# Set environment variable for Golang
ENV GOROOT=/usr/local/go
ENV PATH=$GOROOT/bin:$PATH

# Copy entrypoint and run scripts from 'files' directory
COPY files/entrypoint.sh /entrypoint.sh
COPY files/run.sh /run.sh
COPY files/run-java.sh /run-java.sh
COPY files/run-python.sh /run-python.sh
COPY files/run-nodejs.sh /run-nodejs.sh
COPY files/passwd.template /home/appadmin/passwd.template

# Make entrypoint and run scripts executable
RUN chmod +x /entrypoint.sh \
    && chmod +x /run.sh \
    && chmod +x /run-java.sh \
    && chmod +x /run-python.sh \
    && chmod +x /run-nodejs.sh

# Set user writable directory and set permissions
RUN mkdir /workspace && \
    chown -R appadmin:root /workspace && \
    chmod -R 775 /workspace

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Default command
CMD ["./run.sh", "start"]

# Expose the port Theia runs on
EXPOSE 3000

EXPOSE 8888

# Switch to 'appadmin' user
USER appadmin

# User writable directory setup
VOLUME ["/workspace"]
WORKDIR /workspace

# Set the default command (can be overridden)
CMD ["./run.sh"]
