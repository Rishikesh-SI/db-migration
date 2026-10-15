-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_get_emailer_emails()
-- Type: FUNCTION

-- Name: labmi_v1_get_emailer_emails(); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_get_emailer_emails(OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
	v_emailid_arr text[];
	v_count numeric;
	
begin

   select count(1) into v_count from labmi_v1.labmi_v1_web_user
   where survey_emails_status = 1 and client_id = 5 and is_verified=1
   		and mail_sent_date::date = (current_timestamp at time zone 'utc')::date;
   
   -- raise notice '%',v_count;

   
   if (v_count < 1650 or v_count is null) and (current_time between '09:00:00' and '21:00:00') then 
	
				select array(select email_id
							 from labmi_v1.labmi_v1_web_user
							 where survey_emails_status = 0 and client_id = 5 and is_verified=1
							 -- and user_id in (141,69945,203)
							 limit 10)
				into v_emailid_arr;

				/*update labmi_v1.labmi_v1_web_user
				set survey_emails_status = 1
				where email_id =any(v_emailid_arr) and client_id = 5 and is_verified=1;*/

				select ('{"data":'||(json_agg(row_to_json(row)))::text||'}')::jsonb
				from (select  email_id, user_full_name,user_guid,trans_guid
					  from labmi_v1.labmi_v1_web_user
					  where email_id =any(v_emailid_arr) and client_id = 5 and is_verified=1
					 )row
				into p_user_data;
	
	end if;
	
end;

$$;


--
