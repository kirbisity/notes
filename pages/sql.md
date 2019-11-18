# SQL

[Back](../README.md)

### List of Contents

* [SQL concept](#sql-concept)
* [Types of Database Structure](#types-of-database-structure)
* [ETL](#etl)
* [Best practices](#best-practices)

## SQL concept

The order of SQL clauses, every query must be in this order

1. `SELECT`
2. `FROM`
3. `WHERE`
4. `GROUP BY`
5. `ORDER BY`
6. `LIMIT`

[Back To Top](#list-of-contents)

## Types of Database Structure

Data store

Data mart

Data warehouse

[Back To Top](#list-of-contents)

## ETL

Copy data from source into a destination system.

**Extract**: extract data from one or more sources

**Transform**: data cleansing and transform them into proper storage format

**Load**: insert data into final target database

[Back To Top](#list-of-contents)

## Best practices

- Do not use `SELECT *` in queries.

- Always use table aliases when your SQL statement involves more than one source.

  - ```sql
     SELECT c.CountryID
     FROM Countries as c
    ```

- Use ANSI-Standard Join clauses instead of the old style joins.

  - The join condition is described only in `ON`, not `WHERE`
  - ANSI joins, the `WHERE` clause is used only for filtering data.

- Do not use column numbers in the ORDER BY clause.

- Always use a column list in your INSERT statements.

  - ```sql
    INSERT INTO Countries
    (CountryID, CountryName)
    VALUES (1, ‘Egypt’)
    ```

- Never use double quotes

- Do not prefix your stored procedure names with “sp_”.

[Back To Top](#list-of-contents)