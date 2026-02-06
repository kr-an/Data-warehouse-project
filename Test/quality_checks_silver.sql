/*
=======================================================================
Quality Checks
=======================================================================

Script Purpose:
    This script performs various quality checks for data consistency, accuracy,
    and standardization across the "silver" schemas. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
=======================================================================
*/

--check for null or duplicate in primary ; 
SELECT 
cst_id, count (*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT (*) > 1 OR cst_id IS NULL;

-- cHECK for unwanted spaces
-- epecting result : 0
SELECT cst_firstname
from silver.crm_cust_info
WHERE cst_firstname != TRIM (cst_firstname);

-- DATA STANDARDIZATION & CONSISTENCY

SELECT DISTINCT cst_gender
FROM  silver.crm_cust_info;


-- Check For Nulls or Duplicates in Primary Key
-- Expectation: No Result

SELECT
    prd_id,
    COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- check unwanted spaces 
--expectation: no result

SELECT prd_nm
from silver.crm_prd_info
where prd_nm != TRIM (prd_nm);

-- check for number quality for he NULL & _ve numbers
--expect no result ;

select prd_cost
FROM silver.crm_prd_info
where prd_cost < 0 OR prd_cost IS  NULL;

-- chaecking data standarization and consistency;
SELECT DISTINCT prd_line
FROM silver.crm_cust_info;

-- check for the invalid date orders
SELECT 
* 
from bronze.crm_prd_info
where prd_end_dt < prd_start_dt;
 
