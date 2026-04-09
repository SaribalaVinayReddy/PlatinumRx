# PlatinumRx Data Analyst Assignment

## Project Contents

- `SQL/01_Hotel_Schema_Setup.sql` — schema and sample data for the hotel management system.
- `SQL/02_Hotel_Queries.sql` — SQL queries solving the five hotel questions.
- `SQL/03_Clinic_Schema_Setup.sql` — schema and sample data for the clinic management system.
- `SQL/04_Clinic_Queries.sql` — SQL queries solving the five clinic questions.
- `Spreadsheets/Ticket_Analysis.xlsx` — Excel workbook with ticket and feedback analysis.
- `Python/01_Time_Converter.py` — script converting minutes into human-readable hour/minute format.
- `Python/02_Remove_Duplicates.py` — script removing duplicate characters from a string while preserving order.

## Notes

- The SQL scripts are written to work in MySQL 8.0+/MariaDB 10.2+ and use standard SQL window functions for ranking.
- The spreadsheet workbook contains the `ticket` and `feedbacks` sheets, with formulas to populate `ticket_created_at` and to calculate same-day and same-hour ticket counts.
- The Python scripts include example usage and are designed for direct execution.

## How to run

- SQL: Load the `.sql` files into your SQL client and execute them sequentially.
- Python: 
  - Run `python Python/01_Time_Converter.py <minutes1> <minutes2> ...` (e.g., `python Python/01_Time_Converter.py 130 110 45 0`).
  - Run `python Python/02_Remove_Duplicates.py <string1> <string2> ...` (e.g., `python Python/02_Remove_Duplicates.py "mississippi" "hello world"`).
- Spreadsheet: Open `Spreadsheets/Ticket_Analysis.xlsx` in Excel or Google Sheets.
