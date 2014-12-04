-- Create an empty "master table"; this serves to define the schema
CREATE TABLE  IF NOT EXISTS hyfn8_metrics_metrics (id SERIAL, name varchar, period varchar, key varchar, value_key varchar, value int, recorded_at timestamp, PRIMARY KEY (id));
-- CREATE TABLE IF NOT EXISTS metrics (LIKE hyfn8_metrics_metrics);

-- Create two tables with constraints that "inherit" from the master table;
-- this means if we 'SELECT * FROM metrics' we are querying both tables:
-- CREATE TABLE IF NOT EXISTS metrics_1_hour (CHECK (period='1_hour')) INHERITS (hyfn8_metrics_metrics);
-- CREATE TABLE IF NOT EXISTS metrics_7_days (CHECK (period NOT IN ('7_days', 'weekly'))) INHERITS (hyfn8_metrics_metrics);
-- CREATE TABLE IF NOT EXISTS metrics_28_days (CHECK (period IN ('28_days', 'monthly'))) INHERITS (hyfn8_metrics_metrics);
-- CREATE TABLE IF NOT EXISTS metrics_1_days (CHECK (period IN ('1_days', 'daily'))) INHERITS (hyfn8_metrics_metrics);
-- CREATE TABLE IF NOT EXISTS metrics_lifetime (CHECK (period='lifetime')) INHERITS (hyfn8_metrics_metrics);

CREATE OR REPLACE FUNCTION year_month_str(timestamp) 
RETURNS text 
AS $$
  SELECT concat(DATE_PART('year', $1), lpad(text(DATE_PART('month', $1)), 2, '0')) 
$$
LANGUAGE SQL;

-- 2013
CREATE TABLE IF NOT EXISTS metrics_201301 (CHECK (recorded_at >= DATE '2013-01-01' AND recorded_at < DATE '2013-02-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201302 (CHECK (recorded_at >= DATE '2013-02-01' AND recorded_at < DATE '2013-03-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201303 (CHECK (recorded_at >= DATE '2013-03-01' AND recorded_at < DATE '2013-04-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201304 (CHECK (recorded_at >= DATE '2013-04-01' AND recorded_at < DATE '2013-05-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201305 (CHECK (recorded_at >= DATE '2013-05-01' AND recorded_at < DATE '2013-06-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201306 (CHECK (recorded_at >= DATE '2013-06-01' AND recorded_at < DATE '2013-07-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201307 (CHECK (recorded_at >= DATE '2013-07-01' AND recorded_at < DATE '2013-08-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201308 (CHECK (recorded_at >= DATE '2013-08-01' AND recorded_at < DATE '2013-09-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201309 (CHECK (recorded_at >= DATE '2013-09-01' AND recorded_at < DATE '2013-10-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201310 (CHECK (recorded_at >= DATE '2013-10-01' AND recorded_at < DATE '2013-11-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201311 (CHECK (recorded_at >= DATE '2013-11-01' AND recorded_at < DATE '2013-12-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201312 (CHECK (recorded_at >= DATE '2013-12-01' AND recorded_at < DATE '2015-01-01')) INHERITS(hyfn8_metrics_metrics);

-- Add some indexes; these can be different for each table
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201301 ON metrics_201301 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201302 ON metrics_201302 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201303 ON metrics_201303 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201304 ON metrics_201304 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201305 ON metrics_201305 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201306 ON metrics_201306 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201307 ON metrics_201307 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201308 ON metrics_201308 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201309 ON metrics_201309 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201310 ON metrics_201310 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201311 ON metrics_201311 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201312 ON metrics_201312 (recorded_at, key, name);

-- 2014
CREATE TABLE IF NOT EXISTS metrics_201401 (CHECK (recorded_at >= DATE '2014-01-01' AND recorded_at < DATE '2014-02-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201402 (CHECK (recorded_at >= DATE '2014-02-01' AND recorded_at < DATE '2014-03-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201403 (CHECK (recorded_at >= DATE '2014-03-01' AND recorded_at < DATE '2014-04-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201404 (CHECK (recorded_at >= DATE '2014-04-01' AND recorded_at < DATE '2014-05-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201405 (CHECK (recorded_at >= DATE '2014-05-01' AND recorded_at < DATE '2014-06-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201406 (CHECK (recorded_at >= DATE '2014-06-01' AND recorded_at < DATE '2014-07-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201407 (CHECK (recorded_at >= DATE '2014-07-01' AND recorded_at < DATE '2014-08-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201408 (CHECK (recorded_at >= DATE '2014-08-01' AND recorded_at < DATE '2014-09-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201409 (CHECK (recorded_at >= DATE '2014-09-01' AND recorded_at < DATE '2014-10-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201410 (CHECK (recorded_at >= DATE '2014-10-01' AND recorded_at < DATE '2014-11-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201411 (CHECK (recorded_at >= DATE '2014-11-01' AND recorded_at < DATE '2014-12-01')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201412 (CHECK (recorded_at >= DATE '2014-12-01' AND recorded_at < DATE '2015-01-01')) INHERITS(hyfn8_metrics_metrics);

-- Add some indexes; these can be different for each table
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201401 ON metrics_201401 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201402 ON metrics_201402 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201403 ON metrics_201403 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201404 ON metrics_201404 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201405 ON metrics_201405 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201406 ON metrics_201406 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201407 ON metrics_201407 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201408 ON metrics_201408 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201409 ON metrics_201409 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201410 ON metrics_201410 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201411 ON metrics_201411 (recorded_at, key, name);
CREATE INDEX index_recorded_at_and_key_and_name_on_metrics_201412 ON metrics_201412 (recorded_at, key, name);

CREATE OR REPLACE FUNCTION metrics_datetime_table_insert_trigger()
RETURNS TRIGGER AS $$
DECLARE
  partition_table_name text := quote_ident('metrics_' || year_month_str(NEW.recorded_at));
BEGIN
  EXECUTE 'INSERT INTO ' || partition_table_name || ' VALUES ($1, $2, $3, $4, $5, $6, $7)' USING NEW.id, NEW.name, NEW.period, NEW.key, NEW.value_key, NEW.value, NEW.recorded_at;
  RETURN null;
END
$$
LANGUAGE plpgsql;

-- CREATE TRIGGER insert_metrics_trigger
--     BEFORE INSERT ON hyfn8_metrics_metrics
--     FOR EACH ROW EXECUTE PROCEDURE metrics_datetime_table_insert_trigger();


-- CREATE OR REPLACE FUNCTION metrics_insert_trigger()
-- RETURNS TRIGGER AS $$
-- BEGIN
--   IF (NEW.period = '10_minutes') THEN
--     INSERT INTO metrics_10_minutes VALUES (NEW.*);
--   ELSIF (NEW.period IN ('7_days', 'weekly')) THEN
--     INSERT INTO metrics_7_days VALUES (NEW.*);
--   ELSIF (NEW.period IN ('28_days', 'monthly')) THEN
--     INSERT INTO metrics_28_days VALUES (NEW.*);
--   ELSIF (NEW.period IN ('1_days', 'daily')) THEN
--     INSERT INTO metrics_1_days VALUES (NEW.*);
--   ELSIF (NEW.period = 'lifetime') THEN
--     INSERT INTO metrics_lifetime VALUES (NEW.*);
--   END IF;
--   RETURN null;
-- END
-- $$
-- language plpgsql;

-- Add a trigger to run the function whenever we try to INSERT to metrics
CREATE TRIGGER insert_metrics_trigger
    BEFORE INSERT ON hyfn8_metrics_metrics
    FOR EACH ROW EXECUTE PROCEDURE metrics_datetime_table_insert_trigger();
