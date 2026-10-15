-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: test_regex()
-- Type: FUNCTION

-- Name: test_regex(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.test_regex() RETURNS TABLE(col text)
    LANGUAGE plpgsql
    AS $$
DECLARE
    line TEXT;
    regex_match TEXT[];
BEGIN
    line := 'JOIN labfih_entity_master.entity_id = ...';

    FOR regex_match IN
        SELECT regexp_matches(
            line,
            'labfih_entity_master\.(\w+)',
            'g'
        )
    LOOP
        col := regex_match[1];
        RETURN NEXT;
    END LOOP;
END;
$$;


--
