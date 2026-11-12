# SQL-PowerBI-Pipeline-Coffee

A data pipeline project: a messy café sales dataset is cleaned with SQL (PostgreSQL), exported to a clean CSV, and visualized in a Power BI dashboard.

## Repository Contents

| File | Description |
|---|---|
| `dirty_cafe_sales.csv` | Raw dataset: 10,000 café transactions with missing values and placeholder text like `UNKNOWN` and `ERROR` |
| `data cleaning SQL file.sql` | PostgreSQL script that cleans the `coffeesales` table |
| `cleaned_sales_data.csv` | Cleaned dataset exported from SQL |
| `SQL-PowerBI Practice.pbix` | Power BI dashboard built on the cleaned data |

## Commit History

### `5c36379`: Initial commit (2026-06-04)
- Created the repository with a `.gitattributes` file.

### `2d85d48`: First upload: dirty data, SQL cleaning, clean data and Power BI (2026-06-04)
**Added the raw data**
- `dirty_cafe_sales.csv`: 10,000 transactions with columns for item, quantity, price per unit, total spent, payment method, location and transaction date.

**Added the SQL cleaning script**
- Dropped the `transaction_id` column.
- Converted the placeholder values `UNKNOWN`, `ERROR` and `[null]` to `NULL`, then fixed the data types:
  - `quantity` to integer
  - `price_per_unit` and `total_spent` to float
  - `transaction_date` to date
- Set missing or invalid `payment_method` values to `'Unknown'`.
- Checked what percentage of rows had no transaction date, then deleted those rows.
- Added `year` (integer) and `month_year` (e.g. "October 2023") columns.
- Set text column lengths with `VARCHAR` for `item`, `transaction_type`, `payment_method` and `month_year`.
- **Filled in missing numbers using the formula total = price × quantity:**
  - missing `total_spent` = `price_per_unit × quantity`
  - missing `quantity` = `total_spent ÷ price_per_unit`
  - missing `price_per_unit` = `total_spent ÷ quantity`

**Added the cleaned data**
- `cleaned_sales_data.csv`: 9,540 rows after removing transactions with no date.

**Added the Power BI dashboard, page "Basic Dashboarding"**
- Total Sales by Payment Method (pie chart)
- Total Sales per Month (line chart)
- Total Sales per Item (matrix with quantity and price totals and percentages)
- Sales by Quarter (line chart)

### `276dc99`: Update #2: remove remaining nulls and expand the dashboard (2026-06-05)
**SQL script**
- Added steps to review and then delete rows where `quantity` or `price_per_unit` was still missing. These rows couldn't be recovered with the formula because two of the three values were missing.

**Cleaned data**
- Re-exported `cleaned_sales_data.csv`: **9,485 rows, with no remaining nulls**. It now includes the `year` and `month_year` columns.

**Power BI dashboard: added a second page, "Breakdown by Quarter"**
- Quarter slicer (dropdown filter)
- Total Sales by Transaction Type over time (line chart: In-store / Takeout / Unknown)
- Total Sales by Payment Method over time (line chart)
- Total Sales by Item (column chart)
- Total Sales by Month (donut chart)
- Transactions with more than one item vs. a single item (donut chart)
- Monthly sales by item (matrix)

### `8909ab2`: Update #3: dashboard layout touch-ups (2026-10-26)
- Small layout adjustments to the "Breakdown by Quarter" page in the Power BI file: visual layering order and keyboard tab order.
- No changes to the visuals, the data or the SQL script.

## Final Dataset Summary
- **Rows:** 9,485 transactions, all from 2023.
- **Items:** Juice, Coffee, Salad, Cake, Sandwich, Smoothie, Cookie, Tea, plus 921 rows labeled `Unknown`.
- **Payment methods:** Digital Wallet, Credit Card and Cash, plus 2,997 rows labeled `Unknown`.
- **Transaction types:** In-store and Takeout, plus 3,760 rows labeled `Unknown`.

## Tools
PostgreSQL, Power BI, CSV
