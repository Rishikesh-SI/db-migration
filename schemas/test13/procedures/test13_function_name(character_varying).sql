-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: test13
-- Object: test13_function_name(character varying)
-- Type: PROCEDURE

-- Name: test13_function_name(character varying); Type: PROCEDURE; Schema: test13; Owner: -
--

CREATE PROCEDURE test13.test13_function_name(IN p_username character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO test13.users (username)
    VALUES (p_username);

    RAISE NOTICE 'User % inserted successfully', p_username;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
