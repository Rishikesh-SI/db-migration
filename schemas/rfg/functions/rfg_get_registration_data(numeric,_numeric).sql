-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_get_registration_data(numeric, numeric)
-- Type: FUNCTION

-- Name: rfg_get_registration_data(numeric, numeric); Type: FUNCTION; Schema: rfg; Owner: -
--

CREATE FUNCTION rfg.rfg_get_registration_data(p_pagenumber numeric, p_itemnumber numeric, OUT p_count numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	v_fromrownumber numeric;
    v_torownumber numeric;
begin
	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    v_torownumber := (p_pagenumber * p_itemnumber);
    select count(1) into p_count from rfg.rfg_raid_for_gold;
    select ('{"data":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb into p_json
    from (select *,row_number() over(order by created_date desc) slno
          from rfg.rfg_raid_for_gold)row
	where slno between v_fromrownumber and v_torownumber;
    if p_count = 0 then
    	p_json := ('{"data":[]}')::jsonb;
    end if;
end;
$$;


--
