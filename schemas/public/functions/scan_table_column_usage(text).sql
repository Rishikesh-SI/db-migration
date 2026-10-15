-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: scan_table_column_usage(text)
-- Type: FUNCTION

-- Name: scan_table_column_usage(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.scan_table_column_usage(p_table text) RETURNS TABLE(fn_name text, matched_line text)
    LANGUAGE plpgsql
    AS $$
DECLARE
    p_oid OID;
    f_sql TEXT;
    p_name TEXT;
    line_array TEXT[];
    i INT;
BEGIN
    FOR p_oid IN
        SELECT p.oid
        FROM pg_proc p
        JOIN pg_namespace n ON n.oid = p.pronamespace
        WHERE pg_get_functiondef(p.oid) ILIKE '%' || p_table || '%'
          AND n.nspname NOT IN ('pg_catalog', 'information_schema')
    LOOP
        f_sql := pg_get_functiondef(p_oid);
        p_name := (SELECT proname FROM pg_proc WHERE oid = p_oid);
        line_array := string_to_array(f_sql, E'\n');

        i := 1;
        WHILE i <= array_length(line_array, 1) LOOP
            IF line_array[i] ILIKE '%' || p_table || '.%' THEN
                fn_name := p_name;
                matched_line := line_array[i];
                RETURN NEXT;
            END IF;
            i := i + 1;
        END LOOP;
    END LOOP;
END;
$$;


--
