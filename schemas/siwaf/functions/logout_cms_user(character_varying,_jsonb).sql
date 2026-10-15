-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _logout_cms_user(character varying, jsonb)
-- Type: FUNCTION

-- Name: _logout_cms_user(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._logout_cms_user(p_schema_prefix character varying, p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	

	v_user_id numeric;

begin
	
	select  p_json->>'user_id'
    into v_user_id;
	
	execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_user
			 set is_login = 0,session_start_time = null
			 where user_id = '||v_user_id;
			 
	p_result := 1 ;		 

end;
$$;


--
