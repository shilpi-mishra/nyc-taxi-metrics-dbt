{{ config(materialized='table') }}

SELECT *
FROM {{ source('nyc_taxi_source', 'trips') }}