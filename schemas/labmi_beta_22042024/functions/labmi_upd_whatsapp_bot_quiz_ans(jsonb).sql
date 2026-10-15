-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_upd_whatsapp_bot_quiz_ans(jsonb)
-- Type: FUNCTION

-- Name: labmi_upd_whatsapp_bot_quiz_ans(jsonb); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_upd_whatsapp_bot_quiz_ans(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare

/*p_json jsonb := '{
 "data": {
"mobile_no": "5lrGbDuFlMcrtjyoZRwy10kkFLs+tNrkezRA0uPKkSY=",
"poll_id": 401,
"poll_option_id": 403
 }
}';*/

v_mobile_no character varying(100);
-- p_data jsonb;
v_poll_id numeric;
v_current_data timestamp := current_timestamp at time zone 'utc' ;
v_poll_option_id numeric;
v_data jsonb;
v_sum numeric;
v_is_ans numeric;

begin

select p_json->'data'->>'mobile_no',
  p_json->'data'->>'poll_id',
  p_json->'data'->>'poll_option_id'
into v_mobile_no,
v_poll_id,
v_poll_option_id;

	if not exists(select 1 from labmi.labmi_whatsapp_bot_quiz_ans
  			where mobile_no = v_mobile_no 
		   and (created_date + '5.5 hours'::interval)::date = (v_current_data + '5.5 hours'::interval)::date) then

			insert into labmi.labmi_whatsapp_bot_quiz_ans(mobile_no,poll_id,answer,created_date)
			values (v_mobile_no,v_poll_id,v_poll_option_id,v_current_data);

			select coalesce(sum(p.quiz_points),0) into v_sum from labmi.labmi_poll p
			left join labmi.labmi_whatsapp_bot_quiz_ans wb on p.poll_id = wb.poll_id
			left join labmi.labmi_poll_option po on wb.answer = po.poll_option_id
			where wb.mobile_no = v_mobile_no and po.is_ans =1;

			select is_ans into v_is_ans  from labmi.labmi_poll_option
			where poll_id = v_poll_id and  poll_option_id = v_poll_option_id;
			
		--	v_sum := 0;
 
			v_data := '{
			"score" : '||v_sum::text||',
			"is_ans" : '||v_is_ans::text||'
			}';

			p_data := v_data;

	else

			select coalesce(sum(p.quiz_points),0) into v_sum from labmi.labmi_poll p
			left join labmi.labmi_whatsapp_bot_quiz_ans wb on p.poll_id = wb.poll_id
			left join labmi.labmi_poll_option po on wb.answer = po.poll_option_id
			where wb.mobile_no = v_mobile_no and po.is_ans =1;

			v_data := '{
			"score" : '||v_sum::text||'
			}';
			p_data := v_data;

	end if;

end;

$$;


--
