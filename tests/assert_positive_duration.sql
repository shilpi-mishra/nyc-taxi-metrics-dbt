-- tests/assert_positive_duration.sql

SELECT *
FROM {{ ref('silver_taxi') }}
WHERE trip_duration_mins < 0