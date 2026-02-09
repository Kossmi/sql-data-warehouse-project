/*
=========================================================================================
Quality Checks
=========================================================================================
Script Purpose:
  This script performs various quality checks for data consistency, accuracy
  and standardization across the 'silver' schemas. It includes checks for:
  -Null or duplicate primary keys.
  -Unwanted spaces in string fields.
  -Data standardization and consistency.
  -Invalid date ranges and orders.
  -Data consistency between related fields.

Usage Notes:
  -Run these checks after data loading Silver Layer.
  -Investigate and resolve any discrepancies found during the checks.
========================================================================================
*/

--SILVER LAYER CRM_CUST_INFO TABLE QUALITY CHECKS

-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No result

SELECT
cst_id,
COUNT(*)
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

--Check for unwanted spaces
--Expectation: No results
SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

--Data Standardization & Consistency Check
SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info

SELECT *
FROM silver.crm_cust_info
WHERE cst_id IS NOT NULL;

--SILVER LAYER CRM_PRD_INFO TABLE QUALITY CHECKS

-- Check For Nulls or Duplicates in Primary Key
--Expectation: No result

SELECT
prd_id,
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

--Check for unwanted spaces
--Expectation: No results

SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm  != TRIM(prd_nm);

--Check for NULLs or Negative values in prd_cost
--Expectation: No Results

SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

--Data Standardization & Consistency Check

SELECT DISTINCT prd_line
FROM bronze.crm_prd_info;

--Check for Invalid Date Orders
SELECT * 
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

--Quality Checks
--Check For NULLs or Duplicates in Primary Key
--Expectation: No Results

SELECT
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

--Check for Unwanted Spaces
--Expectation: No Results

SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

--Check for NULLs or Negative Values in prd_cost
--Expectation: No Results

SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

--Data Standardization & Consistency Check

SELECT DISTINCT prd_line
FROM silver.crm_prd_info;

--Check for Invalid Date Orders

SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

--SILVER LAYER CRM_SALES_DETAILS TABLE QUALITY CHECKS

--Check For Invalid Dates

SELECT sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0 
OR LEN(sls_order_dt) != 8
OR sls_order_dt > 20500101
OR sls_order_dt < 19000101;

SELECT sls_ship_dt
FROM bronze.crm_sales_details
WHERE sls_ship_dt <= 0 
OR LEN(sls_ship_dt) != 8
OR sls_ship_dt > 20500101
OR sls_ship_dt < 19000101;

SELECT sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0 
OR LEN(sls_due_dt) != 8
OR sls_due_dt > 20500101
OR sls_due_dt < 19000101;

SELECT *
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt OR sls_ship_dt > sls_due_dt;

--Check Data Consistency: Between Sales, Quantity and Price
-- Sales = Quantity * Price
-- Values must not be NULL, zero or negative

SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <=0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

--Quality Checks

--Check for Invalid Date Orders

SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;

--Check Data Consistency Between Sales, Quantity and Price

SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales  <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

SELECT * FROM silver.crm_sales_details;

--SILVER LAYER ERP_CUST_AZ12 TABLE QUALITY CHECKS

--Data Standardization & Consistency Check

SELECT DISTINCT gen
FROM bronze.erp_cust_az12;

--Quality Checks

SELECT DISTINCT
bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE();

SELECT DISTINCT
gen
FROM silver.erp_cust_az12;

SELECT * FROM silver.erp_cust_az12;

--SILVER LAYER ERP_LOC_A101 TABLE QUALITY CHECKS

--Data Standardization & Consistency Check

SELECT DISTINCT cntry
FROM bronze.erp_loc_a101
ORDER BY cntry;

--Quality Checks

SELECT DISTINCT
cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

SELECT *
FROM silver.erp_loc_a101;

--SILVER LAYER ERP_PX_CAT_G1V2 TABLE QUALITY CHECKS

--Check For Unwanted Spaces
SELECT * FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance);

--Data Standardization & Consistency Check

SELECT DISTINCT
cat
FROM bronze.erp_px_cat_g1v2;

SELECT DISTINCT
subcat
FROM bronze.erp_px_cat_g1v2;

SELECT DISTINCT
maintenance
FROM bronze.erp_px_cat_g1v2;

SELECT * FROM silver.erp_px_cat_g1v2;
