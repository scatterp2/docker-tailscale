# Use an official Ubuntu image as the base
FROM ubuntu:latest

# Set the maintainer label (optional)
LABEL maintainer="your-email@example.com"

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install dependencies
RUN apt-get update && \
    apt-get install -y \
    curl \
    ca-certificates \
    iproute2 \
    iputils-ping \
    net-tools \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Install Tailscale
RUN curl -fsSL https://tailscale.com/install.sh | sh

# Set up the Tailscale service
RUN mkdir -p /var/run/sshd
RUN echo 'root:root' | chpasswd

# Expose the SSH port and any other necessary ports
EXPOSE 22

# Start SSH service and Tailscale on container start
CMD service ssh start && tailscale up && tail -f /dev/null
