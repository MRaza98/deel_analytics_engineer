
WITH source_data AS

        (SELECT * FROM {{ source('prod', 'chargeback_report') }})

SELECT

    external_ref
    , status 
    , source 
    , chargeback

FROM source_data