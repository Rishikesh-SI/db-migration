-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr
-- Object: labkkr_ins_cookies_data(jsonb)
-- Type: FUNCTION

-- Name: labkkr_ins_cookies_data(jsonb); Type: FUNCTION; Schema: labkkr; Owner: -
--

CREATE FUNCTION labkkr.labkkr_ins_cookies_data(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

     

declare

v_sysdate 			timestamp;
v_ipaddress  		character varying;
v_privacy_version   character varying;
v_terms_conditions_ver 	character varying;
v_cookies_policy_ver character varying;

BEGIN

		select current_timestamp at time zone 'utc'
		into   v_sysdate;
		
		SELECT 	p_json->'data'->>'ipaddress' ,
        		p_json->'data'->>'privacy_version' ,
                p_json->'data'->>'terms_conditions_version' ,
                p_json->'data'->>'cookies_policy_version' 
		INTO    v_ipaddress,
        		v_privacy_version,
                v_terms_conditions_ver,
                v_cookies_policy_ver;
		--------------------------------------------------------------- 
		insert into labkkr.labkkr_cookies_data
        (cookies_id, ip_address, created_date, privacy_version, terms_conditions_version, cookies_policy_version)
		select nextval('labkkr.seq_labkkr_cookies_id'), v_ipaddress, v_sysdate, v_privacy_version, v_terms_conditions_ver, 
        	v_cookies_policy_ver ;
		
		p_result := 1;

	/*exception
		when others then 		
			p_result := -1;
*/
END;

     

$$;


--
