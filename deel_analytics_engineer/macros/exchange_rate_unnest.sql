{% macro exchange_rate_unnest(currency_code, column_name) %}

CASE 
    WHEN LOWER(currency) = 'eur' THEN CAST(JSON_EXTRACT_SCALAR({{column_name}}, '$.EUR') AS FLOAT64)
    WHEN LOWER(currency) = 'cad' THEN CAST(JSON_EXTRACT_SCALAR({{column_name}}, '$.CAD') AS FLOAT64)
    WHEN LOWER(currency) = 'mxn' THEN CAST(JSON_EXTRACT_SCALAR({{column_name}}, '$.MXN') AS FLOAT64)
    WHEN LOWER(currency) = 'aud' THEN CAST(JSON_EXTRACT_SCALAR({{column_name}}, '$.AUD') AS FLOAT64)
    WHEN LOWER(currency) = 'sgd' THEN CAST(JSON_EXTRACT_SCALAR({{column_name}}, '$.SGD') AS FLOAT64)
    WHEN LOWER(currency) = 'usd' THEN CAST(JSON_EXTRACT_SCALAR({{column_name}}, '$.USD') AS FLOAT64)
    WHEN LOWER(currency) = 'gbp' THEN CAST(JSON_EXTRACT_SCALAR({{column_name}}, '$.GBP') AS FLOAT64)

END

{% endmacro %}