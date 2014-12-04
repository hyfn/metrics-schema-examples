INSERT INTO hyfn8_metrics_metrics (id, name, period, key, value_key, value, recorded_at) (
  SELECT id, name, period, key, value_key, value, recorded_at FROM hyfn8_metrics_metrics
);