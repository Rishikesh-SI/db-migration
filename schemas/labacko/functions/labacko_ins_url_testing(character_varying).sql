-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_ins_url_testing(character varying)
-- Type: FUNCTION

-- Name: labacko_ins_url_testing(character varying); Type: FUNCTION; Schema: labacko; Owner: -
--

CREATE FUNCTION labacko.labacko_ins_url_testing(p_url character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 
declare
	v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
     v_uid numeric;
begin
	v_uid := nextval('labacko.seq_labacko_u_id');
	insert into labacko.labacko_url_testing
     values(v_uid, p_url, v_currenttimestamp);
     p_result := 1;
exception
	when others then
     	p_result := -1;
end;
 $$;


--
