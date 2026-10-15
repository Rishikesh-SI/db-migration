-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_get_emailids_mail(numeric)
-- Type: FUNCTION

-- Name: rfg_get_emailids_mail(numeric); Type: FUNCTION; Schema: rfg; Owner: -
--

CREATE FUNCTION rfg.rfg_get_emailids_mail(p_item_number numeric, OUT p_output_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
v_rfg_id_arr numeric[];
begin
	select array(select rfg_id from rfg.rfg_raid_for_gold where is_email_sent = 2
                 order by created_date limit p_item_number) into v_rfg_id_arr;
   	update rfg.rfg_raid_for_gold set is_email_sent = 3 where rfg_id in(select rfg_id from unnest(v_rfg_id_arr)u(rfg_id));
   	select ('{"data":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb into p_output_json
   	from(select * from rfg.rfg_raid_for_gold where is_email_sent = 3)row;
   	p_result := 1;
exception
when others then
   	p_output_json := '{"data":[]}'::jsonb;
   	p_result := -1;
end;

$$;


--
