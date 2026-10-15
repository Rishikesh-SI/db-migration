-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_upd_user_detail(jsonb)
-- Type: FUNCTION

-- Name: tmm_upd_user_detail(jsonb); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_upd_user_detail(p_json jsonb, OUT p_out numeric, OUT p_ret_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare 
 v_curr_date timestamp:=current_timestamp;
 v_email_id text;
 v_user_name varchar(500);
 v_dob timestamp;
 v_group_name varchar(500);
 v_group_id varchar(500);
 v_state_name varchar(500);
 v_city varchar(500);
 v_exists numeric;
 v_mobile_no varchar(500);
 v_bib_no numeric;
 v_pledged_distance numeric(10,4);
 v_gender varchar(10);
 v_category varchar(500);
 v_ngo_name varchar(500);
	v_tee_size varchar(500);
	v_donation_amount varchar(500);
	v_ticket_amount varchar(500);
	v_medal_amount varchar(500);
	v_gst_amount varchar(500);
	v_race_tee_amount varchar(500);
	v_address varchar(500);
	v_country varchar(500);
	v_status varchar(100);
	v_run_club_name varchar(500);
begin

select p_json ->>'registered_email',
p_json ->>'user_name',
p_json ->>'dob',
p_json ->>'group_name',
p_json ->>'group_code',
p_json ->>'new_state',
p_json ->>'new_city',
p_json ->>'phone_number',
p_json ->>'bib_no',
p_json ->>'pledge_distance',
p_json ->>'gender',
p_json ->>'category',
p_json ->>'ngo_name',
p_json ->>'donation_amount',
p_json ->>'ticket_amount',
p_json ->>'race_tee_amount',
p_json ->>'medal_amount',
p_json ->>'gst_amount',
p_json ->>'address',
p_json ->>'country',
p_json ->>'tee_size',
p_json ->>'run_club_name'

into v_email_id,
v_user_name,
v_dob,
v_group_name,
v_group_id,
v_state_name,
v_city,
v_mobile_no,
v_bib_no,
v_pledged_distance,
v_gender,
v_category,
v_ngo_name,
v_donation_amount,
v_ticket_amount,
v_race_tee_amount,
v_medal_amount,
v_gst_amount,
v_address,
v_country,
v_tee_size,
v_run_club_name;

select count(1)
from tmm.tmm_user_master
where upper(email_id)=coalesce(upper(v_email_id),'X') or bib_no=coalesce(v_bib_no,0)
into v_exists;
 if v_exists>0 then
 
 if v_user_name is not null then
 update tmm.tmm_user_master
 set user_name=v_user_name,admin_updated_date=v_curr_date
 where upper(email_id)=upper(v_email_id)  ;
 
 
  p_out:=1;
  end if;
  
 if v_dob is not null then
 update tmm.tmm_user_master
 set dob=v_dob,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id) ;
 
  
  p_out:=1;
  end if;
  
  if v_category is not null then
 update tmm.tmm_user_master
 set category=v_category,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id) ;
  
  p_out:=1;
  end if;
  
  
   if v_gender is not null then
 update tmm.tmm_user_master
 set gender=v_gender,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id) ;
 
  
  p_out:=1;
  end if;
  
  
   if v_group_name is not null and v_group_id is not null then
 update tmm.tmm_user_master
 set group_name=case when v_group_name='X' then null else v_group_name end,
 group_id=case when v_group_name='X' then null else v_group_id end,
 admin_updated_date=v_curr_date
 where upper(email_id)=upper(v_email_id) ;
 
 
  p_out:=1;
  end if;
  
  
  if v_state_name is not null then
 update tmm.tmm_user_master
 set state_name=v_state_name,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id)  ;
 
  
  p_out:=1;
  end if;
  
  
  
   if v_city is not null then
 update tmm.tmm_user_master
 set city=v_city,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id)  ;
 
 
  p_out:=1;
  end if;
  
  if v_pledged_distance is not null then
 update tmm.tmm_user_master
 set pledged_distance=cast(v_pledged_distance as varchar(500)),admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id) ;
 
 
  p_out:=1;
  end if;
  
  if v_mobile_no is not null then
 update tmm.tmm_user_master
 set mobile_no=v_mobile_no,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id)  ;
 
 p_out:=1;
  end if;

  if v_ngo_name is not null then
 update tmm.tmm_user_master
 set ngo_name=v_ngo_name,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id)  ;
 
 p_out:=1;
  end if;

  if v_donation_amount is not null then
 update tmm.tmm_user_master
 set donation_amount=v_donation_amount,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id)  ;
 
 p_out:=1;
  end if;
  
  if   v_bib_no is not null then
  
  if not exists(select 1 from tmm.tmm_user_master where bib_no=v_bib_no  )
  then
 update tmm.tmm_user_master
 set bib_no=v_bib_no,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id)  ;
 
 p_out:=1;
 
 else
 p_out:=3;
 
 if not exists(select 1 from tmm.tmm_user_master
		   where bib_no=v_bib_no and upper(email_id)=upper(v_email_id) ) then
 select row_to_json(row)

from (select user_name,email_id,bib_no
 from tmm.tmm_user_master
 where bib_no=v_bib_no) as row
 into p_ret_json
 ;
  
  end if;
 
 end if;
  end if;
  

  if v_ticket_amount is not null then
 update tmm.tmm_user_master
 set ticket_amount=v_ticket_amount,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id)  ;
 
 p_out:=1;
  end if;

  if v_race_tee_amount is not null then
 update tmm.tmm_user_master
 set race_tee_amount=v_race_tee_amount,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id)  ;
 
 p_out:=1;
  end if;

  if v_medal_amount is not null then
 update tmm.tmm_user_master
 set medal_amount=v_medal_amount,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id)  ;
 
 p_out:=1;
  end if;

  if v_gst_amount is not null then
 update tmm.tmm_user_master
 set gst_amount=v_gst_amount,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id)  ;
 
 p_out:=1;
  end if;

  if v_address is not null then
 update tmm.tmm_user_master
 set address=v_address,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id)  ;
 
 p_out:=1;
  end if;

  if v_country is not null then
 update tmm.tmm_user_master
 set country=v_country,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id)  ;
 
 p_out:=1;
  end if;

  if v_tee_size is not null then
 update tmm.tmm_user_master
 set tee_size=v_tee_size,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id)  ;
 
 p_out:=1;
  end if;

  if v_run_club_name is not null then
 update tmm.tmm_user_master
 set run_club_name=v_run_club_name,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id)  ;
 
 p_out:=1;
  end if;

 
 
 
 
 else 
 p_out:=2;
 
 end if;

---exception when others then

end;
$$;


--
