FROM library/postgres
ENV BUILD_HOME=/opt/build
ENV ENTRY_HOME=docker-entrypoint-initdb.d

ARG I2B2_VERSION=v1.7.10.0002

ENV db_driver=org.postgresql.Driver
ENV db_type=postgresql
ENV db_url=jdbc:postgresql://localhost:5432

ENV i2b2data_user=i2b2data
ENV i2b2data_pass=demouser
ENV i2b2pm_user=i2b2pm
ENV i2b2pm_pass=demouser
ENV i2b2hive_user=i2b2hive
ENV i2b2hive_pass=demouser
ENV i2b2im_user=i2b2im
ENV i2b2im_pass=demouser
ENV i2b2meta_user=i2b2meta
ENV i2b2meta_pass=demouser
ENV i2b2work_user=i2b2work
ENV i2b2work_pass=demouser

WORKDIR $BUILD_HOME
RUN mkdir -p $BUILD_HOME
RUN apt-get update && apt-get install -y --no-install-recommends \
		curl ca-certificates \
	&& rm -rf /var/lib/apt/lists/*
RUN curl -L https://github.com/i2b2/i2b2-data/archive/$I2B2_VERSION.tar.gz -o i2b2-data.tar.gz \
	&& tar -xzf i2b2-data.tar.gz --strip 3 \
	&& rm i2b2-data.tar.gz
COPY ./$ENTRY_HOME /$ENTRY_HOME

