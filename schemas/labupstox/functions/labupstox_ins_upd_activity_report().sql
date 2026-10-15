-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_ins_upd_activity_report()
-- Type: FUNCTION

-- Name: labupstox_ins_upd_activity_report(); Type: FUNCTION; Schema: labupstox; Owner: -
--

CREATE FUNCTION labupstox.labupstox_ins_upd_activity_report(OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$ 

declare 
 v_out_city numeric;
 v_out_state numeric;
 v_out_group numeric;
begin

 update labupstox.labupstox_user_master
 set  group_name =null,group_id =null
	 where payment_status=1
	 and  group_name='PhonePe'
	 ;
	
	update labupstox.labupstox_user_activity_report
set  group_name =null,group_id =null
	 where   group_name='PhonePe'
	 ;
	 
	 
update labupstox.labupstox_user_master
set pledged_state=  regexp_replace(pledged_state, '\s+$', ''),
    pledged_city=  regexp_replace(pledged_city, '\s+$', ''),
	state_name=  regexp_replace(state_name, '\s+$', ''),
    city=  regexp_replace(city, '\s+$', '')
	;
	
	
update labupstox.labupstox_user_activity_report
set pledged_state=  regexp_replace(pledged_state, '\s+$', ''),
    pledged_city=  regexp_replace(pledged_city, '\s+$', ''),
	state_name=  regexp_replace(state_name, '\s+$', ''),
    city=  regexp_replace(city, '\s+$', '');
	
 
 
 update labupstox.labupstox_user_master
 set pledged_state=replace(pledged_state,'-',null),
     pledged_city=replace(pledged_city,'-',null)
	 where payment_status=1;
	 
 update labupstox.labupstox_user_master
    set
	  pledged_state=replace(pledged_state,' - ',null),
     pledged_city=replace(pledged_city,' - ',null)
     where payment_status=1;
	 
	update labupstox.labupstox_user_activity_report
 set pledged_state=replace(pledged_state,'-',null),
     pledged_city=replace(pledged_city,'-',null)
	 ;
	 
 update labupstox.labupstox_user_activity_report
    set
	  pledged_state=replace(pledged_state,' - ',null),
     pledged_city=replace(pledged_city,' - ',null)
     ; 

  select * from labupstox.labupstox_ins_upd_city_report()
  into v_out_city;
  
  select * from labupstox.labupstox_ins_upd_state_report()
  into v_out_state;
  
   select * from labupstox.labupstox_ins_upd_corporate_report()
  into v_out_group;
  
if v_out_group=1 and v_out_state=1 and v_out_city=1 then
p_out:=1;

end if;
end;
$_$;


--
