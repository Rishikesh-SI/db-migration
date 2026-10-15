-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_get_user_last_spin_detail(text)
-- Type: FUNCTION

-- Name: labtcs_get_user_last_spin_detail(text); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_get_user_last_spin_detail(p_user_guid text, OUT p_user_last_spin_data jsonb) RETURNS jsonb
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
from labtcs.labtcs_web_user
where user_guid=p_user_guid
into v_user_id,v_last_spin_date;
 

 
if v_last_spin_date=v_curr_date
then
begin
select dg.gift_id,gg.gift_name
from labtcs.labtcs_gratification_details dg
join labtcs.labtcs_gratification_gift gg
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
			  v_is_jersey_req as jersey_req,
			  case when v_last_spin_date=v_curr_date then v_last_spin_date::date else null end
			  as spin_date
			) row into 
			p_user_last_spin_data;

end;

				 
  $$;


--
