-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr_beta
-- Object: labadkr_check_page_alias(character varying)
-- Type: FUNCTION

-- Name: labadkr_check_page_alias(character varying); Type: FUNCTION; Schema: labadkr_beta; Owner: -
--

CREATE FUNCTION labadkr_beta.labadkr_check_page_alias(p_alias character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

 
 

declare
v_alias varchar(2000);
v_cnt numeric;
begin

---- if exest then result=1 ,not exest result=0 ---

v_alias:=upper(p_alias);

select count(1) into v_cnt from labadkr.labadkr_page
where upper(alias) = v_alias
and is_deleted = 0 ;

if v_cnt =0
then p_result:=0;
else
 p_result:=1;
end if;

end
 
 

 $$;


--
