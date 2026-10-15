-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_bibgeneration(numeric)
-- Type: FUNCTION

-- Name: labtcs_bibgeneration(numeric); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_bibgeneration(v_bib_no numeric, OUT p_bib_no numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
begin
if v_bib_no in (50001,50050,50115,50263,50309,50505,50784,50786,50989,51000,51001,51097,
				51100,51111,51118,51167,51171,51786,52222,52786,53333,53785,53786,54444,
				54462,54786,55001,55555,55786,56570,56666,56786,57300,57777,57786,58786,
				58888,59786,59999,60000,60171,60191,60218,60230,60312,60606,60786,60795,
				60869,60977,61006,61192,61233,61786,62675,62786,63786,64786,65786,66554,
				66606,66666,66786,68786,69786,69999,70000,70007,70471,70695,70786,71010,
				71786,71860,72616,72786,73786,74786,75786,76786,77777,77786,78259,78786,
				79786,79999,80000) then
v_bib_no:=v_bib_no+1;
select * from labtcs.labtcs_bibgeneration(v_bib_no) into v_bib_no;
end if;
p_bib_no:=v_bib_no;
end;

$$;


--
