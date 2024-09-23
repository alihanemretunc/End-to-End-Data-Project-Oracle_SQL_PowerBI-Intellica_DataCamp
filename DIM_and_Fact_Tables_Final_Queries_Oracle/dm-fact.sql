-- FACT TABLE
SELECT 
    M.LOAN_DT AS AS_OF_DATE,
    M.CTR_ID AS IDV_LOAN_CONTRACT_ID,
    M.CTR_ST_ID AS IDV_LOAN_CONTRACT_STATUS_ID,
    M.CTR_TYP_ID AS IDV_LOAN_CONTRACT_TYPE_ID,
    M.PD_ID AS PRODUCT_ID,
    (
    SELECT M.LOAN_AMT * L.EXG_BUY_PRTY AS CALCULATED_AMOUNT
    FROM INT.DW_IDV_CTR_LOAN M
    LEFT JOIN INT.DW_EXG_RATE L ON L.ccy_id = M.ccy_id
    WHERE 
    TRUNC(L.EXG_RATE_DT) = M.LOAN_DT 
    ) AS IDV_LOAN_AMOUNT_TRL,   -- SHOULD BE VALIDATED
    M.LOAN_AMT AS IDV_LOAN_AMOUNT,
    M.BR_ID AS IDV_LOAN_BRANCH_ID,
    M.CTR_END_DT AS IDV_LOAN_MATURITY_DATE,
    M.CUST_ID AS IDV_CUSTOMER_ID,
    L1.CUST_NO AS IDV_CUSTOMER_NUMBER,
    M.CCY_ID AS CURRENCY_ID,
    M.CTR_START_DT AS IDV_LOAN_CONTRACT_START_DATE,
    M.CTR_START_DT AS IDV_LOAN_CONTRACT_VALUE_DATE,
    M.CTR_END_DT AS IDV_LOAN_CONTRACT_END_DATE,
    M.IDV_APP_ID AS IDV_APPLICATION_ID,
    L2.CNL_ID AS IDV_LOAN_CHANNEL_ID,
    SYSDATE AS ETL_DATE
FROM
    INT.DW_IDV_CTR_LOAN M
LEFT JOIN INT.DW_CUST L1 ON L1.PARTY_ID = M.CUST_ID
LEFT JOIN INT.DW_IDV_APP L2 ON L2.IDV_APP_ID = M.IDV_APP_ID