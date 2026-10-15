-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: labrs_is_poll_active(numeric)
-- Type: FUNCTION

-- Name: labrs_is_poll_active(numeric); Type: FUNCTION; Schema: labrs_2602; Owner: -
--

CREATE FUNCTION labrs_2602.labrs_is_poll_active(p_asset_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	v_sysdate timestamp;
    v_count numeric;
begin
    v_sysdate:=current_timestamp at time zone 'utc';
    
    
    select count(1) into v_count from labrs.labrs_poll where poll_id=p_asset_id and end_date >=v_sysdate;
  
  if v_count >0 
  
    then p_result:=1;
    else 
    p_result:=0;
    end if;
   
end;

 $$;


--
