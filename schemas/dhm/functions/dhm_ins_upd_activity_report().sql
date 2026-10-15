-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_ins_upd_activity_report()
-- Type: FUNCTION

-- Name: dhm_ins_upd_activity_report(); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_ins_upd_activity_report(OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
 v_out_city numeric;
 v_out_state numeric;
 v_out_group numeric;
begin
 
 delete from dhm.dhm_city_activity_report;
 delete from dhm.dhm_corporate_activity_report;
 delete from dhm.dhm_state_activity_report;
 

  select * from dhm.dhm_ins_upd_city_report()
  into v_out_city;
  
  select * from dhm.dhm_ins_upd_state_report()
  into v_out_state;
  
   select * from dhm.dhm_ins_upd_corporate_report()
  into v_out_group;
  
if v_out_group=1 and v_out_state=1 and v_out_city=1 then
p_out:=1;

end if;
end;
$$;


--
