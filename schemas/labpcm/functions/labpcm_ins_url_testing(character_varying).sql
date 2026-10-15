-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_ins_url_testing(character varying)
-- Type: FUNCTION

-- Name: labpcm_ins_url_testing(character varying); Type: FUNCTION; Schema: labpcm; Owner: -
--

CREATE FUNCTION labpcm.labpcm_ins_url_testing(p_url character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 
declare
	v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
     v_uid numeric;
begin
	v_uid := nextval('labpcm.seq_labpcm_u_id');
	insert into labpcm.labpcm_url_testing
     values(v_uid, p_url, v_currenttimestamp);
     p_result := 1;
exception
	when others then
     	p_result := -1;
end;
 $$;


--
