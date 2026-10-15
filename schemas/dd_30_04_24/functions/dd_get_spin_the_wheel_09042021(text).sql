-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_get_spin_the_wheel_09042021(text)
-- Type: FUNCTION

-- Name: dd_get_spin_the_wheel_09042021(text); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_get_spin_the_wheel_09042021(p_user_guid text, OUT p_out numeric, OUT p_user_gratification jsonb) RETURNS record
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
into strict v_user_id,v_last_spin_date
from dd.dd_web_user
where user_guid=p_user_guid;

 
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
	  )
  then
  
  
	select nextval('dd.dd_gratification_spin_seq')  
	into v_seq;
   
   
 with tab as( select gift_id,gift_url,available_quantity,gift_name
     from dd.dd_gratification_gift
		where 	available_quantity>0	 
    order by RANDOM() 
    LIMIT 1) 
    select gift_id,available_quantity,gift_name
    from tab 
      into v_gift_id,v_available_quantity,v_gift_name;
												   
      insert into dd.dd_gratification_details
    values (nextval('dd.dd_gratification_detail_seq'),v_user_id,1,v_seq,v_gift_id,1,0,0,current_timestamp,null);
      
	   
	   update dd.dd_web_user
	  set last_spin_date=v_curr_date
     where user_id=v_user_id;
	  
	 
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
