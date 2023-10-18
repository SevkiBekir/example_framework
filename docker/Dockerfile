ARG DOCKER_IMAGE=ubuntu:latest
FROM $DOCKER_IMAGE AS base_image

# Update
RUN apt-get update

# Upgrade
RUN apt-get upgrade -y

# Copy requirements to /tmp
COPY requirements /tmp/requirements

# Install the required packages
RUN apt-get install -y --no-install-recommends \
     $(grep -v '^#' /tmp/requirements/build.txt) \
     $(grep -v '^#' /tmp/requirements/dev.txt) \
     $(grep -v '^#' /tmp/requirements/python.txt)

# Clean
RUN rm -rf /tmp/requirements
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*