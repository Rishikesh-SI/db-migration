-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_get_spin_the_wheel_bkp(text)
-- Type: FUNCTION

-- Name: dd_get_spin_the_wheel_bkp(text); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_get_spin_the_wheel_bkp(p_user_guid text, OUT p_out numeric, OUT p_user_gratification jsonb) RETURNS record
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
begin

select user_id, last_spin_date 
from dd.dd_web_user
where user_guid=p_user_guid
into v_user_id,v_last_spin_date;

select count(1)
from  dd.dd_user_jersey_request
where user_id=v_user_id
into v_is_jersey_req;

begin
select gift_count
from dd.dd_daily_gift_count
where gift_date=v_curr_date
into v_gift_assigned_count;
exception
when no_data_found then
v_gift_assigned_count:=0;

end;

if v_last_spin_date is not null then

select gift_id 
   from dd.dd_gratification_gift
   where  is_flag=1
into v_better_luck_id;

select count(1)
from dd.dd_gratification_details
where user_id=v_user_id 
and gift_id<>v_better_luck_id
into v_is_gratified;

if v_last_spin_date=v_curr_date
then
begin
select dg.gift_id,gg.gift_name
from dd.dd_gratification_details dg
join dd.dd_gratification_gift gg
on gg.gift_id=dg.gift_id
where dg.user_id=v_user_id 
and  dg.created_date::date=v_last_spin_date::date
into v_gift_id,v_gift_name;

exception when no_data_found then
v_gift_id:=0;
end;

end if;

end if;
 --- raise notice '%,%,%,%,%',v_user_id, v_last_spin_date,v_is_gratified,v_gift_assigned_count,
--- v_daily_gift_limit;
   
 if (v_user_id is not null 
	 and coalesce(v_last_spin_date,v_curr_date-2)<v_curr_date 
	 and v_is_gratified =0 and coalesce(v_gift_assigned_count,0)<v_daily_gift_limit)
  then
  
   select gratification_value,better_luck_value
     from dd.dd_gratification_event 
     where event_id=1
     into v_gratification_value,v_better_luck_value;
	 
	select nextval('dd.dd_gratification_spin_seq')  
	into v_seq;
   
   if mod(v_seq,v_gratification_value)=0 then
 with tab as( select gift_id,gift_url,available_quantity,gift_name
     from dd.dd_gratification_gift
		where 	available_quantity>0	 
    order by RANDOM() 
    LIMIT 1) 
    select gift_id,available_quantity,gift_name
    from tab 
      into v_gift_id,v_available_quantity,v_gift_name;
												   
     update dd.dd_gratification_gift
     set available_quantity = available_quantity-1
     where gift_id =v_gift_id;
 
	  insert into dd.dd_gratification_details
    values (nextval('dd.dd_gratification_detail_seq'),v_user_id,1,v_seq,v_gift_id,1,0,0,current_timestamp,null);
      
	  if coalesce(v_gift_assigned_count,0)=0 then
	  insert into dd.dd_daily_gift_count
	  (gift_date,
	  gift_count)
	  select v_curr_date,
	  1;
	  else
	  update dd.dd_daily_gift_count
	  set gift_count=gift_count+1
	  where gift_date=v_curr_date;
	  end if;
	  end if; 
	   
     if (v_gift_id =0) then
     
      select gift_id,available_quantity,gift_name
     from dd.dd_gratification_gift
		where is_flag=1	 
      into v_gift_id,v_available_quantity,v_gift_name;
		
         
     insert into dd.dd_gratification_details
    values (nextval('dd.dd_gratification_detail_seq'),v_user_id,1,v_seq,v_gift_id,1,0,0,current_timestamp,null);
      end if;
	  
	  update dd.dd_web_user
	  set last_spin_date=v_curr_date
     where user_id=v_user_id;
	  
	  else
	  if (v_is_gratified=0 or coalesce(v_last_spin_date,v_curr_date-2)<v_curr_date) then
	   select gift_id,available_quantity,gift_name
     from dd.dd_gratification_gift
		where is_flag=1	 
      into v_gift_id,v_available_quantity,v_gift_name; 
	  
	  if (coalesce(v_last_spin_date,v_curr_date-2)<v_curr_date and v_user_id is not null) then
	     insert into dd.dd_gratification_details
    values (nextval('dd.dd_gratification_detail_seq'),v_user_id,1,v_seq,v_gift_id,1,0,0,current_timestamp,null);
 
	
	    update dd.dd_web_user
	  set last_spin_date=v_curr_date
     where user_id=v_user_id;
	    end if;
	 end if;
	 end if;
	 
	 p_out:=1;
	 
	 select '{"data":'||row_to_json(row)||'}'
		from ( select v_user_id as user_id,
			   p_user_guid as user_guid,
			  v_gift_id as gift_id,
			  v_gift_name as gift_name,
			  v_is_jersey_req as jersey_req,
			  case when v_last_spin_date=v_curr_date then v_last_spin_date::date else null end
			  as spin_date
			) row into 
			p_user_gratification;
 
exception 
when no_data_found then
p_out:=2;
when others then
p_out:=-1;  
				 
end;			 
				 
  $$;


--
