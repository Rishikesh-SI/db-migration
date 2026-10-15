-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: recommend_index_columns()
-- Type: FUNCTION

-- Name: recommend_index_columns(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.recommend_index_columns() RETURNS TABLE(table_name text, function_name text, clause_type text, column_name text, matched_line text)
    LANGUAGE plpgsql
    AS $$
DECLARE
    tbl RECORD;
    p_oid OID;
    f_sql TEXT;
    p_name TEXT;
    line TEXT;
    line_array TEXT[];
    i INT;
    regex_value TEXT;  -- single text value
BEGIN
    -- Step 1: Loop over high sequential scan tables
    FOR tbl IN
        SELECT 
            relname AS table_name
        FROM 
            pg_stat_user_tables
        WHERE 
            relname IN ('labfih_asset_entity_map', 
                        'labfih_entity_role_map',
                        'labfih_entity_master', 
                        'labfih_menu_page_map', 
                        'labfih_image')
        ORDER BY 
            round(100.0 * seq_scan / (seq_scan + idx_scan + 1), 2) DESC
    LOOP
        -- Step 2: Loop over functions that mention the table
        FOR p_oid IN
            SELECT p.oid
            FROM pg_proc p
            JOIN pg_namespace n ON n.oid = p.pronamespace
            WHERE pg_get_functiondef(p.oid) ILIKE '%' || tbl.table_name || '%'
              AND n.nspname NOT IN ('pg_catalog', 'information_schema')
        LOOP
            f_sql := pg_get_functiondef(p_oid);
            p_name := (SELECT proname FROM pg_proc WHERE oid = p_oid);
            line_array := string_to_array(f_sql, E'\n');

            i := 1;
            WHILE i <= array_length(line_array, 1) LOOP
                line := line_array[i];

                IF line ILIKE '%JOIN%' AND line ILIKE '%' || tbl.table_name || '%' THEN
                    -- Correct usage: unnest the array into scalar values
                    FOR regex_value IN
                        SELECT unnest(
                            regexp_matches(
                                line,
                                tbl.table_name || '\.(\w+)',
                                'g'
                            )
                        )
                    LOOP
                        table_name := tbl.table_name;
                        function_name := p_name;
                        clause_type := 'JOIN';
                        column_name := regex_value;
                        matched_line := line;
                        RETURN NEXT;
                    END LOOP;
                ELSIF line ILIKE '%WHERE%' AND line ILIKE '%' || tbl.table_name || '%' THEN
                    FOR regex_value IN
                        SELECT unnest(
                            regexp_matches(
                                line,
                                tbl.table_name || '\.(\w+)',
                                'g'
                            )
                        )
                    LOOP
                        table_name := tbl.table_name;
                        function_name := p_name;
                        clause_type := 'WHERE';
                        column_name := regex_value;
                        matched_line := line;
                        RETURN NEXT;
                    END LOOP;
                END IF;

                i := i + 1;
            END LOOP;
        END LOOP;
    END LOOP;
END;
$$;


--
