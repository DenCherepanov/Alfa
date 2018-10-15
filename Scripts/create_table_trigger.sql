create table SCITY
(
  CODECITY    NUMBER not null
    primary key,
  NAMECITY VARCHAR2(50),
  ABBR        VARCHAR2(15)
)
/

create table SSTREET
(
  CODESTREET NUMBER not null
    primary key,
  NAMESTREET    VARCHAR2(100),
  ABBR          VARCHAR2(15),
  CODECITY      NUMBER
    constraint SSTREET_SCITY_CODECITY_FK
    references SCITY
    on delete cascade,
  ENABLED       NUMBER
)
/

create table PEOPLESTREET
(
  CODEPEOPLE NUMBER not null
    primary key,
  CODESTREETR   NUMBER
    constraint "PS_SS_CODESTREETR _fk"
    references SSTREET
    on delete cascade,
  CODESTREETF   NUMBER
    constraint "PS_SS_CODESTREETF _fk"
    references SSTREET
    on delete cascade
)
/

create table DECODESTREET
(
  OLDSTREETR NUMBER,
  OLDSTREETF NUMBER,
  NEWSTREETR NUMBER,
  NEWSTREETF NUMBER
)
/

create global temporary table TEMP_BUF
(
  CODESTREET NUMBER
)
on commit preserve rows
/

-- три добавляющий записи в таблицу DECODESTREET
create or replace trigger INSERT_HISTORY
  before update of CODESTREETR, CODESTREETF
  on PEOPLESTREET
  for each row
  when (OLD.CODESTREETR != NEW.CODESTREETR OR OLD.CODESTREETF != NEW.CODESTREETF)
  BEGIN
  INSERT INTO DECODESTREET
    values (:OLD.CODESTREETR,:OLD.CODESTREETF,:NEW.CODESTREETR,:NEW.CODESTREETF);
END;