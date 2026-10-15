-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_get_whatsapp_bot_quiz_r(jsonb)
-- Type: FUNCTION

-- Name: labmi_get_whatsapp_bot_quiz_r(jsonb); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_get_whatsapp_bot_quiz_r(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
/* p_json jsonb := '{
 "data": {
"mobile_no": "5lrGbDuFlMcrtjyoZRwy10kkFLs+tNrkezRA0uPKkSY=",
"language_id" : 5
 }
}';*/

v_mobile_no character varying(100);
-- p_data jsonb;
v_poll_id numeric;
v_current_data timestamp := current_timestamp at time zone 'utc' ;
v_option jsonb;
v_data jsonb;
v_language_id numeric;
v_poll numeric[];

begin

select p_json->'data'->>'mobile_no',
  p_json->'data'->>'language_id'
into v_mobile_no,
v_language_id;

v_language_id := coalesce(v_language_id,5);

	if not exists(select 1 from labmi.labmi_whatsapp_bot_quiz_ans
	where mobile_no = v_mobile_no and (created_date + '5.5 hours'::interval)::date = (v_current_data + '5.5 hours'::interval)::date) then

		select array_agg(aem.asset_id) into v_poll from labmi.labmi_asset_entity_map aem
		left join labmi.labmi_poll p on aem.asset_id = p.poll_id
		where aem.asset_type_id = 6 and aem.entity_role_map_id = v_language_id
		and  p.is_whatsappquiz = 2 and p.is_published = 1  and p.poll_id not in(select poll_id
		from labmi.labmi_whatsapp_bot_quiz_ans
		where mobile_no = v_mobile_no );

		select ('{"data":'||(row_to_json(tab))::text||'}')::jsonb,poll_id into v_data,v_poll_id
		from
		(select poll_desc as question,poll_id from labmi.labmi_poll
		where is_whatsappquiz = 2 and poll_id = any(v_poll) and is_published = 1
		order by random()
		limit 1 ) tab;

		select json_agg(row_to_json(tab)) into v_option from
		(select poll_option_id,option  
		from labmi.labmi_poll_option
		where poll_id = v_poll_id
		order by option_order)tab;

	 --raise notice '%' , v_option;
	   --select 1/0;

		p_data := jsonb_set(v_data, '{data,option}', v_option, true);

	-- raise notice '%',p_data;

	else

	-- raise notice '%',v_mobile_no;
	p_data := '{}';

	end if;

	p_data := p_data;

end;
$$;


--
