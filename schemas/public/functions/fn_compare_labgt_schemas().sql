-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: fn_compare_labgt_schemas()
-- Type: FUNCTION

-- Name: fn_compare_labgt_schemas(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.fn_compare_labgt_schemas() RETURNS TABLE(table_name text, old_count bigint, new_count bigint)
    LANGUAGE plpgsql
    AS $$
DECLARE
    rec record;
    sql_old text;
    sql_new text;
BEGIN
    -- Get all base table names from labgt schema
    FOR rec IN 
        SELECT replace(table_name, 'labgt_', '') AS base_name
        FROM information_schema.tables
        WHERE table_schema = 'labgt'
          AND table_type = 'BASE TABLE'
    LOOP
        -- Dynamic SQL for old schema
        sql_old := format('SELECT count(*) FROM labgt.labgt_%I', rec.base_name);
        EXECUTE sql_old INTO old_count;

        -- Dynamic SQL for new schema
        sql_new := format('SELECT count(*) FROM labgt01_v1.labgt01_v1_%I', rec.base_name);
        EXECUTE sql_new INTO new_count;

        -- Return only mismatches
        IF old_count <> new_count THEN
            table_name := rec.base_name;
            RETURN NEXT;
        END IF;
    END LOOP;
END;
$$;


--
