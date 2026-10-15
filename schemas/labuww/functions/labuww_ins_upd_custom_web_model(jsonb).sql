-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_ins_upd_custom_web_model(jsonb)
-- Type: FUNCTION

-- Name: labuww_ins_upd_custom_web_model(jsonb); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_ins_upd_custom_web_model(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_custom_id numeric;
v_attempt_count numeric;
v_last_attempt timestamp;
v_first_name character varying;
	v_last_name character varying;
	v_email_id character varying;
	v_email_from character varying;
	v_fan_club_name character varying;
	v_captcha character varying;
v_module_name character varying;
v_mobile_no character varying;
v_user_guid character varying;
v_datajson jsonb;
v_email_body jsonb;
--v_email_from character varying;
v_message text;
v_filepath text := 'email-templates/contactus.html';
v_subject text := 'Contact Us | Incoming request';
v_user_info jsonb;
begin
/*
{
  "data": {
    "module": "luckydraw",
    "user_info": {
      "first_name": "Abu",
      "last_name": "Dan",
      "email_id": "ab@gmail.com",
      "mobile_no": ""
    },
    "captcha": ""
  }
}
*/

 select    p_json->'data'->>'module',
		   p_json->'data'->>'user_guid',
		   p_json->'data'->>'captcha',
		   --p_json -> 'data' -> 'email_body' ,
		    p_json -> 'data' -> 'user_info' ,
		   p_json -> 'data' -> 'user_info' ->> 'first_name',
		   p_json -> 'data' -> 'user_info' ->> 'last_name',
		    p_json->'data'->'user_info'->>'email_id',
			p_json -> 'data' -> 'user_info' ->> 'email_from',
		   p_json -> 'data' -> 'message'
		   
 
		   
         
into 
	v_module_name,
	v_user_guid,
	v_captcha,
	--v_email_body,
	v_user_info,
	v_first_name,
	v_last_name,
	v_email_id,
	v_email_from,
	v_message;
	--v_email_from;

	

if lower(v_module_name) = 'contactus' THEN

    -- Check if the user is spamming within 1 minute
    SELECT count(*), max(created_date)
    INTO v_attempt_count, v_last_attempt
    FROM labuww.labuww_custom_web_json
    WHERE datajson->'data'->'user_info'->>'email_id' = v_email_id
      AND module_name = 'contactus'
      AND created_date > (current_timestamp - INTERVAL '1 minute');

    if v_attempt_count > 0 then
        p_data := '{
            "data": {
                "status": "0",
                "message": "Email attempts are too frequent. Please wait before trying again."
            }
        }';
    else
        -- Check if the user has exceeded 3 attempts within the day
        SELECT count(*), max(created_date)
        INTO v_attempt_count, v_last_attempt
        FROM labuww.labuww_custom_web_json
        WHERE datajson->'data'->'user_info'->>'email_id' = v_email_id
          AND module_name = 'contactus'
          AND created_date > (current_date);

        if v_attempt_count >= 3 then
            -- Check if the last attempt was within the last 5 minutes
            IF current_timestamp - v_last_attempt <= INTERVAL '5 minutes' then
                p_data := '{
                    "data": {
                        "status": "0",
                        "message": "Maximum email attempts reached. Please try again later."
                    }
                }';
            else
                -- Allow attempt if more than 5 minutes have passed since the last attempt
                v_custom_id := nextval('labuww.seq_labuww_custom_id');
                insert into labuww.labuww_custom_web_json
                values (v_custom_id, v_captcha, current_timestamp, current_timestamp, v_user_guid, v_module_name, p_json);
                p_data := '{
                    "data": {
                        "status": "1",
                        "email_body": {}	
                    }
                }';

				p_data := jsonb_set(p_data , '{data , user_info}' , to_jsonb (v_user_info) , true);
			
		 
		   p_data := jsonb_set(p_data , '{data , user_info , first_name}' ,  to_jsonb(coalesce(v_first_name , '')) , true);
		   p_data := jsonb_set(p_data , '{data , user_info , last_name}' ,  to_jsonb(coalesce(v_last_name, '')) , true);
		   p_data := jsonb_set(p_data , '{data , user_info , email_id}' ,  to_jsonb(coalesce(v_email_id , '')) , true);

           --p_data := jsonb_set(p_data , '{data , email_body}' , to_jsonb(v_email_body) , true);
		   p_data := jsonb_set(p_data , '{data, email_body,  filepath}' , to_jsonb(v_filepath ), true);
		   p_data := jsonb_set(p_data , '{data , email_body , subject}' ,  to_jsonb(v_subject) , true);
           p_data := jsonb_set(p_data , '{data , email_body , email_from}' ,  to_jsonb(coalesce(v_email_from , '')) , true);
		    p_data := jsonb_set(p_data , '{data , email_body , email_id}' ,  to_jsonb(coalesce(v_email_id , '')) , true);
		   p_data := jsonb_set(p_data , '{data , email_body , subject}' ,  to_jsonb(v_subject) , true);
		   p_data := jsonb_set(p_data , '{data , email_body , first_name}' ,  to_jsonb(coalesce(v_first_name , '')) , true);
		   p_data := jsonb_set(p_data , '{data , email_body , last_name}' ,  to_jsonb(coalesce(v_last_name, '')) , true);
		   p_data := jsonb_set(p_data , '{data , email_body , message}' ,  to_jsonb(coalesce(v_message , '')) , true);
            end if;
        else
            -- Allow attempt as total attempts are less than 3
            v_custom_id := nextval('labuww.seq_labuww_custom_id');
            insert into labuww.labuww_custom_web_json
            values (v_custom_id, v_captcha, current_timestamp, current_timestamp, v_user_guid, v_module_name, p_json);
            p_data := '{
                "data": {
                    "status": "1",
                    "email_body": {}	
                }
            }';
      

			

		   
		   p_data := jsonb_set(p_data , '{data , user_info}' , to_jsonb (v_user_info) , true);
			
		 
		   p_data := jsonb_set(p_data , '{data , user_info , first_name}' ,  to_jsonb(coalesce(v_first_name , '')) , true);
		   p_data := jsonb_set(p_data , '{data , user_info , last_name}' ,  to_jsonb(coalesce(v_last_name, '')) , true);
		   p_data := jsonb_set(p_data , '{data , user_info , email_id}' ,  to_jsonb(coalesce(v_email_id , '')) , true);

           --p_data := jsonb_set(p_data , '{data , email_body}' , to_jsonb(v_email_body) , true);
		   p_data := jsonb_set(p_data , '{data, email_body,  filepath}' , to_jsonb(v_filepath ), true);
		   p_data := jsonb_set(p_data , '{data , email_body , subject}' ,  to_jsonb(v_subject) , true);
           p_data := jsonb_set(p_data , '{data , email_body , email_from}' ,  to_jsonb(coalesce(v_email_from , '')) , true);
		    p_data := jsonb_set(p_data , '{data , email_body , email_id}' ,  to_jsonb(coalesce(v_email_id , '')) , true);
		   p_data := jsonb_set(p_data , '{data , email_body , subject}' ,  to_jsonb(v_subject) , true);
		   p_data := jsonb_set(p_data , '{data , email_body , first_name}' ,  to_jsonb(coalesce(v_first_name , '')) , true);
		   p_data := jsonb_set(p_data , '{data , email_body , last_name}' ,  to_jsonb(coalesce(v_last_name, '')) , true);
		   p_data := jsonb_set(p_data , '{data , email_body , message}' ,  to_jsonb(coalesce(v_message , '')) , true);
			

		    
			

			

			
        end if;
    end if;
	 
 
	

end if;

end;
$$;


--
