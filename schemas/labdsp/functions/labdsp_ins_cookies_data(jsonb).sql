-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_ins_cookies_data(jsonb)
-- Type: FUNCTION

-- Name: labdsp_ins_cookies_data(jsonb); Type: FUNCTION; Schema: labdsp; Owner: -
--

CREATE FUNCTION labdsp.labdsp_ins_cookies_data(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

     

declare

v_sysdate 			timestamp;
v_ipalabdspress  		character varying;
v_privacy_version   character varying;
v_terms_conditions_ver 	character varying;
v_cookies_policy_ver character varying;

BEGIN

		select current_timestamp at time zone 'utc'
		into   v_sysdate;
		
		SELECT 	p_json->'data'->>'ipalabdspress' ,
        		p_json->'data'->>'privacy_version' ,
                p_json->'data'->>'terms_conditions_version' ,
                p_json->'data'->>'cookies_policy_version' 
		INTO    v_ipalabdspress,
        		v_privacy_version,
                v_terms_conditions_ver,
                v_cookies_policy_ver;
		--------------------------------------------------------------- 
		insert into labdsp.labdsp_cookies_data
        (cookies_id, ip_alabdspress, created_date, privacy_version, terms_conditions_version, cookies_policy_version)
		select nextval('labdsp.seq_labdsp_cookies_id'), v_ipalabdspress, v_sysdate, v_privacy_version, v_terms_conditions_ver, 
        	v_cookies_policy_ver ;
		
		p_result := 1;

	exception
		when others then 		
			p_result := -1;

END;

     

$$;


--
