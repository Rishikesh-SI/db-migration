-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_get_client_json(character varying, character varying, character varying)
-- Type: FUNCTION

-- Name: waf_get_client_json(character varying, character varying, character varying); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_get_client_json(p_prefix character varying, p_client_code character varying, p_url character varying, OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
begin
select client_json into p_json from waf_master.waf_client 
where lower(client_prefix)=lower(p_prefix) or lower(client_code)=lower(p_client_code) or lower(domain_url) like '%'||lower(p_url)||'%';
end ;

$$;


--
