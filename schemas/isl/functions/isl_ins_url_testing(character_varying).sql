-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_ins_url_testing(character varying)
-- Type: FUNCTION

-- Name: isl_ins_url_testing(character varying); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_ins_url_testing(p_url character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$     

declare
	v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
     v_uid numeric;
begin
	v_uid := nextval('isl.seq_isl_u_id');
	insert into isl.isl_url_testing
     values(v_uid, p_url, v_currenttimestamp);
     p_result := 1;
exception
	when others then
     	p_result := -1;
end;

     $$;


--
