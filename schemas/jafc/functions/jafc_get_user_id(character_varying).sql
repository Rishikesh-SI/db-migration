-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_get_user_id(character varying)
-- Type: FUNCTION

-- Name: jafc_get_user_id(character varying); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.jafc_get_user_id(p_user_name character varying, OUT p_user_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

begin
select user_id into p_user_id

from jafc.jafc_user
where upper(full_name)=upper(p_user_name);
 exception when others then p_user_id:= -1;
end

$$;


--
