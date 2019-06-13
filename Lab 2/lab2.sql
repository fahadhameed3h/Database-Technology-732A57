/*
Lab 2 report <Fahad Hameed and fahha780>
             <Suriya and balra340> 
*/

/*
Question 3: List all employees, i.e. all tuples in the jbemployee relation.
*/
CREATE TABLE jbmanager (
id Int NOT NULL,
bonus Int DEFAULT 0,
CONSTRAINT pk_id PRIMARY KEY(id),
CONSTRAINT fk_mange_employee FOREIGN KEY(id) references jbemployee(id) );

/*
Query OK, 0 rows affected (0.02 sec)
 */

Insert into jbmanager (id)
select manager from jbemployee where jbemployee.manager is not null
union
select manager from jbdept where jbdept.manager is not null;

/* 
Query OK, 12 rows affected (0.01 sec)
Records: 12  Duplicates: 0  Warnings: 0
*/

/*
We need to initialize bonus with any value in our cas we initialized with 0. It can be set to NULL but in that case we have to check that bonus value is null or not
*/

/* Question 4 */

update jbmanager
set bonus = bonus+10000
where id in (select manager from jbdept);

/*  Query OK, 7 rows affected (0.03 sec)
    Rows matched: 7  Changed: 7  Warnings: 0  */

/* Question 5 */

CREATE TABLE customer (id int, street varchar(120), name varchar(120), city integer not null, 
constraint pk_customer PRIMARY KEY (id), constraint fk_city foreign key (city) references jbcity(id));
/* Query OK, 0 rows affected (0.06 sec) */

CREATE TABLE account( account_number int, balance integer not null default 0, owner integer, 
constraint pk_account PRIMARY KEY (account_number), constraint fk_owner foreign key (owner) references customer(id));
/* Query OK, 0 rows affected (0.02 sec) */


CREATE TABLE transaction( transaction_number int, timestamp timestamp not null default current_timestamp, amount 
integer not null, account integer not null, responsible integer not null, 
constraint pk_transaction primary key (transaction_number), 
constraint fk_account foreign key (account) references account(account_number), 
constraint fk_responsible foreign key (responsible) references jbemployee(id) );

/* Query OK, 0 rows affected (0.04 sec) */


CREATE TABLE withdrawal ( id int, 
constraint pk_withdrawal PRIMARY KEY (id), 
constraint fk_transaction FOREIGN KEY (id) references transaction(transaction_number) ); 
/* Query OK, 0 rows affected (0.03 sec) */


CREATE TABLE deposit( id int, 
constraint pk_deposit PRIMARY KEY (id), 
constraint fk_transaction2 FOREIGN KEY (id) references transaction(transaction_number));
/* Query OK, 0 rows affected (0.03 sec) */

TRUNCATE jbsale; 
/* Query OK, 0 rows affected (0.02 sec) */

ALTER TABLE jbsale DROP FOREIGN KEY fk_sale_debit;
/* Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0 */

DROP TABLE jbdebit; 
/* Query OK, 0 rows affected (0.06 sec) */

create TABLE debit( id integer, constraint pk_debit PRIMARY KEY (id), constraint fk_transaction3 FOREIGN KEY (id) references transaction(transaction_number));
/* Query OK, 0 rows affected (0.02 sec) */


ALTER TABLE jbsale add constraint fk_sale_debit FOREIGN KEY (debit) references debit(id);
/* Query OK, 0 rows affected (0.04 sec)
Records: 0  Duplicates: 0  Warnings: 0 */


