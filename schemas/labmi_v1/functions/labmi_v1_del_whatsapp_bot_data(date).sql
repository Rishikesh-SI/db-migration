-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_del_whatsapp_bot_data(date)
-- Type: FUNCTION

-- Name: labmi_v1_del_whatsapp_bot_data(date); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_del_whatsapp_bot_data(p_date date, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare

begin
	
	insert into labmi_v1.labmi_v1_whatsapp_bot_quiz_ans_history
	select * from labmi_v1.labmi_v1_whatsapp_bot_quiz_ans
	where (created_date + '5.50 hour'::interval)::date < p_date::date;
	
	delete from labmi_v1.labmi_v1_whatsapp_bot_quiz_ans
 	where (created_date + '5.50 hour'::interval)::date < p_date::date;
	
	p_result = 1;
	
end;
$$;


--
