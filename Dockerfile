FROM library/postgres
ENV BUILD_HOME=/opt/build
ENV ENTRY_HOME=docker-entrypoint-initdb.d

RUN mkdir -p $BUILD_HOME
WORKDIR $BUILD_HOME

ARG I2B2_VERSION

RUN apt-get update && apt-get install -y --no-install-recommends \
		curl ca-certificates \
	&& rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/i2b2/i2b2-data/archive/$I2B2_VERSION.tar.gz -o i2b2-data.tar.gz
RUN tar -xzf i2b2-data.tar.gz --strip 3

COPY ./$ENTRY_HOME /$ENTRY_HOME

