-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labirao
-- Object: labirao_ins_upd_activity_report()
-- Type: FUNCTION

-- Name: labirao_ins_upd_activity_report(); Type: FUNCTION; Schema: labirao; Owner: -
--

CREATE FUNCTION labirao.labirao_ins_upd_activity_report(OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$ 

declare 
 v_out_city numeric;
 v_out_state numeric;
 v_out_group numeric;
 v_curr_date date:='2020-09-14';
 v_current_time timestamp;
begin

select current_timestamp at time zone 'utc' + interval '330 minute'
into v_current_time;

 update labirao.labirao_user_master
 set  group_name =null,group_id =null
	 where payment_status=1
	 and  group_name='PhonePe'
	 ;
	
	update labirao.labirao_user_activity_report
set  group_name =null,group_id =null
	 where   group_name='PhonePe'
	 ;
	 
	 
update labirao.labirao_user_master
set pledged_state=  regexp_replace(pledged_state, '\s+$', ''),
    pledged_city=  regexp_replace(pledged_city, '\s+$', ''),
	state_name=  regexp_replace(state_name, '\s+$', ''),
    city=  regexp_replace(city, '\s+$', '')
	;
	
	
update labirao.labirao_user_activity_report
set pledged_state=  regexp_replace(pledged_state, '\s+$', ''),
    pledged_city=  regexp_replace(pledged_city, '\s+$', ''),
	state_name=  regexp_replace(state_name, '\s+$', ''),
    city=  regexp_replace(city, '\s+$', '');
	
 
 
 update labirao.labirao_user_master
 set pledged_state=replace(pledged_state,'-',null),
     pledged_city=replace(pledged_city,'-',null)
	 where payment_status=1;
	 
 update labirao.labirao_user_master
    set
	  pledged_state=replace(pledged_state,' - ',null),
     pledged_city=replace(pledged_city,' - ',null)
     where payment_status=1;
	 
	update labirao.labirao_user_activity_report
 set pledged_state=replace(pledged_state,'-',null),
     pledged_city=replace(pledged_city,'-',null)
	 ;
	 
 update labirao.labirao_user_activity_report
    set
	  pledged_state=replace(pledged_state,' - ',null),
     pledged_city=replace(pledged_city,' - ',null)
     ; 
	 
	update   labirao.labirao_user_master
	set group_name=rtrim(group_name)
	where group_name is not null;
	
	update   labirao.labirao_user_activity_report
	set group_name=rtrim(group_name)
	where group_name is not null;
	  
update labirao.labirao_user_master
set  group_id='ef3c9b15dc',group_name='Ascend International School'
where  group_id in ('e8e30890bb','ASCENDCARE');

update labirao.labirao_user_activity_report
set group_id='ef3c9b15dc',group_name='Ascend International School'
where  group_id in ('e8e30890bb','ASCENDCARE');

  
update labirao.labirao_user_master
set  group_id='757890368c',group_name='Runxtreme'
where  (group_id in ('f7a263cd42') or group_name ='Run Xtreme');

update labirao.labirao_user_activity_report
set  group_id='757890368c',group_name='Runxtreme'
where  (group_id in ('f7a263cd42') or group_name ='Run Xtreme');
	 
	 
update labirao.labirao_user_master
set old_group_id=group_id,
group_id='e6c78d5fa1',group_name='ITC Ltd.'
where  
  group_id in ('b908ca76d0',
'ee0d8e5cb1',
'848c9becae',
'33b41eb45a',
'9bf239f6a9',
'827d9b778c',
'c317b9d133',
'c97e798262',
'6ee8e1516a',
'984a71c159',
'e07046d302');

update labirao.labirao_user_activity_report
set  
group_id='e6c78d5fa1',group_name='ITC Ltd.'
where   group_id in ('b908ca76d0',
'ee0d8e5cb1',
'848c9becae',
'33b41eb45a',
'9bf239f6a9',
'827d9b778c',
'c317b9d133',
'c97e798262',
'6ee8e1516a',
'984a71c159',
'e07046d302');



--if v_current_time< v_curr_date
---then
  select * from labirao.labirao_ins_upd_city_report()
  into v_out_city;
  
  select * from labirao.labirao_ins_upd_state_report()
  into v_out_state;
  
   select * from labirao.labirao_ins_upd_corporate_report()
  into v_out_group;
  
if v_out_group=1 and v_out_state=1 and v_out_city=1 then
p_out:=1;

end if;
--else 
--p_out:=1;
---end if;

end;
$_$;


--
