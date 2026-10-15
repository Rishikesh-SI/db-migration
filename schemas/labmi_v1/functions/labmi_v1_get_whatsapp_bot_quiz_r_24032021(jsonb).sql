-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_get_whatsapp_bot_quiz_r_24032021(jsonb)
-- Type: FUNCTION

-- Name: labmi_v1_get_whatsapp_bot_quiz_r_24032021(jsonb); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_get_whatsapp_bot_quiz_r_24032021(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

	declare
	/* p_json jsonb := '{
	  "data": {
		"mobile_no": "5lrGbDuFlMcrtjyoZRwy10kkFLs+tNrkezRA0uPKkSY="
	  }
	}';*/

	v_mobile_no character varying(100);
	-- p_data jsonb;
	v_poll_id numeric;
	v_current_data timestamp := current_timestamp at time zone 'utc' ; 
	v_option jsonb;
	v_data jsonb;

	begin

		select p_json->'data'->>'mobile_no'
			into v_mobile_no;

		raise notice '%',v_mobile_no;
		
				if not exists(select 1 from labmi_v1.labmi_v1_whatsapp_bot_quiz_ans
							 where mobile_no = v_mobile_no and 
							  (created_date + '5.5 hours'::interval)::date = (v_current_data + '5.5 hours'::interval)::date) then					
					
		
					select ('{"data":'||(row_to_json(tab))::text||'}')::jsonb,poll_id into v_data,v_poll_id
					from
					(select poll_desc as question,poll_id from labmi_v1.labmi_v1_poll
					where is_whatsappquiz = 2
					and poll_id not in(select poll_id from labmi_v1.labmi_v1_whatsapp_bot_quiz_ans
									 where mobile_no = v_mobile_no )
									 order by random()
									 limit 1 ) tab;
									 
	

					select json_agg(row_to_json(tab)) into v_option from
					(select poll_option_id,option  
					 from labmi_v1.labmi_v1_poll_option
					 where poll_id = v_poll_id
					 order by option_order)tab;
					 
					  --raise notice '%' , v_option;
				    --select 1/0;

					p_data	:= 	jsonb_set(v_data, '{data,option}', v_option, true);

					 raise notice '%',p_data;

				else

					-- raise notice '%',v_mobile_no;
					p_data	:= '{}';

				end if;
				
				-- p_data := p_data;

		end;

		$$;


--
