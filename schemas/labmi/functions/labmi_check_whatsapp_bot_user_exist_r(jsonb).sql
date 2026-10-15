-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_check_whatsapp_bot_user_exist_r(jsonb)
-- Type: FUNCTION

-- Name: labmi_check_whatsapp_bot_user_exist_r(jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_check_whatsapp_bot_user_exist_r(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
/* input of function:-

select * from labmi.labmi_check_whatsapp_bot_user_exist_r(
'{
  "mobile_no": "5lrGbDuFlMcrtjyoZRwy10kkFLs+tNrkezRA0uPKkSY="
}') */
v_mobile_no character varying(1000);

begin

select  p_inputjson->>'mobile_no'
into v_mobile_no;

if exists (select 1 from labmi.labmi_web_user
  where mobile_no = v_mobile_no and is_verified = 1) then
 
select  ('{"data":'||row_to_json(row)::text||'}')::jsonb into p_data
from (select campaign_id, case campaign_id when 1 then 'Blue'
when 3 then 'Silver'
when 4 then 'Gold'
  else '' end as Membership_name, 1 as already_exists   from labmi.labmi_web_user
  where mobile_no = v_mobile_no and is_verified = 1 )row;


else
 
  if exists (select 1 from labmi.labmi_whatsapp_bot_user
where mobile_no = v_mobile_no) then

select  ('{"data":'||row_to_json(row)::text||'}')::jsonb into p_data
from (select null as campaign_id,  '' as Membership_name, 1 as already_exists  )row;

 else

select  ('{"data":'||row_to_json(row)::text||'}')::jsonb into p_data
from (select null as campaign_id,  '' as Membership_name, 0 as already_exists  )row;

 end if;
 
 

end if;


end;

$$;


--
