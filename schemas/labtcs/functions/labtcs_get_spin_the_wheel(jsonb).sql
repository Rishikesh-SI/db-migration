-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_get_spin_the_wheel(jsonb)
-- Type: FUNCTION

-- Name: labtcs_get_spin_the_wheel(jsonb); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_get_spin_the_wheel(p_json jsonb, OUT p_out numeric, OUT p_user_gratification jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare 
v_gratification_value numeric;
 v_better_luck_value numeric;
v_last_spin_date timestamp;
v_curr_date date:=current_date;
v_user_id numeric;
v_gift_id numeric:=0;
v_available_quantity numeric;
v_gift_name varchar(500);
v_is_gratified numeric:=0;
v_better_luck_id numeric;
v_seq numeric;
v_is_jersey_req numeric;
v_daily_gift_limit numeric:=3;
v_gift_assigned_count numeric:=0;
v_email_id text;
v_user_name varchar(500);
v_mobile_no varchar(500);
v_type varchar(500);
v_spin_again numeric;
begin
 
 
 select p_json->'data'->>'email_id',
       p_json->'data'->>'mobile_no',
	    p_json->'data'->>'name',
		p_json->'data'->>'type'
		into v_email_id,
		v_mobile_no,
		v_user_name,
		v_type;
		
 
if v_type='asics' then
 
select max(created_date)::date 
from labtcs.labtcs_gratification_details
where upper(email_id)=upper(v_email_id)
into v_last_spin_date;

 
---raise notice '%',v_last_spin_date;

if  exists(select 1 from labtcs.labtcs_gratification_details
		 where upper(email_id)=upper(v_email_id)) then

select gift_id 
   from labtcs.labtcs_gratification_gift
   where  is_flag=1
into v_better_luck_id;

select count(1)
from labtcs.labtcs_gratification_details
where upper(email_id)=upper(v_email_id)
and gift_id<>v_better_luck_id
into v_is_gratified;

---raise notice '%',v_is_gratified;
if v_last_spin_date=v_curr_date  
then
begin
select dg.gift_id,gg.gift_name
from labtcs.labtcs_gratification_details dg
join labtcs.labtcs_gratification_gift gg
on gg.gift_id=dg.gift_id
where upper(dg.email_id)=upper(v_email_id)
and  dg.created_date::date=v_last_spin_date::date
into v_gift_id,v_gift_name;

exception when no_data_found then
v_gift_id:=0;
end;

end if;

end if;

 ---  raise notice '%,%,%,%',v_email_id, v_curr_date,v_is_gratified,v_last_spin_date;
 if (v_email_id is not null 
	 and coalesce(v_last_spin_date,v_curr_date-2)<v_curr_date 
	 and v_is_gratified =0)
  then
  
   select gratification_value,better_luck_value
     from labtcs.labtcs_gratification_event 
     where event_id=1
     into v_gratification_value,v_better_luck_value;
	 
	select nextval('labtcs.labtcs_gratification_spin_seq')  
	into v_seq;
   
   if mod(v_seq,v_gratification_value)=0 then
 with tab as( select gift_id,gift_url,available_quantity,gift_name
     from labtcs.labtcs_gratification_gift
		where 	available_quantity>0	 
    order by RANDOM() 
    LIMIT 1) 
    select gift_id,available_quantity,gift_name
    from tab 
      into v_gift_id,v_available_quantity,v_gift_name;
												   
     update labtcs.labtcs_gratification_gift
     set available_quantity = available_quantity-1
     where gift_id =v_gift_id;
	 if v_gift_id <>5 then
	  insert into labtcs.labtcs_gratification_details
    values (nextval('labtcs.labtcs_gratification_detail_seq'),v_user_id,1,v_seq,v_gift_id,1,0,0,current_timestamp,null,
		   v_email_id,v_user_name,v_mobile_no);
     end if; 
	  if coalesce(v_gift_assigned_count,0)=0 then
	  insert into labtcs.labtcs_daily_gift_count
	  (gift_date,
	  gift_count)
	  select v_curr_date,
	  1;
	  else
	  update labtcs.labtcs_daily_gift_count
	  set gift_count=gift_count+1
	  where gift_date=v_curr_date;
	  end if;
	  end if; 
	   
     if (v_gift_id =0) then
     
      select gift_id,available_quantity,gift_name
     from labtcs.labtcs_gratification_gift
		where is_flag=1	 
      into v_gift_id,v_available_quantity,v_gift_name;
		
         if not exists(select 1 from labtcs.labtcs_gratification_details 
					  where upper(email_id)=upper(v_email_id)
					  and gift_id =v_gift_id
					  and created_date::date=v_curr_date) then
     insert into labtcs.labtcs_gratification_details
    values (nextval('labtcs.labtcs_gratification_detail_seq'),v_user_id,1,v_seq,v_gift_id,1,0,0,current_timestamp,null,
		   v_email_id,v_user_name,v_mobile_no);
		   end if;
      end if;
	  
	   
	  else
	  
	  --- raise notice '%,%,%',v_is_gratified,v_last_spin_date,v_curr_date;
	  if (v_is_gratified=0 or v_last_spin_date<v_curr_date) then
	   select gift_id,available_quantity,gift_name
     from labtcs.labtcs_gratification_gift
		where is_flag=1	 
      into v_gift_id,v_available_quantity,v_gift_name; 
	  
	   if not exists(select 1 from labtcs.labtcs_gratification_details 
					  where upper(email_id)=upper(v_email_id)
					  and gift_id=v_gift_id
					  and created_date::date=v_curr_date) then
	     insert into labtcs.labtcs_gratification_details
    values (nextval('labtcs.labtcs_gratification_detail_seq'),v_user_id,1,v_seq,v_gift_id,1,0,0,current_timestamp,null,
		   v_email_id,v_user_name,v_mobile_no);
		   end if;
		   
      end if;
	 end if;
	 
	 else --------bisleri
	 select max(created_date)::date 
from labtcs.labtcs_bisleri_gratification_details
where upper(email_id)=upper(v_email_id)
into v_last_spin_date;

select count(1)
from labtcs.labtcs_bisleri_gratification_details
where upper(email_id)=upper(v_email_id)
 and gift_id<>4
into v_is_gratified;

raise notice '%,%',v_last_spin_date,v_is_gratified;

if exists(select 1 from labtcs.labtcs_bisleri_gratification_details
		 where upper(email_id)=upper(v_email_id)
		 and gift_id<>4) then

 

if v_last_spin_date=v_curr_date
then
begin
select dg.gift_id,gg.gift_name
from labtcs.labtcs_bisleri_gratification_details dg
join labtcs.labtcs_bisleri_gratification_gift gg
on gg.gift_id=dg.gift_id
where upper(dg.email_id)=upper(v_email_id)
and  dg.created_date::date=v_last_spin_date::date
and dg.gift_id<>4
into v_gift_id,v_gift_name;

exception when no_data_found then
v_gift_id:=0;
end;

end if;

end if;
 

   ---raise notice '%,%,%,%',v_email_id, v_last_spin_date,v_is_gratified,v_curr_date;
 if (v_email_id is not null 
	-- and coalesce(v_last_spin_date,v_curr_date-2)<v_curr_date 
	 and v_is_gratified =0  )
  then
  raise notice '%,%,%,%',v_email_id, v_last_spin_date,v_is_gratified,v_curr_date;
  
   select gratification_value
     from labtcs.labtcs_bisleri_gratification_event 
     where event_id=1
     into v_gratification_value;
	 
	 raise notice '%',v_gratification_value;
	 
	select nextval('labtcs.labtcs_bisleri_gratification_spin_seq')  
	into v_seq;
	
	raise notice '%,%',v_gratification_value,v_seq;
   
   if mod(v_seq,v_gratification_value)=0 then
 with tab as( select gift_id,gift_url,available_quantity,gift_name
     from labtcs.labtcs_bisleri_gratification_gift
		where  gift_id<>3
    order by RANDOM() 
    LIMIT 1) 
    select gift_id,available_quantity,gift_name
    from tab 
      into v_gift_id,v_available_quantity,v_gift_name;
				raise notice '%',v_gift_id;								   
     update labtcs.labtcs_bisleri_gratification_gift
     set available_quantity = available_quantity+1
     where gift_id =v_gift_id;
	 
	  insert into labtcs.labtcs_bisleri_gratification_details
    values (nextval('labtcs.labtcs_bisleri_gratification_detail_seq'),v_user_id,1,v_seq,v_gift_id,1,0,0,current_timestamp,null,
		   v_email_id,v_user_name,v_mobile_no);
      
	  if coalesce(v_gift_assigned_count,0)=0 then
	  insert into labtcs.labtcs_bisleri_daily_gift_count
	  (gift_date,
	  gift_count)
	  select v_curr_date,
	  1;
	  else
	  update labtcs.labtcs_bisleri_daily_gift_count
	  set gift_count=gift_count+1
	  where gift_date=v_curr_date;
	  end if;
	  end if; 
	   
     
	  
  end if;
	 
	 end if;
	 
	 
	 p_out:=1;
	 
	 select '{"data":'||row_to_json(row)||'}'
		from ( select v_user_id as user_id,
			   null as user_guid,
			  v_gift_id as gift_id,
			  v_gift_name as gift_name,
			  v_email_id as email_id,
			  v_user_name as user_name,
			  v_mobile_no as mobile_no,
			  case when v_last_spin_date=v_curr_date then v_last_spin_date::date else null end
			  as spin_date
			) row into 
			p_user_gratification;
 /*
exception 
when no_data_found then
p_out:=2;
when others then
p_out:=-1; */
				 
end;			 
				 
  $$;


--
