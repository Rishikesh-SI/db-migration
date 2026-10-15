-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_get_total_count()
-- Type: FUNCTION

-- Name: rfg_get_total_count(); Type: FUNCTION; Schema: rfg; Owner: -
--

CREATE FUNCTION rfg.rfg_get_total_count(OUT p_total_count numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
begin
	select count(1) into p_total_count from rfg.rfg_raid_for_gold;
end;
$$;


--
