-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_upd_company_user(numeric, jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_upd_company_user(numeric, jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_upd_company_user(p_company_id numeric, p_user_json jsonb, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 
begin

update labbsc_dev.labbsc_dev_entity_master
set entity_json=p_user_json
where entity_master_id=p_company_id;
p_out:=1;


end;
$$;


--
