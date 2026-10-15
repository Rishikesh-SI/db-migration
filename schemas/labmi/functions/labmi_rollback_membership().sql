-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_rollback_membership()
-- Type: FUNCTION

-- Name: labmi_rollback_membership(); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_rollback_membership(OUT p_tran_status numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_date text:= TO_CHAR(current_timestamp::date,'DDMMYYYY');

begin

execute 'GRANT USAGE ON SCHEMA labmi to wafwebagent;
GRANT SELECT,INSERT,UPDATE,DELETE  ON ALL TABLES IN SCHEMA labmi TO wafwebagent;
GRANT EXECUTE  ON ALL FUNCTIONS IN SCHEMA labmi TO wafwebagent;
GRANT SELECT,UPDATE ON ALL SEQUENCES IN SCHEMA labmi TO wafwebagent;
GRANT SELECT,INSERT,UPDATE,DELETE  ON ALL TABLES IN SCHEMA labmi TO waf_agent;
GRANT EXECUTE  ON ALL FUNCTIONS IN SCHEMA labmi TO waf_agent;
GRANT SELECT,UPDATE ON ALL SEQUENCES IN SCHEMA labmi TO waf_agent;
GRANT SELECT ON ALL TABLES IN SCHEMA labmi TO waf_agent;
GRANT USAGE ON SCHEMA labmi TO waf_agent;';

p_tran_status:=1;




end;

$$;


--
