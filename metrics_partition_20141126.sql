-- Create an empty "master table"; this serves to define the schema
CREATE TABLE  IF NOT EXISTS hyfn8_metrics_metrics (id SERIAL, name varchar, period varchar, key varchar, value_key varchar, value int, recorded_at timestamp, created_at timestamp, updated_at timestamp, PRIMARY KEY (id));
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


CREATE TABLE IF NOT EXISTS metrics_201401 (CHECK (year_month_str(recorded_at)='201401')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201402 (CHECK (year_month_str(recorded_at)='201402')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201403 (CHECK (year_month_str(recorded_at)='201403')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201404 (CHECK (year_month_str(recorded_at)='201404')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201405 (CHECK (year_month_str(recorded_at)='201405')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201406 (CHECK (year_month_str(recorded_at)='201406')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201407 (CHECK (year_month_str(recorded_at)='201407')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201408 (CHECK (year_month_str(recorded_at)='201408')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201409 (CHECK (year_month_str(recorded_at)='201409')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201410 (CHECK (year_month_str(recorded_at)='201410')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201411 (CHECK (year_month_str(recorded_at)='201411')) INHERITS(hyfn8_metrics_metrics);
CREATE TABLE IF NOT EXISTS metrics_201412 (CHECK (year_month_str(recorded_at)='201412')) INHERITS(hyfn8_metrics_metrics);

-- Add some indexes; these can be different for each table
-- CREATE INDEX index_recorded_at_and_key_and_name_on_10_min ON metrics_10_minutes (recorded_at, key, name);
-- CREATE INDEX index_recorded_at_and_key_and_name_on_7_days ON metrics_7_days (recorded_at, key, name);
-- CREATE INDEX index_recorded_at_and_key_and_name_on_28_days ON metrics_28_days (recorded_at, key, name);
-- CREATE INDEX index_recorded_at_and_key_and_name_on_1_days ON metrics_1_days (recorded_at, key, name);
-- CREATE INDEX index_recorded_at_and_key_and_name_on_lifetime ON metrics_lifetime (recorded_at, key, name);

-- CREATE INDEX index_period_recorded_at_key_name_on_metrics ON metrics (period, recorded_at, key, name);
-- CREATE INDEX index_value_key_on_metrics ON metrics (value_key);
-- CREATE INDEX index_recorded_at_on_metrics ON metrics (recorded_at);

CREATE OR REPLACE FUNCTION metrics_datetime_table_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
  EXECUTE format('INSERT INTO (SELECT %I VALUES (NEW.*);', ('metrics_' || year_month_str(NEW.datetime)));
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
