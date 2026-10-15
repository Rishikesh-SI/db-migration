-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: regexp_count(text, text)
-- Type: FUNCTION

-- Name: regexp_count(text, text); Type: FUNCTION; Schema: scom; Owner: -
--

CREATE FUNCTION scom.regexp_count(str text, search text) RETURNS integer
    LANGUAGE plpgsql
    AS $$ 

declare
  str_len int;
  search_len int;
  i int;
begin
  str_len := length(str);
  search_len := length(search);
  i := 0;
  for x in 1..str_len-search_len+1 loop
    if substr(str, x, search_len) = search then
      i := i+1;
    end if;
  end loop;
  return i;
end;

 $$;


--
