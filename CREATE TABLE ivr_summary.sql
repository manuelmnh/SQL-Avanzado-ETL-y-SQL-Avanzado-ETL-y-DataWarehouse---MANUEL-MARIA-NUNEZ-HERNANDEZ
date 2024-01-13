CREATE TABLE keepcoding.ivr_summary AS
SELECT
    calls_ivr_id AS ivr_id,
    calls_phone_number AS phone_number,
    calls_ivr_result AS ivr_result,
    CASE
        WHEN calls_vdn_label LIKE 'ATC%' THEN 'FRONT'
        WHEN calls_vdn_label LIKE 'TECH%' THEN 'TECH'
        WHEN calls_vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
        ELSE 'RESTO'
    END AS vdn_aggregation,
    calls_start_date AS start_date,
    calls_end_date AS end_date,
    calls_total_duration AS total_duration,
    calls_customer_segment AS customer_segment,
    calls_ivr_language AS ivr_language,
    calls_steps_module AS steps_module,
    calls_module_aggregation AS module_aggregation,
    document_type,
    document_identification,
    customer_phone,
    billing_account_id,
    MAX(CASE WHEN module_name = 'AVERIA_MASIVA' THEN 1 ELSE 0 END) AS masiva_lg,
    MAX(CASE WHEN step_name = 'CUSTOMERINFOBYPHONE.TX' AND step_description_error IS NULL THEN 1 ELSE 0 END) AS info_by_phone_lg,
    MAX(CASE WHEN step_name = 'CUSTOMERINFOBYDNI.TX' AND step_description_error IS NULL THEN 1 ELSE 0 END) AS info_by_dni_lg,
    MAX(CASE WHEN calls_start_date BETWEEN TIMESTAMP_SUB(calls_start_date, INTERVAL 1 DAY) AND calls_start_date THEN 1 ELSE 0 END) AS repeated_phone_24H,
    MAX(CASE WHEN calls_end_date BETWEEN calls_end_date AND TIMESTAMP_ADD(calls_end_date, INTERVAL 1 DAY) THEN 1 ELSE 0 END) AS cause_recall_phone_24H
FROM
    keepcoding.ivr_details
GROUP BY
    ivr_id, phone_number, ivr_result, vdn_aggregation, start_date, end_date, total_duration, customer_segment, ivr_language, steps_module, module_aggregation, document_type, document_identification, customer_phone, billing_account_id;
