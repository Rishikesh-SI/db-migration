-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_upd_profile_img_url(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_upd_profile_img_url(jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_upd_profile_img_url(p_json jsonb, OUT v_json jsonb, OUT p_status numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare

v_user_id numeric;
v_img_url character varying;
v_status numeric;
v_user_guid text;
begin

select p_json->'data'->>'user_id',
	   p_json->'data'->>'image'
into
	v_user_id,
	v_img_url;

update labkc_v1.labkc_v1_web_user
set profile_picture_url=v_img_url
where user_id=v_user_id;

select user_guid into v_user_guid
from labkc_v1.labkc_v1_web_user
where user_id=v_user_id;

if exists(select 1 from labkc_v1.labkc_v1_web_user
		 where user_id=v_user_id
		 and profile_picture_url=v_img_url) then

		 insert into labkc_v1.labkc_v1_profile_image_data
		values(nextval('labkc_v1.seq_labkc_v1_data_id'), 'labkc_v1', v_user_guid, current_timestamp, current_timestamp);

		 v_status:=1;
		 
else

v_status:=-1;

end if;
		 
	v_json:=p_json;
	p_status:=v_status;

end
$$;


--
