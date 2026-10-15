-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_ins_url_testing(character varying)
-- Type: FUNCTION

-- Name: spz_ins_url_testing(character varying); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_ins_url_testing(p_url character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 
declare
	v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
     v_uid numeric;
begin
	v_uid := nextval('spz.seq_spz_u_id');
	insert into spz.spz_url_testing
     values(v_uid, p_url, v_currenttimestamp);
     p_result := 1;
exception
	when others then
     	p_result := -1;
end;
 $$;


--
