-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_get_fb_users_detail()
-- Type: FUNCTION

-- Name: tmm_get_fb_users_detail(); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_get_fb_users_detail(OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
    v_start_date_time timestamp;
    v_end_date_time timestamp;
    v_opt_type numeric;
begin
/*
FB - 2
Twitter -3
Custom -5
Gplus - 4

*/
	 select ('{"data":'||jsonb_agg(tab)::text||'}') ::jsonb into p_json
	 from (
	 select social_user_name,email_id,social_id,user_guid,acces_token 
		 from tmm.tmm_web_user
	 where client_id=2) tab;
end;

$$;


--
