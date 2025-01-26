
WITH source_data AS

        (SELECT * FROM {{ source('prod', 'acceptance_report') }})

SELECT

    external_ref
    , status
    , source
    , ref
    , date_time
    , state
    , cvv_provided
    , amount
    , country
    , currency
    , rates
    , {{ exchange_rate_unnest('currency', 'rates') }} AS exchange_rate

FROM source_data