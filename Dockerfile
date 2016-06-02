# Start image.
# On recent Ubuntu versions, the code gives errors. Not in 2010.
FROM ubuntu:10.04

# Install requirements
RUN apt-get update \
    && apt-get install -y --no-install-recommends swi-prolog

# Copy source inside container
COPY src src

# Optional: cleanup for smaller image
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/

# Startup instructions
WORKDIR src/
CMD prolog -s start.pl
