-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: create_client_user(text, text, text, text)
-- Type: FUNCTION

-- Name: create_client_user(text, text, text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.create_client_user(p_client_name text, p_username text, p_password text, v_option_type text) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
DECLARE
    v_user_id bigint;
    v_client_id bigint;
    v_schema text;
	p_result numeric;
	v_option_type text;
	
BEGIN

if upper(v_option_type) = 'LB' then

    SELECT nextval('waf_master.seq_waf_user_id')
    INTO v_user_id;


    SELECT client_id
    INTO v_client_id
    FROM waf_master.waf_client
    WHERE (client_code) = (p_client_name) || '01';

raise notice 'v_client_id %',v_client_id;

    IF v_client_id IS NULL THEN
        RAISE EXCEPTION 'Client % not found', p_client_name;
    END IF;

   
    INSERT INTO waf_master.waf_user
    VALUES (
        v_user_id,
        p_username,
        p_username,
        p_username,
        1,
        null,
        null,
        current_timestamp,
        current_timestamp,
        1,
        1,
        1,
        0,
        1,
        uuid_generate_v4(),
        p_password
    );

    INSERT INTO waf_master.waf_user_client_map
    VALUES (
        nextval('waf_master.seq_waf_user_client_map_id'),
        v_user_id,
        v_client_id,
        current_timestamp,
        current_timestamp,
        1,
        1,
        1,
        0,
        1,
        current_timestamp,
        uuid_generate_v4()
    );


elsif upper(v_option_type) = 'CMS' then

    v_schema := 'lab' || lower(p_client_name);

    EXECUTE format(
        'INSERT INTO %I.%I_user
         VALUES ($1,$1,$2,current_timestamp,current_timestamp,
                 1,1,1,0,1,current_timestamp,uuid_generate_v4())',
        v_schema,
        v_schema
    )
    USING v_user_id, v_client_id;
end if;

	p_result := 1;

END;
$_$;


--
