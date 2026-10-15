-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_upd_user_detail(jsonb)
-- Type: FUNCTION

-- Name: labmao_upd_user_detail(jsonb); Type: FUNCTION; Schema: labmao; Owner: -
--

CREATE FUNCTION labmao.labmao_upd_user_detail(p_json jsonb, OUT p_out numeric) RETURNS numeric
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
p_json ->>'category'
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
v_category;

select count(1)
from labmao.labmao_user_master
where upper(email_id)=coalesce(upper(v_email_id),'X') or bib_no=coalesce(v_bib_no,0)
into v_exists;

 if v_exists>0 then
 
 if v_user_name is not null then
 update labmao.labmao_user_master
 set user_name=v_user_name,admin_updated_date=v_curr_date
 where upper(email_id)=upper(v_email_id) or bib_no=coalesce(v_bib_no,0);
 
  update labmao.labmao_user_activity_report
 set  user_name=v_user_name 
 where upper(email_id)=upper(v_email_id) or bib_no=coalesce(v_bib_no,0);

  p_out:=1;
  end if;
  
  
  
 if v_dob is not null then
 update labmao.labmao_user_master
 set dob=v_dob,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id) or bib_no=coalesce(v_bib_no,0);
 
 update labmao.labmao_user_activity_report
 set dob=v_dob
 where upper(email_id)=upper(v_email_id) or bib_no=coalesce(v_bib_no,0);

  p_out:=1;
  end if;
  
  
  
 if v_category is not null then
 update labmao.labmao_user_master
 set category=v_category,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id) or bib_no=coalesce(v_bib_no,0);
 
  p_out:=1;
  end if;
  
  
  
  if v_gender is not null then
 update labmao.labmao_user_master
 set gender=v_gender,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id) or bib_no=coalesce(v_bib_no,0);
 
 update labmao.labmao_user_activity_report
 set gender=v_gender
 where upper(email_id)=upper(v_email_id) or bib_no=coalesce(v_bib_no,0);

  p_out:=1;
  end if;
  
   if v_group_name is not null and v_group_id is not null then
 update labmao.labmao_user_master
 set group_name=case when v_group_name='X' then null else v_group_name end,
 group_id=case when v_group_id='X' then null else v_group_id end,
 admin_updated_date=v_curr_date
 where upper(email_id)=upper(v_email_id) or bib_no=coalesce(v_bib_no,0);
 
 update labmao.labmao_user_activity_report
 set group_name=case when v_group_name='X' then null else v_group_name end,
 group_id=case when v_group_id='X' then null else v_group_id end
where upper(email_id)=upper(v_email_id) or bib_no=coalesce(v_bib_no,0);

  p_out:=1;
  end if;
  
  
  if v_state_name is not null then
 update labmao.labmao_user_master
 set state_name=v_state_name,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id) or bib_no=coalesce(v_bib_no,0);
 
 update labmao.labmao_user_activity_report
 set state_name=v_state_name
 where upper(email_id)=upper(v_email_id) or bib_no=coalesce(v_bib_no,0);

  p_out:=1;
  end if;
  
  
  
   if v_city is not null then
 update labmao.labmao_user_master
 set city=v_city,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id) or bib_no=coalesce(v_bib_no,0);
 
 update labmao.labmao_user_activity_report
 set  city=v_city
where upper(email_id)=upper(v_email_id) or bib_no=coalesce(v_bib_no,0);

  p_out:=1;
  end if;
  
  if v_pledged_distance is not null then
 update labmao.labmao_user_master
 set pledged_distance=cast(v_pledged_distance as varchar(500)),admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id) or bib_no=coalesce(v_bib_no,0);
 
 update labmao.labmao_user_activity_report
 set  pledged_distance=v_pledged_distance
where upper(email_id)=upper(v_email_id) or bib_no=coalesce(v_bib_no,0);

  p_out:=1;
  end if;
  
  if v_mobile_no is not null then
 update labmao.labmao_user_master
 set mobile_no=v_mobile_no,admin_updated_date=v_curr_date
where upper(email_id)=upper(v_email_id) or bib_no=coalesce(v_bib_no,0);
 
 p_out:=1;
  end if;
 
 
 
 
 else 
 p_out:=2;
 
 end if;

---exception when others then

end;
$$;


--
