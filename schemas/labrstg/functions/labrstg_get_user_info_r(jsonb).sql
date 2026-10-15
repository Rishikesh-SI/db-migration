-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_get_user_info_r(jsonb)
-- Type: FUNCTION

-- Name: labrstg_get_user_info_r(jsonb); Type: FUNCTION; Schema: labrstg; Owner: -
--

CREATE FUNCTION labrstg.labrstg_get_user_info_r(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare

v_user_id numeric;

v_user_name character varying;
v_image_url character varying;

begin
	
 	--select p_json->'data'->>'user_guid'
	select p_json->'data'->>'user_id'
	into
	v_user_id;
	
	select to_json(row_alias)
	   from (select social_user_name,profile_picture_url,user_id
	--into v_user_name,v_image_url
	from labrstg.labrstg_web_user
	where user_id=v_user_id)
	   row_alias
	into p_data ;
	
	p_result:=1;
	
	end;
$$;


--
