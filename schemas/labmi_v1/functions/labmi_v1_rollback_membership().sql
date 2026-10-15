-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_rollback_membership()
-- Type: FUNCTION

-- Name: labmi_v1_rollback_membership(); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_rollback_membership(OUT p_tran_status numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_date text:= TO_CHAR(current_timestamp::date,'DDMMYYYY');

begin

execute 'GRANT USAGE ON SCHEMA labmi_v1 to wafwebagent;
GRANT SELECT,INSERT,UPDATE,DELETE  ON ALL TABLES IN SCHEMA labmi_v1 TO wafwebagent;
GRANT EXECUTE  ON ALL FUNCTIONS IN SCHEMA labmi_v1 TO wafwebagent;
GRANT SELECT,UPDATE ON ALL SEQUENCES IN SCHEMA labmi_v1 TO wafwebagent;
GRANT SELECT,INSERT,UPDATE,DELETE  ON ALL TABLES IN SCHEMA labmi_v1 TO waf_agent;
GRANT EXECUTE  ON ALL FUNCTIONS IN SCHEMA labmi_v1 TO waf_agent;
GRANT SELECT,UPDATE ON ALL SEQUENCES IN SCHEMA labmi_v1 TO waf_agent;
GRANT SELECT ON ALL TABLES IN SCHEMA labmi_v1 TO waf_agent;
GRANT USAGE ON SCHEMA labmi_v1 TO waf_agent;';

p_tran_status:=1;




end;

$$;


--
