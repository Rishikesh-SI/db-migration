-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_ins_cookies_data(jsonb)
-- Type: FUNCTION

-- Name: isl_ins_cookies_data(jsonb); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_ins_cookies_data(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
     

declare

v_sysdate 			timestamp;
v_ipaddress  		character varying;

BEGIN

		select current_timestamp at time zone 'utc'
		into   v_sysdate;
		
		SELECT 	p_json->'data'->>'ipaddress' 
		INTO    v_ipaddress;
		---------------------------------------------------------------        

		insert into isl.isl_cookies_data
		select nextval('isl.seq_isl_cookies_id'), v_ipaddress, v_sysdate;
		
		p_result := 1;

	exception
		when others then 		
			p_result := -1;

END;

     
$$;


--
