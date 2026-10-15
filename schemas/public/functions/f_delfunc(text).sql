-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: f_delfunc(text)
-- Type: FUNCTION

-- Name: f_delfunc(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.f_delfunc(_sch text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
   _sql text;
BEGIN
   SELECT INTO _sql
          string_agg(format('DROP FUNCTION %s(%s);'
                          , p.oid::regproc
                          , pg_get_function_identity_arguments(p.oid))
                   , E'\n')
   FROM   pg_proc      p
   JOIN   pg_namespace ns ON ns.oid = p.pronamespace
   WHERE  ns.nspname = _sch;

   IF _sql IS NOT NULL THEN
      --  RAISE NOTICE '%', _sql;  -- for debugging
      EXECUTE _sql;
   END IF;
END
$$;


--
