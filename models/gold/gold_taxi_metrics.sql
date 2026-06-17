-- THIS is the semantic layer.
-- Downstream BI tools, dashboards, and analysts
-- query THIS view — never the raw or silver tables.

{{ config(materialized='view') }}
SELECT
    DATE(pickup_time)                               AS trip_date,
    HOUR(pickup_time)                               AS trip_hour,
-- Volume metrics
    COUNT(*)                                        AS total_trips,
-- Revenue metrics    
    ROUND(AVG(fare_amount),          2)            AS avg_fare_amount,
-- Efficiency metrics
    ROUND(AVG(trip_distance),         2)            AS avg_distance_miles,
    ROUND(AVG(trip_duration_mins),    2)            AS avg_duration_mins,
    ROUND(
        SUM(fare_amount) /
        NULLIF(SUM(trip_distance), 0), 2)           AS revenue_per_mile
FROM {{ ref('silver_taxi') }}
GROUP BY
    DATE(pickup_time),
    HOUR(pickup_time)
