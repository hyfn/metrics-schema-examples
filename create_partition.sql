CREATE TABLE  IF NOT EXISTS hyfn8_metrics_metrics (id SERIAL, name varchar, period varchar, key varchar, value_key varchar, value int, recorded_at timestamp, PRIMARY KEY (id));

CREATE OR REPLACE FUNCTION year_month_str(timestamptz) 
RETURNS text 
AS $$
  SELECT concat(DATE_PART('year', $1), lpad(text(DATE_PART('month', $1)), 2, '0')) 
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION lower_bound_date()
RETURNS timestamptz
AS $$
  SELECT CURRENT_TIMESTAMP
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION upper_bound_date()
RETURNS timestamptz
AS $$
  SELECT CURRENT_TIMESTAMP + '1 month':: INTERVAL;
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION oldest_partition()
RETURNS regclass
AS $$
  SELECT i.inhrelid::regclass AS child FROM pg_inherits i WHERE i.inhparent = 'hyfn8_metrics_metrics'::regclass ORDER BY i.inhrelid::regclass ASC LIMIT 1
$$ 
LANGUAGE SQL;

DO
$$
DECLARE
  partition_table_name text := quote_ident('metrics_' || year_month_str(lower_bound_date()));
  lower_bound_str text := to_char(lower_bound_date(), 'YYYY-MM-DD');
  upper_bound_str text := to_char(upper_bound_date(), 'YYYY-MM-DD');
BEGIN
  EXECUTE format('CREATE TABLE IF NOT EXISTS %I (CHECK (%I >= %L AND %I < %L)) INHERITS (hyfn8_metrics_metrics)', partition_table_name, 'recorded_at', lower_bound_str, 'recorded_at', upper_bound_str);
END;
$$ LANGUAGE plpgsql;