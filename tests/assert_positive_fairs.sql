-- This test FAILS if any negative fares exist
-- dbt expects zero rows returned = test passes

SELECT *
FROM {{ ref('silver_taxi') }}
WHERE fare_amount < 0