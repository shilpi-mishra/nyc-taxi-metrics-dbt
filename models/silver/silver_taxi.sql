-- silver_taxi.sql
-- Clean, filter, rename, cast.
-- This is your trusted, queryable layer.
{{ config(materialized='table') }}
SELECT
    CAST(tpep_pickup_datetime  AS TIMESTAMP)  AS pickup_time,
    CAST(tpep_dropoff_datetime AS TIMESTAMP)  AS dropoff_time,
    CAST(trip_distance         AS DOUBLE)     AS trip_distance,
    CAST(fare_amount           AS DOUBLE)     AS fare_amount,
    CAST(pickup_zip          AS INT)        AS pickup_location_id,
    CAST(dropoff_zip          AS INT)        AS dropoff_location_id,
-- Derived columns
    ROUND(
        (UNIX_TIMESTAMP(tpep_dropoff_datetime)
       - UNIX_TIMESTAMP(tpep_pickup_datetime)) / 60.0,
    2)                                        AS trip_duration_mins
FROM {{ ref('bronze_taxi') }}
-- Data quality filters
WHERE fare_amount    > 0
  AND trip_distance  > 0
  AND tpep_pickup_datetime  >= '2019-12-01'
  AND tpep_pickup_datetime  <  '2020-01-01'
