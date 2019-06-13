/*
Lab 1 report <Fahad Hameed and fahha780>
             <Suriya and balra340> 
*/

DROP TABLE IF LessAvgPrice_Item CASCADE;
 
/* Have the source scripts in the file so it is easy to recreate!*/

SOURCE company_schema.sql;
SOURCE company_data.sql;

/*
Question 1: List all employees, i.e. all tuples in the jbemployee relation.
*/

SELECT * FROM jbemployee;
/*
+------+--------------------+--------+---------+-----------+-----------+
| id   | name               | salary | manager | birthyear | startyear |
+------+--------------------+--------+---------+-----------+-----------+
|   10 | Ross, Stanley      |  15908 |     199 |      1927 |      1945 |
|   11 | Ross, Stuart       |  12067 |    NULL |      1931 |      1932 |
|   13 | Edwards, Peter     |   9000 |     199 |      1928 |      1958 |
|   26 | Thompson, Bob      |  13000 |     199 |      1930 |      1970 |
|   32 | Smythe, Carol      |   9050 |     199 |      1929 |      1967 |
|   33 | Hayes, Evelyn      |  10100 |     199 |      1931 |      1963 |
|   35 | Evans, Michael     |   5000 |      32 |      1952 |      1974 |
|   37 | Raveen, Lemont     |  11985 |      26 |      1950 |      1974 |
|   55 | James, Mary        |  12000 |     199 |      1920 |      1969 |
|   98 | Williams, Judy     |   9000 |     199 |      1935 |      1969 |
|  129 | Thomas, Tom        |  10000 |     199 |      1941 |      1962 |
|  157 | Jones, Tim         |  12000 |     199 |      1940 |      1960 |
|  199 | Bullock, J.D.      |  27000 |    NULL |      1920 |      1920 |
|  215 | Collins, Joanne    |   7000 |      10 |      1950 |      1971 |
|  430 | Brunet, Paul C.    |  17674 |     129 |      1938 |      1959 |
|  843 | Schmidt, Herman    |  11204 |      26 |      1936 |      1956 |
|  994 | Iwano, Masahiro    |  15641 |     129 |      1944 |      1970 |
| 1110 | Smith, Paul        |   6000 |      33 |      1952 |      1973 |
| 1330 | Onstad, Richard    |   8779 |      13 |      1952 |      1971 |
| 1523 | Zugnoni, Arthur A. |  19868 |     129 |      1928 |      1949 |
| 1639 | Choy, Wanda        |  11160 |      55 |      1947 |      1970 |
| 2398 | Wallace, Maggie J. |   7880 |      26 |      1940 |      1959 |
| 4901 | Bailey, Chas M.    |   8377 |      32 |      1956 |      1975 |
| 5119 | Bono, Sonny        |  13621 |      55 |      1939 |      1963 |
| 5219 | Schwarz, Jason B.  |  13374 |      33 |      1944 |      1959 |
+------+--------------------+--------+---------+-----------+-----------+
25 rows in set (0.01 sec)
 */

/*
Question 2: List the name of all departments in alphabetical order. Note: by “name” we mean the name attribute for all tuples in the jbdept relation.
*/

SELECT name FROM jbdept ORDER BY name ASC;
/*
+------------------+
| name             |
+------------------+
| Bargain          |
| Book             |
| Candy            |
| Children's       |
| Children's       |
| Furniture        |
| Giftwrap         |
| Jewelry          |
| Junior Miss      |
| Junior's         |
| Linens           |
| Major Appliances |
| Men's            |
| Sportswear       |
| Stationary       |
| Toys             |
| Women's          |
| Women's          |
| Women's          |
+------------------+
19 rows in set (0.00 sec)
*/

/*
Question 3: What parts are not in store, i.e. qoh = 0? (qoh = Quantity On Hand)
*/

SELECT name FROM jbparts WHERE qoh = 0;
/*
+-------------------+
| name              |
+-------------------+
| card reader       |
| card punch        |
| paper tape reader |
| paper tape punch  |
+-------------------+
4 rows in set (0.00 sec)
*/

/*
Question 4: Which employees have a salary between 9000 (included) and 10000 (included)?
*/

Select name From jbemployee WHERE salary >= 9000 AND salary <= 10000;
/*
+----------------+
| name           |
+----------------+
| Edwards, Peter |
| Smythe, Carol  |
| Williams, Judy |
| Thomas, Tom    |
+----------------+
4 rows in set (0.00 sec)
*/

/*
Question 5: What was the age of each employee when they started working (startyear)?
*/

SELECT name, (startyear - birthyear) AS ¨Age¨ FROM jbemployee;
/*
+--------------------+---------+
| name               | ¨Age¨   |
+--------------------+---------+
| Ross, Stanley      |      18 |
| Ross, Stuart       |       1 |
| Edwards, Peter     |      30 |
| Thompson, Bob      |      40 |
| Smythe, Carol      |      38 |
| Hayes, Evelyn      |      32 |
| Evans, Michael     |      22 |
| Raveen, Lemont     |      24 |
| James, Mary        |      49 |
| Williams, Judy     |      34 |
| Thomas, Tom        |      21 |
| Jones, Tim         |      20 |
| Bullock, J.D.      |       0 |
| Collins, Joanne    |      21 |
| Brunet, Paul C.    |      21 |
| Schmidt, Herman    |      20 |
| Iwano, Masahiro    |      26 |
| Smith, Paul        |      21 |
| Onstad, Richard    |      19 |
| Zugnoni, Arthur A. |      21 |
| Choy, Wanda        |      23 |
| Wallace, Maggie J. |      19 |
| Bailey, Chas M.    |      19 |
| Bono, Sonny        |      24 |
| Schwarz, Jason B.  |      15 |
+--------------------+---------+
25 rows in set (0.00 sec)
*/

/*
Question 6: Which employees have a last name ending with “son”?
*/

SELECT name FROM jbemployee WHERE name like '%son,%' ;
/*
+---------------+
| name          |
+---------------+
| Thompson, Bob |
+---------------+
1 row in set (0.00 sec)
*/


/*
Question 7: Which items (note items, not parts) have been delivered by a supplier called Fisher-Price? Formulate this query using a subquery in the where-clause.
*/

/*
SELECT name
    FROM jbitem item
    WHERE exists (SELECT *
    FROM jbsupplier s
    WHERE s.name='Fisher-Price' AND s.id=item.supplier);
*/
select name 
from jbitem 
where supplier in (select id 
                    from jbsupplier 
                    where name = 'Fisher-Price');
/*
+-----------------+
| name            |
+-----------------+
| Maze            |
| The 'Feel' Book |
| Squeeze Ball    |
+-----------------+
3 rows in set (0.45 sec)
*/


/*
Question 8: Formulate the same query as above, but without a subquery.
*/

SELECT jbitem.name
    FROM jbitem, jbsupplier Where jbitem.supplier=jbsupplier.id AND jbsupplier.name='Fisher-Price';
/*
+-----------------+
| name            |
+-----------------+
| Maze            |
| The 'Feel' Book |
| Squeeze Ball    |
+-----------------+
3 rows in set (0.02 sec)
*/

/*
Question 9: Show all cities that have suppliers located in them. Formulate this query using a subquery in the where-clause.
*/

SELECT name
    FROM jbcity city
    WHERE exists (SELECT * FROM jbsupplier supplier
    WHERE city.id = supplier.city);
/*
+----------------+
| name           |
+----------------+
| Amherst        |
| Boston         |
| New York       |
| White Plains   |
| Hickville      |
| Atlanta        |
| Madison        |
| Paxton         |
| Dallas         |
| Denver         |
| Salt Lake City |
| Los Angeles    |
| San Diego      |
| San Francisco  |
| Seattle        |
+----------------+
15 rows in set (0.00 sec)
*/

/*
Question 10: What is the name and color of the parts that are heavier than a card reader? Formulate this query using a subquery in the where-clause. (The SQL query must not contain the weight as a constant.)Formulate the same query as above, but without a subquery. (The query must not contain the weight as a constant.)
*/

SELECT name, color
   FROM jbparts
   WHERE weight > (SELECT weight FROM jbparts Where name='card reader');
/*
+--------------+--------+
| name         | color  |
+--------------+--------+
| disk drive   | black  |
| tape drive   | black  |
| line printer | yellow |
| card punch   | gray   |
+--------------+--------+
4 rows in set (0.00 sec)
*/


/*
Question 11: Formulate the same query as above, but without a subquery. (The query must not contain the weight as a constant.)
*/

SELECT a.name, a.color FROM jbparts a, jbparts b WHERE a.weight > b.weight AND b.name = 'card reader';
/*
+--------------+--------+
| name         | color  |
+--------------+--------+
| disk drive   | black  |
| tape drive   | black  |
| line printer | yellow |
| card punch   | gray   |
+--------------+--------+
4 rows in set (0.00 sec)
*/

/*
Question 12: What is the average weight of black parts?
*/

SELECT AVG(weight) AS 'Average Weight Black Parts'
     FROM jbparts
     WHERE color = 'black';
/*
+----------------------------+
| Average Weight Black Parts |
+----------------------------+
|                   347.2500 |
+----------------------------+
1 row in set (0.00 sec)
*/

/*
Question 13: What is the total weight of all parts that each supplier in Massachusetts (“Mass”) has delivered? Retrieve the name and the total weight for each of these suppliers. Do not forget to take the quantity of delivered parts into account. Note that one row should be returned for each supplier.
*/
/*
SELECT supplier.name, SUM(supply.quan * parts.weight) AS 'Total Weight' 
FROM jbsupplier supplier INNER JOIN (jbcity city, jbsupply supply, jbparts parts) 
ON (supplier.city=city.id AND city.state='MASS' AND supply.supplier = supplier.id AND supply.part = parts.id) 
GROUP BY supplier.name;
*/
select u.name, sum(s.quan * p.weight) 
from jbparts p, jbsupply s, jbsupplier u, jbcity c 
where p.id = s.part
and s.supplier = u.id
and u.city = c.id
and c.state = "Mass"
group by u.name, u.id;
/*
+--------------+--------------+
| name         | Total Weight |
+--------------+--------------+
| DEC          |         3120 |
| Fisher-Price |      1135000 |
+--------------+--------------+
2 rows in set (0.00 sec)
*/


/*
Question 14: Create a new relation (a table), with the same attributes as the table items using the CREATE TABLE syntax where you define every attribute explicitly (i.e. not as a copy of another table). Then fill the table with all items that cost less than the average price for items. Remember to define primary and foreign keys in your table!
*/

CREATE TABLE LessAvgPrice_Item(
    id INT,
    name VARCHAR(20),
    dept INT,
    price INT,
    qoh INT,
    supplier INT,
    primary key(id),
    foreign key(dept) 
        references jbdept(id),
    foreign key(supplier) 
        references jbsupplier(id)
);
/*
Query OK, 0 rows affected (0.06 sec)
*/

INSERT INTO LessAvgPrice_Item
SELECT *
FROM jbitem
WHERE price < (SELECT avg(price) FROM jbitem);

/*
Query OK, 14 rows affected (0.06 sec)
Records: 14  Duplicates: 0  Warnings: 0
*/


SELECT * FROM LessAvgPrice_Item;
/*
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  11 | Wash Cloth      |    1 |    75 |  575 |      213 |
|  19 | Bellbottoms     |   43 |   450 |  600 |       33 |
|  21 | ABC Blocks      |    1 |   198 |  405 |      125 |
|  23 | 1 lb Box        |   10 |   215 |  100 |       42 |
|  25 | 2 lb Box, Mix   |   10 |   450 |   75 |       42 |
|  26 | Earrings        |   14 |  1000 |   20 |      199 |
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 106 | Clock Book      |   49 |   198 |  150 |      125 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 118 | Towels, Bath    |   26 |   250 | 1000 |      213 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
| 120 | Twin Sheet      |   26 |   800 |  750 |      213 |
| 165 | Jean            |   65 |   825 |  500 |       33 |
| 258 | Shirt           |   58 |   650 | 1200 |       33 |
+-----+-----------------+------+-------+------+----------+
14 rows in set (0.00 sec)
*/

/*
Question 15: Create a view that contains the items that cost less than the average price for items.
*/

CREATE VIEW ItemLessAvgPrice AS 
SELECT * FROM jbitem 
WHERE price < (SELECT AVG(price) FROM jbitem); 

/*
Query OK, 0 rows affected (0.00 sec) 
*/ 

SELECT * FROM ItemLessAvgPrice;
/*
+-----+-----------------+------+-------+------+----------+
| id  | name            | dept | price | qoh  | supplier |
+-----+-----------------+------+-------+------+----------+
|  11 | Wash Cloth      |    1 |    75 |  575 |      213 |
|  19 | Bellbottoms     |   43 |   450 |  600 |       33 |
|  21 | ABC Blocks      |    1 |   198 |  405 |      125 |
|  23 | 1 lb Box        |   10 |   215 |  100 |       42 |
|  25 | 2 lb Box, Mix   |   10 |   450 |   75 |       42 |
|  43 | Maze            |   49 |   325 |  200 |       89 |
| 106 | Clock Book      |   49 |   198 |  150 |      125 |
| 107 | The 'Feel' Book |   35 |   225 |  225 |       89 |
| 118 | Towels, Bath    |   26 |   250 | 1000 |      213 |
| 119 | Squeeze Ball    |   49 |   250 |  400 |       89 |
| 120 | Twin Sheet      |   26 |   800 |  750 |      213 |
| 165 | Jean            |   65 |   825 |  500 |       33 |
| 258 | Shirt           |   58 |   650 | 1200 |       33 |
+-----+-----------------+------+-------+------+----------+
13 rows in set (0.01 sec)
*/

/*
Question 16: What is the difference between a table and a view? One is static and the other is dynamic. Which is which and what do we mean by static respectively dynamic?
*/

/*
Answer:
    Table is actual container of data in the form of rows and columns in the database containing data inside it whereas View is just a query stored used as 
    a table which can contain subset of table data or can contain data from multiple tables. Views are virtual tables generated from tables data. 
    Changing data in table also changes data in the corresponding views.
    
    Table is static that is we have to update the data in the tables when we need to change them, tables are not updated autopmatically where as Views are 
    dynamic because views change depending on the table they are refering.  
    
    Views are used for basically used for viewing data i.e. select statements but if we use update data from views it will update related table data but not in itself because view just dsiplay data.
*/

/*
Question 17: Create a view, using only the implicit join notation, i.e. only use where statements but no inner join, right join or left join statements, that calculates the total cost of each debit, by considering price and quantity of each bought item. (To be used for charging customer accounts). The view should contain the sale identifier (debit) and total cost.
*/

CREATE VIEW TCOST AS
SELECT jbsale.debit, sum(jbitem.price*jbsale.quantity)
FROM jbdebit,jbsale,jbitem
WHERE jbdebit.id = jbsale.debit
AND jbsale.item = jbitem.id
GROUP BY jbsale.debit;

/* Query OK, 0 rows affected (0.00 sec) */

SELECT * FROM TCOST;
/*
+--------+-----------------------------------+
| debit  | sum(jbitem.price*jbsale.quantity) |
+--------+-----------------------------------+
| 100581 |                              2050 |
| 100582 |                              1000 |
| 100586 |                             13446 |
| 100592 |                               650 |
| 100593 |                               430 |
| 100594 |                              3295 |
+--------+-----------------------------------+
6 rows in set (0.07 sec)
*/

/*
Question 18: Do the same as in (17), using only the explicit join notation, i.e. using only left, right or inner joins but no where statement. Motivate why you use the join you do (left, right or inner), and why this is the correct one (unlike the others).
*/

CREATE VIEW TCOST_2 AS
  SELECT jbsale.debit, sum(jbitem.price*jbsale.quantity)
  FROM jbdebit 
    INNER JOIN jbsale ON jbdebit.id = jbsale.debit
    INNER JOIN jbitem ON jbsale.item = jbitem.id
    GROUP BY jbsale.debit;

/* Query OK, 0 rows affected (0.01 sec) */

 SELECT * FroM TCOST_2;
 /*
+--------+-----------------------------------+
| debit  | sum(jbitem.price*jbsale.quantity) |
+--------+-----------------------------------+
| 100581 |                              2050 |
| 100582 |                              1000 |
| 100586 |                             13446 |
| 100592 |                               650 |
| 100593 |                               430 |
| 100594 |                              3295 |
+--------+-----------------------------------+
6 rows in set (0.01 sec) */

/*
Inner join is used as i only want to consider the jbdebits and do not want to have each row of jbsale and jbitem.
If left or rigth joins were used the rows that have NULL values on the attribute that i have joined would be also included which we dont want.
We only want those rows which have information to calculate price and quantity of each item bought. At the end used group by to group by using debit otherwise 
it would be two rows for 100586 having values 396 and 13050.
*/

/* 
Question 19:
Oh no! An earthquake!
a) Remove all suppliers in Los Angeles from the table jbsupplier. This will not work right away (you will receive error code 23000) which you will have to solve by deleting some other related tuples. However, do not delete more tuples from other tables than necessary and do not change the structure of the tables, i.e. do not remove foreign keys. Also, remember that you are only allowed to use “Los Angeles” as a constant in your queries, not “199” or “900”.
*/

DELETE FROM jbsale 
WHERE item IN (SELECT id 
                FROM jbitem 
                WHERE supplier IN (SELECT id 
                                    FROM jbsupplier 
                                    WHERE city IN (SELECT id 
                                                    FROM jbcity 
                                                    WHERE name = 'Los Angeles')));
/* Query OK, 1 row affected (0.02 sec) */

Drop table LessAvgPrice_Item;
/* Query OK, 0 rows affected (0.05 sec) */

DELETE FROM jbitem 
WHERE supplier IN (SELECT id 
                    FROM jbsupplier 
                    WHERE city in (SELECT id 
                                    FROM jbcity 
                                    WHERE name = 'Los Angeles'));
/* Query OK, 2 rows affected (0.00 sec) */

DELETE FROM jbsupplier 
WHERE city IN (SELECT id 
                FROM jbcity 
                WHERE name = 'Los Angeles');
                
/* Query OK, 1 row affected (0.00 sec) */

/* 
Question 19:
b) Explain what you did and why.
ANSWER:
    We tried to delete Supplier at first which resulted in the following error from which we got information about the foreign key constraints on are tables which are linked
    which are jbitem, jbsale and LessAvgPrice_Item

    ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`fahha780`.`jbitem`, CONSTRAINT `fk_item_supplier` FOREIGN KEY (`supplier`) REFERENCES `jbsupplier` (`id`))

    So first we deleted the specific data from the jbsale table by accesing the Los Angeles data using jbcity table. Similarly we deleted data for the jbitem table using
    same sub query as before.  Final when we have deleted all related data from both the tables we deleted Los Angeles data from jbsupplier.
    
    Due to foreign key constraints on the table we can not remove supplier because suppliers are referenced in other three tables due to which specific 
    data from those three tables must be deleted before we can delete data from jbsupplier table.
    Other three tables are jbitem, jbsale and LessAvgPrice_Item.
*/


/* 
*/


/* Question 20 
An employee has tried to find out which suppliers that have delivered items that have been sold. He has created a view and a query that shows the number of items sold from a supplier.
The employee would also like include the suppliers which has delivered some items, although for whom no items have been sold so far. In other words he wants to list all suppliers, which has supplied any item, as well as the number of these items that have been sold. Help him! Drop and redefine jbsale_supply to consider suppliers that have delivered items that have never been sold as well.
Hint: The above definition of jbsale_supply uses an (implicit) inner join that removes suppliers that have not had any of their delivered items sold
*/

CREATE VIEW jbsale_supply(supplier, item, quantity) AS
SELECT jbsupplier.name, jbitem.name, jbsale.quantity
FROM jbsupplier, jbitem, jbsale
WHERE jbsupplier.id = jbitem.supplier
AND jbsale.item = jbitem.id;

SELECT supplier, sum(quantity) AS sum FROM jbsale_supply
GROUP BY supplier;
/*
+--------------+------+
| supplier     | sum  |
+--------------+------+
| Cannon       |    6 |
| Levi-Strauss |    1 |
| Playskool    |    2 |
| White Stag   |    4 |
| Whitman's    |    2 |
+--------------+------+
5 rows in set (0.00 sec)
*/

DROP VIEW jbsale_supply;
/* Query OK, 0 rows affected (0.00 sec) */

CREATE view jbsale_supply(supplier, item, quantity) AS
SELECT jbsupplier.name, jbitem.name, jbsale.quantity
FROM jbsupplier INNER JOIN jbitem ON jbsupplier.id = jbitem.supplier
LEFT JOIN jbsale ON jbsale.item = jbitem.id;

/* Query OK, 0 rows affected (0.01 sec) */



SELECT supplier, sum(quantity) AS sum FROM jbsale_supply
GROUP BY supplier;

/*
+--------------+------+
| supplier     | sum  |
+--------------+------+
| Cannon       |    6 |
| Fisher-Price | NULL |
| Levi-Strauss |    1 |
| Playskool    |    2 |
| White Stag   |    4 |
| Whitman's    |    2 |
+--------------+------+
6 rows in set (0.05 sec)

*/
