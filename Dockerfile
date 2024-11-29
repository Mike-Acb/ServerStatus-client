FROM python:3.9-slim

WORKDIR /app

# Install required packages
RUN apt-get update && \
    apt-get install -y vnstat && \
    pip3 install --no-cache-dir psutil requests py-cpuinfo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* \

# Copy the client script
ADD https://raw.githubusercontent.com/zdz/ServerStatus-Rust/refs/heads/master/client/stat_client.py .

# Set environment variables for configuration
ENV SERVER_URL="http://127.0.0.1:8080/report"
ENV USER="h1"
ENV GID="g1"
ENV PASSWORD="p1"

# Command to run the script
CMD ["sh", "-c", "python3 stat_client.py -a $SERVER_URL -u $USER  -p $PASSWORD"]
