# Superstore Sales Data Analysis

## Overview
RFM Segmentation and Exploratory Data Analysis of Superstore Sales Data using MySQL.

## RFM Segmentation
RFM segmentation is a data-driven customer segmentation technique. It helps businesses to identify valuable customers based on their purchasing behavior.

## RFM
- `Recency (R)`: How recently a customer made a purchase.
- `Frequency (F)`: How often a customer makes purchases.
- `Monetary (M)`: How much money a customer spends.

## Files
- `Superstore Sales Data.csv`: The superstore sales data
- `EDA.sql`: Exploratory Data Analysis SQL script
- `RFM Segmentation.sql`: RFM Segmentation SQL script

## Calculate RFM Scores
- `Recency:` Days since the last purchase.
- `Frequency:` Total number of purchases.
- `Monetary:` Total spending amount.

Assign Scores
Rank customers on a scale (e.g., 1-5) for each RFM metric. Higher values mean better customers:
- _Recency:_ Lower values get higher scores (more recent purchases are better).
- _Frequency:_ Higher values get higher scores (frequent buyers are better).
- _Monetary:_ Higher values get higher scores (large spenders are better).

Combining RFM scores (e.g., R=5, F=5, M=5 means a top-tier customer) customer segments can be:
- _LOYAL CUSTOMERS_
- _ACTIVE CUSTOMERS_
- _NEW CUSTOMERS_
- _POTENTIAL CHURNERS_
- _SLIPPING AWAY_
- _CHURNED CUSTOMERS_

## Benefits of RFM Segmentation
- Improves customer retention by identifying at-risk customers.
- Helps personalize marketing campaigns.
- Identifies high-value customers.
