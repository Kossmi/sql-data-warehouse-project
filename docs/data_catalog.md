# Overview

 The Gold Layer is the business-level data representation, structured to support analytical and reporting use cases. It consists of **dimension tables** and **fact tables** for specific business metrics.

------------------------------------------------------------------------------
### gold.dim_customers

* **Purpose**: Stores customer details enriched with demographic and geographic data.
* **Columns:**
  

  Column Name | Data Type | Description
  --- | --- | ---
  customer_key | INT | Surogate key uniquely identifying each customer record in the dimension table.
  customer_id | INT | Unique numerical identifier assigned to each customer.
  customer_number | NVARCHAR(50) | Alphanumeric identifier representing the customer, used for tracking and referencing.
  first_name | NVARCHAR(50) | The customer's first name, as recorded in the system.
  last_name | NVARCHAR(50) | The customer's last name or family name.
  country | NVARCHAR(50) | The country of residence for the customer (e.g., 'Australia').
  marital_status | NVARCHAR(50) | The marital status of the customer (e.g., 'Married', 'Single').
  gender | NVARCHAR(50) | The gender of the customer (e.g., 'Male', 'Female', 'Unknown').
  birthdate | DATE | The date of birth of the customer, formatted as YYYY-MM-DD (e.g., 1971-10-06).
  create_date | DATE | The date and time when the customer record was created in the system.

  --------------------------------------------------------------------------------
  
  ### gold.dim_products

* **Purpose:** Provides information about the products and their attributes.
* **Columns:**
    
 
    Column Name | Data Type | Description
    --- | --- | ---
    product_key | INT | Surogate key uniquely identifying each product record in the dimension table.
    product_id | INT | Unique numerical identifier assigned to each product.
    product_number | NVARCHAR(50) | Unique alphanumeric identifier assigned to each product.
    product_name | NVARCHAR(50) | Name of the product.
    category_id | NVARCHAR(50) | Category of the product (e.g., 'BI_RB').
    category | NVARCHAR(50) | General name of product's type (e.g., 'Bikes').
    subcategory | NVARCHAR(50) | Specific name for different groups of products inside each category (e.g., 'Brakes').
    maintenance | NVARCHAR(50) | Information about maintenance option (e.g., 'Yes', 'No').
    cost | INT | Cost of a single product.
    product_line | NVARCHAR(50) | Line of products (e.g., 'Mountain', 'Sport', 'Unknown').
    start_date | DATE | Production start date, formatted as YYYY-MM-DD (e.g., 2013-07-01).

    -----------------------------------------------------------------------------------
    
    ### gold.fact_sales

* **Purpose:** Provides data about each recorded transaction.
* **Columns:**
      
   
    Column Name | Data Type | Description
    --- | --- | ---
    order_number | NVARCHAR(50) | Primary key uniquely identifying each transaction.
    product_key | INT | Surogate key uniquely identifying each product record in the dimension table.
    customer_key | INT | Surogate key uniquely identifying each customer record in the dimension table.
    order_date | DATE | Date of order, formatted as YYYY-MM-DD (e.g., 2013-05-30).
    shipping_date | DATE | Date of shipping, formatted as YYYY-MM-DD (e.g., 2011-04-04).
    due_date | DATE | The due date of order column indicates the date by which the order is expected to be completed and fulfilled, formatted as YYYY-MM-DD (e.g., 2010-07-24).
    sales_amount | INT | Total cost of products of one type bought by customer in one transaction.
    quantity | INT | Amount of specific product bought by customer in one transaction.
    price | INT | Price for one unit of product.  
    
