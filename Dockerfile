FROM ruppdog/base:0.0.1

# Install Java
RUN apk --update add openjdk8-jre

# Install Kafka
ENV KAFKA_MAJOR 2.11
ENV KAFKA_MINOR 0.10.0.0
ENV KAFKA_NAME kafka_${KAFKA_MAJOR}-${KAFKA_MINOR}
RUN \
    wget http://apache.org/dist/kafka/${KAFKA_MINOR}/${KAFKA_NAME}.tgz && \
    tar -C /app -xzvf ${KAFKA_NAME}.tgz && \
    rm ${KAFKA_NAME}.tgz

# Copy templates
COPY templates /app/templates

# Set up entrypoint
ADD entrypoint.sh /sbin/entrypoint.sh
ENTRYPOINT ["/sbin/entrypoint.sh"]

# Set working directory
WORKDIR /app/${KAFKA_NAME}/

# Run command
CMD ["bin/kafka-server-start.sh", "config/server.properties"]
