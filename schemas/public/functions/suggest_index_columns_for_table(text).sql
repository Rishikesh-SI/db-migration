-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: suggest_index_columns_for_table(text)
-- Type: FUNCTION

-- Name: suggest_index_columns_for_table(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.suggest_index_columns_for_table(p_table_name text) RETURNS TABLE(function_name text, column_name text, usage_count integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
    func_oid OID;
    func_def TEXT;
    func_name TEXT;
    regex TEXT := E'(JOIN|WHERE)[^;\\n]*?' || p_table_name || '\\.(\\w+)';
    matches RECORD;
    column_map JSONB := '{}';
BEGIN
    FOR func_oid IN
        SELECT p.oid
        FROM pg_proc p
        JOIN pg_namespace n ON n.oid = p.pronamespace
        WHERE pg_get_functiondef(p.oid) ILIKE '%' || p_table_name || '%'
          AND n.nspname NOT IN ('pg_catalog', 'information_schema')
    LOOP
        func_def := pg_get_functiondef(func_oid);
        func_name := (SELECT proname FROM pg_proc WHERE oid = func_oid);

        -- Extract column matches from WHERE and JOIN
        FOR matches IN
            WITH extracted AS (
                SELECT regexp_matches(func_def, regex, 'gi') AS m
            )
            SELECT (m)[2] AS col_name FROM extracted
        LOOP
            IF column_map ? matches.col_name THEN
                column_map := jsonb_set(
                    column_map,
                    ARRAY[matches.col_name],
                    to_jsonb((column_map ->> matches.col_name)::INT + 1)
                );
            ELSE
                column_map := jsonb_set(column_map, ARRAY[matches.col_name], '1');
            END IF;
        END LOOP;

        -- Emit result using OUT parameter assignments
        IF jsonb_typeof(column_map) = 'object' THEN
            FOR matches IN SELECT jsonb_object_keys(column_map) AS col_name
            LOOP
                function_name := func_name;
                column_name := matches.col_name;
                usage_count := (column_map ->> matches.col_name)::INT;
                RETURN NEXT;
            END LOOP;
        END IF;

        column_map := '{}';
    END LOOP;
END;
$$;


--
