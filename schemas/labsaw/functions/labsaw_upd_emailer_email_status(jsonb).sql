-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_upd_emailer_email_status(jsonb)
-- Type: FUNCTION

-- Name: labsaw_upd_emailer_email_status(jsonb); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_upd_emailer_email_status(p_emails jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
	v_emails_json jsonb;
	v_emailid_arr text[];
	
begin
	
	select p_emails->'data'
	into v_emails_json;
	
	select array(select row->>'guid'
				 from (select jsonb_array_elements(v_emails_json) as row) tab
				 where row->>'is_mail_sent' = '1')
	into v_emailid_arr;
	
	update labsaw.labsaw_emailer_emails
	set status = 1,
		updated_date = current_timestamp at time zone 'utc'
	where guid =any(v_emailid_arr);
	
	select array(select row->>'guid'
				 from (select jsonb_array_elements(v_emails_json) as row) tab
				 where row->>'is_mail_sent' = '-5')
	into v_emailid_arr;
	
	update labsaw.labsaw_emailer_emails
	set status = -5,
		updated_date = current_timestamp at time zone 'utc'
	where guid =any(v_emailid_arr);
	
	p_result := 1;
	
/*exception
	when others then
		p_result := -1;*/
end;
$$;


--
