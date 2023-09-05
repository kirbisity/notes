# SQL

[Back](../README.md)

### List of Contents

* [SQL concept](#sql-concept)
* [Types of Database Structure](#types-of-database-structure)
* [ETL](#etl)
* [Oracle SQL](#oracle-sql)
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

## Oracle SQL
* [Select](#oracle-select)
* [Join](#oracle-join)
* [DDL](#oracle-ddl)
    - `ALTER  |  ANALYZE  |  ASSOCIATE STATISTICS  |  AUDIT  |  COMMENT  |  CREATE   |  DISASSOCIATE STATISTICS  |  DROP   |  FLASHBACK   |  GRANT  |  NOAUDIT  |  PURGE  |  RENAME  |  REVOKE  | TRUNCATE  |  UNDROP`
* [DML](#oracle-dml)
    - `CALL |  DELETE  |  EXPLAIN PLAN  |  INSERT   |  LOCK TABLE  |  MERGE  |  SELECT |  UPDATE`
* [Transaction control](#oracle-transaction-control)
    - `COMMIT  |  ROLLBACK  |  SAVEPOINT  |  SET TRANSACTION`
* [Misc](#oracle-misc)

- Oracle VIEW: a virtual table that does not physically exist.
  - ```sql
     CREATE VIEW view_name AS SELECT columns FROM tables [WHERE conditions];
    ```

### Oracle Select
- `SELECT`
   - `SELECT ROUND(n,x)` to round n to x decimal points.
- `WHERE` and `HAVING`
  - `WHERE` clause executes just after FROM clause.
  - `WHERE` comes before the group by clause
  - `WHERE` cannot use group functions
  - `WHERE` clause restricts few rows from taking part in any other operation like joins, functions etc...
  - `HAVING` comes after the group by clause
  - `HAVING` can use the aggregate / group functions like MAX , MIN , AVG, SUM, etc.
  - `HAVING` clause just hides few rows from your eyes from the result set produced by the query.
  - `HAVING` is the last clause to be executed.
- `FETCH FIRST n ROWS ONLY` to return top rows. `FETCH FIRST n ROWS WITH TIES` to return top rowsmto include the extra rows that are ties.
- `ORDER BY`
   - performs case sensitive sorting with character values
   - Column aliases can be used in the `ORDER BY`
- `GROUP BY`: All columns in the `SELECT` need to be in `GROUP BY` except the aggregate function called in the `SELECT`.
   - `HAVING` is used with `GROUP BY` to only return groups whose the condition is TRUE.
      - ```sql
        select City, CNT=Count(1) From Address Where State = 'MA'
        Group By City Having Count(1)>5
        ```
- `WITH`: reduce repetition and simplify complex SQL
   - may be processed as an inline view or resolved as a temporary table
   - performance implications of `WITH` is case-by-case


### Oracle Join
- `JOIN`
   - An equijoin is a join condition containing an equality operator
   - The condition for natural join is an equijoin of identical column names.
   - `ON` can be used to join columns that have different names.
   - The join condition is separated from other search conditions.
   - `WHERE` specifies a search condition for rows returned by `SELECT`.
   - `USING` allows you to specify the join key by name
   - ```sql
      select department_name, city
      from departments JOIN locations
      USING (location_id); -- specify the same column name for both of the tables for the join

      select department_name, city
      from departments dept join locations loc
      on (dept.location_id = loc.id); -- specify different column name for the tables for the join.
     ```
- `OUTER JOINS`
   - `FULL OUTER JOIN`: results may null for both tables
      - If any column of the result table does not have a value, that column has the null value in the result table.
   - `LEFT OUTER JOIN`: results complete for left table, may null for right table.
      - Includes rows from left table that have no matching values in the right table
   - `RIGHT OUTER JOIN`: results may null for left table, complete for right table.
      - Includes rows from right table that have no matching values in the left table
- `MERGE`: combines `INSERT`, `UPDATE`, `DELETE`
   - to select rows from one or more sources for update or insertion into a table or view
- self-join
   - ```sql
     SELECT a.column_name, b.column_name.
     FROM table1 a, table1 b WHERE a.common_filed = b.common_field;
     ```
- `UNION`: combine select results and remove duplicates. Each select must have the same number of fields (columns) in the result sets with similar data types. `UNION ALL` to retain the duplicate rows. By default the output will be sorted in the order the rows were inserted.
- `INTERSECT`: combine select results that are common. Both queries must return the same number of columns and of compatible data types.
   - `INTERSECT` operator does match NULLS.

### Oracle DDL
- `CREATE`
  - Privilege: To create XXX, you need to have `CREATE XXX` privilege, to create XXX in another user's schema, you need to have `CREATE ANY XXX` privilege.
  - `CREATE XXX` implicitly executes a commit.
  - `CREATE TABLE` can include primary key and constraints, but CANNOT include index.
  - `FLASHBACK`: Oracle cannot restore anything once DDL is executed on the table.
- `ALTER SEQUENCE`:  change the increment, minimum and maximum values etc. of existing sequence, affecting only future sequence numbers.
  - `CURRVAL`: Returns the current value of a sequence
  - `NEXTVAL`: Increments the sequence and returns the next value
### Oracle DML
- `INSERT`
   - `INSERT ALL`: add multiple rows into more than one table in one command
   - ```sql
     INSERT ALL
      INTO my_table (column1, column2, column_n) VALUES (expr1, expr2, expr_n)
      INTO my_other_table (column1, column2, column_n) VALUES (expr1, expr2, expr_n)
      INTO my_yet_other_table (column1, column2, column_n) VALUES (expr1, expr2, expr_n)
     SELECT * FROM dual;
     ```
- `DELETE` INLINEVIEW delete only deletes from child table.


### Oracle Transaction Control
- `ROLLBACK`
   - Statement-level rollback (due to statement or deadlock execution error)
   - Rollback to a savepoint
   - Rollback of a transaction due to user request
   - Rollback of a transaction due to exceptions
   - Rollback of all outstanding transactions when an instance terminates abnormally
   - Rollback of incomplete transactions during recovery
- `SAVEPOINTS`: Can only be used for DML. Can be used for `ROLLBACK` but not `COMMIT`.

### Oracle Misc
[Back To Oracle SQL](#oracle-sql)
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
