begin
  UNIONSTREET(1,1,'“‹');
  commit;
end;

select * from TEMP_BUF;
select * from SCITY;
select * from SSTREET;
select * from PEOPLESTREET;
select * from DECODESTREET;

delete  from DECODESTREET;
delete from PEOPLESTREET;
delete from SSTREET;
delete from SCITY;
commit;

insert into SCITY values  (1,'ƒîðîä','ƒ');
insert into SSTREET values  (1,'“ëèöà1','óë',1,1);
insert into SSTREET values  (2,'“ëèöà2','óë',1,1);
insert into SSTREET values  (3,'“ëèöà3','óë',1,1);
insert into PEOPLESTREET values (1,2,null );
insert into PEOPLESTREET values (2,2,3 );
insert into PEOPLESTREET values (3,null,3 );
commit;

select * from SCITY where CODECITY=298000000254;
select * from SSTREET where CODECITY=298000000254 and upper(NAMESTREET) like '%€„‹%';
select * from PEOPLESTREET
where CODESTREETR in (select CODESTREET from SSTREET where CODECITY=298000000254 and upper(NAMESTREET) like '%€„‹%') or
      CODESTREETR in (select CODESTREET from SSTREET where CODECITY=298000000254 and upper(NAMESTREET) like '%€„‹%');

select * from DECODESTREET;

begin
  UNIONSTREET(298000000254,298000002165,'%€„‹%');
  commit;
end;

delete from SSTREET;
delete from PEOPLESTREET;
delete from DECODESTREET;
commit;

select * from SCITY where CODECITY=298000000254;
select * from SSTREET where CODECITY=298000000254 and upper(NAMESTREET) like '%ÀÄË%';
select * from PEOPLESTREET
where CODESTREETR in (select CODESTREET from SSTREET where CODECITY=298000000254 and upper(NAMESTREET) like '%ÀÄË%') or
      CODESTREETR in (select CODESTREET from SSTREET where CODECITY=298000000254 and upper(NAMESTREET) like '%ÀÄË%');

select * from DECODESTREET;

begin
  UNIONSTREET(298000000254,298000002165,'ÀÄË');
  commit;
end;

delete from SSTREET;
delete from PEOPLESTREET;
delete from DECODESTREET;
commit;

