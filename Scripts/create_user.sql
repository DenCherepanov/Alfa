CREATE BIGFILE TABLESPACE tbs_01
  DATAFILE 'tbs_01.dat'
    SIZE 10M
    AUTOEXTEND ON;

CREATE USER tst
  IDENTIFIED BY 123
  DEFAULT TABLESPACE tbs_01;

ALTER USER tst quota unlimited on tbs_01;

GRANT create session TO tst;
GRANT create table TO tst;
GRANT create trigger TO tst;
GRANT create procedure TO tst;

GRANT ALTER ANY table TO tst;
GRANT ALTER ANY trigger TO tst;
GRANT ALTER ANY procedure TO tst;

GRANT DELETE ANY TABLE TO tst;
GRANT DROP ANY TABLE TO tst;
GRANT DROP ANY PROCEDURE TO tst;
GRANT DROP ANY TRIGGER TO tst;