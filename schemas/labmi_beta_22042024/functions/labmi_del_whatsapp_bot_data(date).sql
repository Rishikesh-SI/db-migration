-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_del_whatsapp_bot_data(date)
-- Type: FUNCTION

-- Name: labmi_del_whatsapp_bot_data(date); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_del_whatsapp_bot_data(p_date date, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare

begin
	
	insert into labmi.labmi_whatsapp_bot_quiz_ans_history
	select * from labmi.labmi_whatsapp_bot_quiz_ans
	where (created_date + '5.50 hour'::interval)::date < p_date::date;
	
	delete from labmi.labmi_whatsapp_bot_quiz_ans
 	where (created_date + '5.50 hour'::interval)::date < p_date::date;
	
	p_result = 1;
	
end;
$$;


--
