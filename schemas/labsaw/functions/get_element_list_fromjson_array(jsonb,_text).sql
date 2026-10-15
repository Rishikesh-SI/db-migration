-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: get_element_list_fromjson_array(jsonb, text)
-- Type: FUNCTION

-- Name: get_element_list_fromjson_array(jsonb, text); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.get_element_list_fromjson_array(p_value jsonb, p_keyname text) RETURNS text
    LANGUAGE sql
    AS $$ 
   select  string_agg(DISTINCT x.val ->> p_keyname, ',')
   from jsonb_array_elements(p_value) as x(val);
$$;


--
