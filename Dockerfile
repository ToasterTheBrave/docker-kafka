FROM centos:6

# hostname for consul service
ENV CONSUL_HOST consul

# Java Versions
ENV JAVA_MAJOR 1.8.0
ENV JAVA_MINOR 31-1.b13

# Install preqs
RUN \
	yum update -y && \
	yum clean all && \
	yum -y install \
		java-1.8.0-openjdk-devel.x86_64 \
	# 	s3cmd \
	# 	git \
		tar

# Set Java Home
ENV JAVA_HOME /usr/lib/jvm/jre-1.8.0-openjdk.x86_64

# Install Consul-Template
ENV CT_VER 0.10.0
ENV CT_NAME consul-template_${CT_VER}_linux_amd64
ADD https://github.com/hashicorp/consul-template/releases/download/v${CT_VER}/${CT_NAME}.tar.gz /usr/local/${CT_NAME}.tgz
RUN \
	cd /usr/local/ && \
	tar -zvxf /usr/local/${CT_NAME}.tgz && \
	rm /usr/local/${CT_NAME}.tgz

# Install Kafka
ENV KAFKA_MAJOR 2.10
ENV KAFKA_MINOR 0.8.2.0
ENV KAFKA_NAME kafka_${KAFKA_MAJOR}-${KAFKA_MINOR}
RUN \
	curl http://apache.org/dist/kafka/${KAFKA_MINOR}/kafka_${KAFKA_MAJOR}-${KAFKA_MINOR}.tgz > /usr/local/${KAFKA_NAME}.tgz && \
	cd /usr/local && \
	tar -zvxf /usr/local/${KAFKA_NAME}.tgz && \
	rm /usr/local/${KAFKA_NAME}.tgz

# Copy folders
COPY src /app/src
COPY conf /app/conf
COPY templates /app/templates

# Expose httpd
EXPOSE 2181

# TODO : Volumes for logs


# mount start script
ADD start /sbin/start

# Run start script
ENTRYPOINT ["/sbin/start"]

# Run command
CMD ["bash"]
