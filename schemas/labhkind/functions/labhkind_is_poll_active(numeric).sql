-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_is_poll_active(numeric)
-- Type: FUNCTION

-- Name: labhkind_is_poll_active(numeric); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_is_poll_active(p_asset_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	v_sysdate timestamp;
    v_count numeric;
begin
    v_sysdate:=current_timestamp at time zone 'utc';
    
    
    select count(1) into v_count from labhkind.labhkind_poll where poll_id=p_asset_id and end_date >=v_sysdate;
  
  if v_count >0 
  
    then p_result:=1;
    else 
    p_result:=0;
    end if;
   
end;

 $$;


--
