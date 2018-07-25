#!/usr/bin/env bash

PGOPTIONS='--client-min-messages=warning'
set -x
set -e

dbname=i2b2

#pmdata
PGOPTIONS="--search_path=$i2b2pm_user"
export PGOPTIONS
psql -q -v ON_ERROR_STOP=1 --username "$i2b2pm_user" --dbname $dbname  <<-EOSQL 
CREATE SCHEMA AUTHORIZATION $i2b2pm_user; 
EOSQL
psql -q -v ON_ERROR_STOP=1 --username "$i2b2pm_user" --dbname $dbname -f "./NewInstall/Pmdata/scripts/create_postgresql_i2b2pm_tables.sql"
psql -q -v ON_ERROR_STOP=1 --username "$i2b2pm_user" --dbname $dbname -f "./NewInstall/Pmdata/scripts/create_postgresql_triggers.sql"
psql -q -v ON_ERROR_STOP=1 --username "$i2b2pm_user" --dbname $dbname -f "./NewInstall/Pmdata/scripts/pm_access_insert_data.sql"

#hivedata
PGOPTIONS="--search_path=$i2b2hive_user"
export PGOPTIONS
psql -q -v ON_ERROR_STOP=1 --username "$i2b2hive_user" --dbname $dbname  <<-EOSQL 
CREATE SCHEMA AUTHORIZATION $i2b2hive_user; 
EOSQL
psql -q -v ON_ERROR_STOP=1 --username "$i2b2hive_user" --dbname $dbname -f "./NewInstall/Hivedata/scripts/create_postgresql_i2b2hive_tables.sql"
psql -q -v ON_ERROR_STOP=1 --username "$i2b2hive_user" --dbname $dbname -f "./NewInstall/Hivedata/scripts/work_db_lookup_postgresql_insert_data.sql"
psql -q -v ON_ERROR_STOP=1 --username "$i2b2hive_user" --dbname $dbname -f "./NewInstall/Hivedata/scripts/ont_db_lookup_postgresql_insert_data.sql"
psql -q -v ON_ERROR_STOP=1 --username "$i2b2hive_user" --dbname $dbname -f "./NewInstall/Hivedata/scripts/crc_db_lookup_postgresql_insert_data.sql"
psql -q -v ON_ERROR_STOP=1 --username "$i2b2hive_user" --dbname $dbname -f "./NewInstall/Hivedata/scripts/im_db_lookup_postgresql_insert_data.sql"

#crcdata
PGOPTIONS="--search_path=$i2b2data_user"
export PGOPTIONS
psql -q -v ON_ERROR_STOP=1 --username "$i2b2data_user" --dbname $dbname  <<-EOSQL 
CREATE SCHEMA AUTHORIZATION $i2b2data_user; 
EOSQL
psql -q -v ON_ERROR_STOP=1 --username "$i2b2data_user" --dbname $dbname -f "./NewInstall/Crcdata/scripts/crc_create_datamart_postgresql.sql"
psql -q -v ON_ERROR_STOP=1 --username "$i2b2data_user" --dbname $dbname -f "./NewInstall/Crcdata/scripts/crc_create_query_postgresql.sql"
psql -q -v ON_ERROR_STOP=1 --username "$i2b2data_user" --dbname $dbname -f "./NewInstall/Crcdata/scripts/crc_create_uploader_postgresql.sql"

find ./NewInstall/Crcdata/scripts/procedures/postgresql/ -name '*.sql' \
	-exec psql -q -v ON_ERROR_STOP=1 --username "$i2b2data_user" --dbname $dbname -f {} \;

find ./NewInstall/Crcdata/scripts/postgresql/ -name '*.sql' \
	-exec psql -q -v ON_ERROR_STOP=0 --username "$i2b2data_user" --dbname $dbname -f {} \;
#imdata
PGOPTIONS="--search_path=$i2b2im_user"
export PGOPTIONS
psql -q -v ON_ERROR_STOP=1 --username "$i2b2im_user" --dbname $dbname  <<-EOSQL 
CREATE SCHEMA AUTHORIZATION $i2b2im_user; 
EOSQL
psql -q -v ON_ERROR_STOP=1 --username "$i2b2im_user" --dbname $dbname -f "./NewInstall/Imdata/scripts/im_create_tables_postgresql.sql"

find ./NewInstall/Imdata/scripts/postgresql/ -name '*.sql' \
	-exec psql -q -v ON_ERROR_STOP=1 --username "$i2b2im_user" --dbname $dbname -f {} \;

#metadata
PGOPTIONS="--search_path=$i2b2meta_user"
export PGOPTIONS
psql -q -v ON_ERROR_STOP=1 --username "$i2b2meta_user" --dbname $dbname  <<-EOSQL 
CREATE SCHEMA AUTHORIZATION $i2b2meta_user; 
EOSQL
psql -q -v ON_ERROR_STOP=1 --username "$i2b2meta_user" --dbname $dbname -f "./NewInstall/Metadata/scripts/create_postgresql_i2b2metadata_tables.sql"
psql -q -v ON_ERROR_STOP=1 --username "$i2b2meta_user" --dbname $dbname -f "./NewInstall/Metadata/demo/scripts/schemes_insert_data.sql"
psql -q -v ON_ERROR_STOP=1 --username "$i2b2meta_user" --dbname $dbname -f "./NewInstall/Metadata/demo/scripts/table_access_insert_data.sql"

find ./NewInstall/Metadata/demo/scripts/postgresql/ -name '*.sql' \
	-exec psql -q -v ON_ERROR_STOP=1 --username "$i2b2meta_user" --dbname $dbname -f {} \;

#workdata
PGOPTIONS="--search_path=$i2b2work_user"
export PGOPTIONS
psql -q -v ON_ERROR_STOP=1 --username "$i2b2work_user" --dbname $dbname  <<-EOSQL 
CREATE SCHEMA AUTHORIZATION $i2b2work_user; 
EOSQL
psql -q -v ON_ERROR_STOP=1 --username "$i2b2work_user" --dbname $dbname -f "./NewInstall/Workdata/scripts/create_postgresql_i2b2workdata_tables.sql"
psql -q -v ON_ERROR_STOP=1 --username "$i2b2work_user" --dbname $dbname -f "./NewInstall/Workdata/scripts/workplace_access_demo_insert_data.sql"
