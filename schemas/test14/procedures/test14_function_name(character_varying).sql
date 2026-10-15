-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: test14
-- Object: test14_function_name(character varying)
-- Type: PROCEDURE

-- Name: test14_function_name(character varying); Type: PROCEDURE; Schema: test14; Owner: -
--

CREATE PROCEDURE test14.test14_function_name(IN p_username character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO test14.users (username)
    VALUES (p_username);

    RAISE NOTICE 'User % inserted successfully', p_username;
END;
$$;


--
