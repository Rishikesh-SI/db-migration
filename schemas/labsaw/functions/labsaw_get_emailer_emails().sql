-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_get_emailer_emails()
-- Type: FUNCTION

-- Name: labsaw_get_emailer_emails(); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_get_emailer_emails(OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	
	v_emailid_arr text[];
	v_totalsentemail numeric;
	
begin
	
	select array(select email_id
				 from labsaw.labsaw_emailer_emails
				 where status = 0
				 /*and 
				 email_id in (
'kLujX5oMeVhCbp86pRp7TY/Be3ALsZOO+fS20xeK7xClAHNV5aOLoZTobAG06GPN6zY8UBZ/JurS+b40w3U5Vg==',
'/5BWrk4CoDtmMKpAly/t6kCAb+C727/x9mF7BvBb2aJXhoYBk6/CSLZDKBjkKt03Rn4G2Npp+vJJbiqZa91Nmg==',
'IVQyTSFejJlInvuq0wJ9mOsIuxMFEMMGSYv02f57b8pxXgzVRbQB2RFR1LqpT3Lvi0/bFu6oIzhiTMV6utqc5A==',
'PmlO+XkIRNCLMgty8BYS/MnD33bxOnb2Wxnj/RpK/qIYqAbtqPqsOW9eGj6weVqInRv/bB73GVcVjCbdoTVapQ==',
'MnmW9tptudeeGaDVy6UcfPVQgt4LWw3Ko8QN/iywjG8JNHo7yshCnmhM1pM9Az30qeHS+MDJWzRxjzfkMcR8bg=='
)*/
				 limit 250)
	into v_emailid_arr;
	
	 update labsaw.labsaw_emailer_emails
	 set status = -1
	 where email_id =any(v_emailid_arr);
	 
	/* select count(1) from labsaw.labsaw_emailer_emails 
	 where status=1 
	 into v_totalsentemail;*/
	
	select ('{"totalsentemail":500000,"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
	from (select null as user_id, email_id, user_full_name, guid,0 as is_mail_sent
		  ,first_name,last_name
		  from labsaw.labsaw_emailer_emails
		  where email_id =any(v_emailid_arr)
		 )row
	into p_user_data;
	
end;
$$;


--
