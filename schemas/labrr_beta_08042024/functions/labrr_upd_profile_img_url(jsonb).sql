-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_upd_profile_img_url(jsonb)
-- Type: FUNCTION

-- Name: labrr_upd_profile_img_url(jsonb); Type: FUNCTION; Schema: labrr_beta_08042024; Owner: -
--

CREATE FUNCTION labrr_beta_08042024.labrr_upd_profile_img_url(p_json jsonb, OUT v_json jsonb, OUT p_status numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare

v_user_id numeric;
v_img_url character varying;
v_status numeric;

begin

select p_json->'data'->>'user_id',
	   p_json->'data'->>'image'
into
	v_user_id,
	v_img_url;

update labrr.labrr_web_user
set profile_picture_url=v_img_url
where user_id=v_user_id;

if exists(select 1 from labrr.labrr_web_user
		 where user_id=v_user_id
		 and profile_picture_url=v_img_url) then
		 
		 v_status:=1;
		 
else

v_status:=-1;

end if;
		 
	v_json:=p_json;
	p_status:=v_status;

end
$$;


--
