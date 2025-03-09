SELECT * FROM sales_data;

-- Order Date Formatting

SELECT 
	`Order Date`,
	STR_TO_DATE(`Order Date`, '%m/%d/%Y') Formatted_Order_Date
FROM sales_data;

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE sales_data ADD COLUMN Formatted_Order_Date DATE;

UPDATE sales_data 
SET Formatted_Order_Date = STR_TO_DATE(`Order Date`, '%m/%d/%Y');

SET SQL_SAFE_UPDATES = 1;

SELECT Formatted_Order_Date FROM sales_data;

SELECT 
	MIN(Formatted_Order_Date) First_Order_Date,
    MAX(Formatted_Order_Date) Last_Order_Date
FROM sales_data;

SELECT
	`Customer Name`,
	MAX(Formatted_Order_Date) Last_Order_Date
FROM sales_data
GROUP BY `Customer Name`
ORDER BY Last_Order_Date;

-- RFM Segmentation

CREATE OR REPLACE VIEW RFM_SCORE_DATA AS
WITH CUSTOMER_AGGREGATED_DATA AS
(SELECT
	`Customer Name`,
    DATEDIFF((SELECT MAX(Formatted_Order_Date) FROM sales_data), MAX(Formatted_Order_Date)) AS RECENCY_VALUE,
    COUNT(DISTINCT `Order ID`) AS FREQUENCY_VALUE,
    ROUND(SUM(Sales),0) AS MONETARY_VALUE
FROM sales_data
GROUP BY `Customer Name`),

RFM_SCORE AS
(SELECT 
	C.*,
    NTILE(4) OVER (ORDER BY RECENCY_VALUE DESC) AS R_SCORE,
    NTILE(4) OVER (ORDER BY FREQUENCY_VALUE ASC) AS F_SCORE,
    NTILE(4) OVER (ORDER BY MONETARY_VALUE ASC) AS M_SCORE
FROM CUSTOMER_AGGREGATED_DATA AS C)

SELECT
	R.`Customer Name`,
    R.RECENCY_VALUE,
    R_SCORE,
    R.FREQUENCY_VALUE,
    F_SCORE,
    R.MONETARY_VALUE,
    M_SCORE,
    (R_SCORE + F_SCORE + M_SCORE) AS TOTAL_RFM_SCORE,
    CONCAT_WS('', R_SCORE, F_SCORE, M_SCORE) AS RFM_SCORE_COMBINATION
FROM RFM_SCORE AS R;

SELECT * FROM RFM_SCORE_DATA;

CREATE OR REPLACE VIEW RFM_ANALYSIS AS
SELECT 
    RFM_SCORE_DATA.*,
    CASE
        WHEN RFM_SCORE_COMBINATION IN (111, 112, 121, 132, 211, 211, 212, 114, 141) THEN 'CHURNED CUSTOMER'
        WHEN RFM_SCORE_COMBINATION IN (133, 134, 143, 224, 334, 343, 344, 144) THEN 'SLIPPING AWAY, CANNOT LOSE'
        WHEN RFM_SCORE_COMBINATION IN (311, 411, 331) THEN 'NEW CUSTOMERS'
        WHEN RFM_SCORE_COMBINATION IN (222, 231, 221,  223, 233, 322) THEN 'POTENTIAL CHURNERS'
        WHEN RFM_SCORE_COMBINATION IN (323, 333,321, 341, 422, 332, 432) THEN 'ACTIVE'
        WHEN RFM_SCORE_COMBINATION IN (433, 434, 443, 444) THEN 'LOYAL'
    ELSE 'Other'
    END AS CUSTOMER_SEGMENT
FROM RFM_SCORE_DATA;

SELECT
	CUSTOMER_SEGMENT,
    COUNT(*) AS NUMBER_OF_CUSTOMERS,
    ROUND(AVG(MONETARY_VALUE),0) AS AVERAGE_MONETARY_VALUE
FROM RFM_ANALYSIS
GROUP BY CUSTOMER_SEGMENT;
