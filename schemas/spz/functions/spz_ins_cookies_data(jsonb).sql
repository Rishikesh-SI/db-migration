-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_ins_cookies_data(jsonb)
-- Type: FUNCTION

-- Name: spz_ins_cookies_data(jsonb); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_ins_cookies_data(p_json jsonb, OUT p_result numeric) RETURNS numeric
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

		insert into spz.spz_cookies_data
		select nextval('spz.seq_spz_cookies_id'), v_ipaddress, v_sysdate;
		
		p_result := 1;

	exception
		when others then 		
			p_result := -1;

END;

     

$$;


--
