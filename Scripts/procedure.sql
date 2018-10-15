create or replace Procedure UnionStreet(CODE_CITY in NUMBER, CODE_STREET in NUMBER, FILTER_STREET in varchar2)
is
  begin
    -- очищаем временную таблицу
    delete from TEMP_BUF;

    -- добавляем во временную таблицу коды улиц, подлежащих объединению
    insert into TEMP_BUF (CODESTREET)
    select CODESTREET from SSTREET
    where     CODECITY=CODE_CITY
          and ENABLED=1
          and upper(NAMESTREET) like '%'||FILTER_STREET||'%'
          and CODESTREET<>CODE_STREET;

    -- блокируем лишние улицы
    update SSTREET set ENABLED=0
    where CODESTREET in (select CODESTREET from TEMP_BUF);

    -- перекодировка улиц для застрахованных
    update PEOPLESTREET
    set CODESTREETR = case when CODESTREETR in (select CODESTREET from TEMP_BUF) then CODE_STREET
                           else CODESTREETR end,
        CODESTREETF = case when CODESTREETF in (select CODESTREET from TEMP_BUF) then CODE_STREET
                           else CODESTREETF end
    where CODESTREETR in (select CODESTREET from TEMP_BUF) or
          CODESTREETF in (select CODESTREET from TEMP_BUF);
  end;
/