-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: confirm_drop()
-- Type: FUNCTION

-- Name: confirm_drop(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.confirm_drop() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
obj record;
BEGIN
 FOR obj in SELECT * from pg_event_trigger_dropped_objects()
 LOOP
 IF  obj.schema_name is not null and obj.schema_name <> 'pg_temp' THEN
RAISE EXCEPTION 'command % is disabled for this database', tg_tag;
 END IF;
 END LOOP;
END;
$$;


--
