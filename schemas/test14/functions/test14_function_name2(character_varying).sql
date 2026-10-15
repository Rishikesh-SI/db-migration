-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: test14
-- Object: test14_function_name2(character varying)
-- Type: FUNCTION

-- Name: test14_function_name2(character varying); Type: FUNCTION; Schema: test14; Owner: -
--

CREATE FUNCTION test14.test14_function_name2(p_username character varying) RETURNS TABLE(user_id integer, username character varying, created_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO test14.users (username)
    VALUES (p_username)
    RETURNING
        users.user_id,
        users.username,
        users.created_at
    INTO
        user_id, username, created_at;

    RETURN NEXT;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
