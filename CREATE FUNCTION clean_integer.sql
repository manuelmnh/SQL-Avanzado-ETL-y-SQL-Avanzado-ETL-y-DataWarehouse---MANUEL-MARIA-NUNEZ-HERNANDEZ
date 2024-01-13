CREATE FUNCTION keepcoding.clean_integer(valor INT64) AS (
  IFNULL(valor, -999999)
);