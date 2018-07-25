#!/usr/bin/env bash

set -e

dbname=i2b2

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE $dbname;
    
    CREATE USER $i2b2data_user WITH PASSWORD '$i2b2data_pass';
    -- CREATE DATABASE $i2b2data_user;
    GRANT ALL PRIVILEGES ON DATABASE $dbname TO $i2b2data_user;

    CREATE USER $i2b2pm_user WITH PASSWORD '$i2b2pm_pass';
    -- CREATE DATABASE $i2b2pm_user;
    GRANT ALL PRIVILEGES ON DATABASE $dbname TO $i2b2pm_user;

    CREATE USER $i2b2hive_user WITH PASSWORD '$i2b2hive_pass';
    -- CREATE DATABASE $i2b2hive_user;
    GRANT ALL PRIVILEGES ON DATABASE $dbname TO $i2b2hive_user;

    CREATE USER $i2b2im_user WITH PASSWORD '$i2b2im_pass';
    -- CREATE DATABASE $i2b2im_user;
    GRANT ALL PRIVILEGES ON DATABASE $dbname TO $i2b2im_user;

    CREATE USER $i2b2meta_user WITH PASSWORD '$i2b2meta_pass';
    -- CREATE DATABASE $i2b2meta_user;
    GRANT ALL PRIVILEGES ON DATABASE $dbname TO $i2b2meta_user;

    CREATE USER $i2b2work_user WITH PASSWORD '$i2b2work_pass';
    -- CREATE DATABASE $i2b2work_user;
    GRANT ALL PRIVILEGES ON DATABASE $dbname TO $i2b2work_user;
EOSQL
