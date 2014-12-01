metrics-schema-examples
=======================

Getting Started
---------------
````
dropdb metrics_partition_20141126
createdb metrics_partition_20141126
psql -d metrics_partition_20141126 < metrics_partition_20141126.sql
psql -d metrics_partition_20141126 -c "COPY hyfn8_metrics_metrics FROM '/full/path/to/sample.csv' WITH CSV HEADER";
````