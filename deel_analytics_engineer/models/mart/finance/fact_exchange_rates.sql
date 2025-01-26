WITH base AS (

    SELECT * FROM {{ ref('stage_acceptance_report') }}

)

, deduped AS (

SELECT DISTINCT

    DATE_TRUNC(date_time, day) AS date_day
    , currency AS payment_currency
    , 'USD' AS base_currency
    , exchange_rate

FROM base

)


SELECT
    {{ dbt_utils.generate_surrogate_key(['date_day', 'base_currency', 'payment_currency']) }} 
        AS PK_DIM_CURRENCY_CONVERSION
    , *
FROM
    deduped