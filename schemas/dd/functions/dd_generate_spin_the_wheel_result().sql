-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_generate_spin_the_wheel_result()
-- Type: FUNCTION

-- Name: dd_generate_spin_the_wheel_result(); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_generate_spin_the_wheel_result(OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
v_gratification_value numeric;
 v_better_luck_value numeric;
v_last_spin_date timestamp;
v_curr_date date := current_date;
v_user_id numeric;
v_gift_id numeric:=0;
v_available_quantity numeric;
v_gift_name varchar(500);
v_is_gratified numeric:=0;
v_better_luck_id numeric;
v_seq numeric;
v_is_jersey_req numeric;
v_daily_gift_limit numeric:=6;
v_gift_assigned_count numeric ;
i record;
v_daily_gift_count numeric;
v_from_date timestamp;
v_to_date timestamp;
 
begin
 
--  v_curr_date := '2023-04-25';
  
  v_from_date:= v_curr_date  - interval '5 hours 30 minute';
  v_to_date:= (v_curr_date + 1)  - interval '5 hours 30 minute';
  
 
  -- select 1/0;
  
     select gratification_value
     from dd.dd_gratification_event 
     where event_id = 1
     into v_gratification_value;
	 
	  --raise notice '%',v_gratification_value;
	  
	 for i in (select gift_id,daily_count
			  from dd.dd_gratification_gift
			  where available_quantity>0 and is_active = 1)
			  loop
			  
			v_gift_id := i.gift_id;
			v_daily_gift_count := i.daily_count;
			
			-- raise notice '%',v_gratification_value;
			
	with cte as(select gt.*
    from dd.dd_gratification_details gt
   where gt.created_date>v_from_date and gt.created_date<=v_to_date
 and mod(nth_num,v_gratification_value)=0
 and gift_id = v_gift_id
 and not exists(select 1 from  dd.dd_daily_gratification_winners w
			   where w.user_id=gt.user_id)
limit 	v_daily_gift_count)

   
  
  insert into dd.dd_daily_gratification_winners
    select nextval('dd.seq_dd_daily_gratification_winners')
	,user_id,1,nth_num,gift_id,1,0,0,v_curr_date,null
	from cte;
			 	 	 
	  
     update dd.dd_gratification_gift
     set available_quantity = available_quantity-v_daily_gift_count
     where gift_id =i.gift_id;
			  
			  
			  end loop;
			  
 
	 p_out:=1;
	  
 /*
exception 
when no_data_found then
p_out:=2;
when others then
p_out:=-1; */
				 
end;
$$;


--
