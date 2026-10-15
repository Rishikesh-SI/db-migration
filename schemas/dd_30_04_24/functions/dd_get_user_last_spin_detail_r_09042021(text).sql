-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_get_user_last_spin_detail_r_09042021(text)
-- Type: FUNCTION

-- Name: dd_get_user_last_spin_detail_r_09042021(text); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_get_user_last_spin_detail_r_09042021(p_user_guid text, OUT p_user_last_spin_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
 v_user_id numeric;
v_gift_id numeric:=0;
v_available_quantity numeric;
v_gift_name varchar(500);
v_is_gratified numeric:=0;
v_better_luck_id numeric;
v_is_jersey_req numeric;
v_curr_date date:=current_date;
v_last_spin_date date;

begin

select user_id, last_spin_date 
from dd.dd_web_user
where user_guid=p_user_guid
into v_user_id,v_last_spin_date;
/*
select count(1)
from  dd.dd_user_jersey_request
where user_id=v_user_id
into v_is_jersey_req;
*/
 
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

select '{"data":'||row_to_json(row)||'}'
		from ( select v_user_id as user_id,
			   p_user_guid as user_guid,
			  v_gift_id as gift_id,
			  v_gift_name as gift_name,
			  0 as jersey_req,
			  case when v_last_spin_date=v_curr_date then v_last_spin_date::date else null end
			  as spin_date
			) row into 
			p_user_last_spin_data;

end;
$$;


--
