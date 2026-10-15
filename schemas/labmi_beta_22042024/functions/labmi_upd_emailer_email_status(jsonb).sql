-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_upd_emailer_email_status(jsonb)
-- Type: FUNCTION

-- Name: labmi_upd_emailer_email_status(jsonb); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_upd_emailer_email_status(p_emails jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
	v_emails_json jsonb;
	v_emailid_arr text[];
	
begin
	
	select p_emails->'data'
	into v_emails_json;
	
	select array(select row->>'user_guid'
				 from (select jsonb_array_elements(v_emails_json) as row) tab
				 where row->>'is_mail_sent' = '1')
	into v_emailid_arr;
	
	update labmi.labmi_web_user
	set survey_emails_status = 1,
		mail_sent_date = current_timestamp at time zone 'utc'
	where user_guid =any(v_emailid_arr) and client_id =5 and is_verified=1;
	
	p_result := 1;
	
exception
	when others then
		p_result := -1;
end;
$$;


--
