-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_upd_email_sent_status_mail(jsonb)
-- Type: FUNCTION

-- Name: rfg_upd_email_sent_status_mail(jsonb); Type: FUNCTION; Schema: rfg; Owner: -
--

CREATE FUNCTION rfg.rfg_upd_email_sent_status_mail(p_input_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_rfg_id_arr numeric[];
begin
update rfg.rfg_raid_for_gold set is_email_sent = -1 where is_email_sent = 3;
   select array(select json_array_elements(a->'data')::text::numeric from(select p_input_json::json a)b) into v_rfg_id_arr;
   update rfg.rfg_raid_for_gold set is_email_sent = 4 where rfg_id in(select rfg_id from unnest(v_rfg_id_arr)u(rfg_id));
   p_result := 1;
exception
when others then
   	p_result := -1;
end;

$$;


--
