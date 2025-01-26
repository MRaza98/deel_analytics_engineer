WITH acceptance_report AS (

    SELECT * FROM {{ ref('stage_acceptance_report')}}

)

, chargeback_report AS (

    SELECT * FROM {{ ref('stage_chargeback_report') }}

)

, fact_exchange_rates AS (

    SELECT * FROM {{ ref('fact_exchange_rates') }}
)

, consolidated AS (

    SELECT
        DATE_TRUNC(acceptance_report.date_time, day) AS date_day
        , acceptance_report.external_ref
        , acceptance_report.status
        , acceptance_report.source
        , acceptance_report.ref
        , acceptance_report.date_time
        , acceptance_report.state
        , acceptance_report.cvv_provided
        , acceptance_report.amount
        , acceptance_report.country
        , acceptance_report.currency
        , chargeback_report.chargeback
    FROM acceptance_report
    LEFT JOIN chargeback_report USING (external_ref)
)

, currency_converted AS (

    SELECT
        consolidated.*
        , fact_exchange_rates.base_currency
        , ROUND(consolidated.amount / fact_exchange_rates.exchange_rate, 2) AS amount_USD
    FROM consolidated
    LEFT JOIN fact_exchange_rates ON
        consolidated.currency = fact_exchange_rates.payment_currency
        AND consolidated.date_day = fact_exchange_rates.date_day

)

SELECT
    {{ dbt_utils.generate_surrogate_key(['external_ref']) }} as PK_FACT_TRANSACTIONS
    , external_ref
    , status
    , source
    , ref
    , date_time
    , date_day
    , state
    , cvv_provided
    , country
    , currency AS payment_currency
    , amount AS payment_currency_amount
    , base_currency
    , amount_USD
    , chargeback
FROM
    currency_converted








