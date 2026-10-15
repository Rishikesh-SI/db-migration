-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_ins_whatsapp_bot_user(jsonb)
-- Type: FUNCTION

-- Name: labmi_ins_whatsapp_bot_user(jsonb); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_ins_whatsapp_bot_user(p_user_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

	declare
	 /*p_user_json jsonb := '{
							  "data": {
								"email_id": "tHj+0hHAHM+YXibv02qJbxy4efAq9H+CB3/gUPQZBSjYtIPSa7pXsDL0Qq/YKmZC",
								"mobile_no": "5lrGbDuFlMcrtjyoZRwy10kkFLs+tNrkezRA0uPKkSY=",
								"gender": "",
								"dob" : "",
								"favorite_player" : ""
							  }
							}';*/
	v_email_id character varying(1000);
	v_mobile_no character varying(1000);
	v_gender character varying(1000);	
	v_dob character varying(1000);	
	v_whatsapp_bot_user_id numeric ;
	v_favorite_player text;
	
	begin
	
		select p_user_json->'data'->>'email_id',
			   p_user_json->'data'->>'mobile_no',
			   p_user_json->'data'->>'gender',
			   p_user_json->'data'->>'dob',
			   p_user_json->'data'->>'favorite_player'
		 into  v_email_id,
			   v_mobile_no,
			   v_gender,
			   v_dob,
			   v_favorite_player;
			   
		v_mobile_no := case v_mobile_no when '' then null else v_mobile_no end;
		
		if v_mobile_no is not null then
			   
		if exists (select 1 from labmi.labmi_web_user
				   where mobile_no = v_mobile_no and is_verified = 1) then
				   
			if not exists(select 1 from labmi.labmi_whatsapp_bot_user
						 where mobile_no = v_mobile_no)	then	
			
					v_whatsapp_bot_user_id := nextval('labmi.seq_labmi_whatsapp_bot_user_id');
					
					raise notice '% 2',v_whatsapp_bot_user_id;

					insert into labmi.labmi_whatsapp_bot_user (whatsapp_bot_user_id,mobile_no,email_id,
																  dob,gender,created_date,favorite_player)
					select 	v_whatsapp_bot_user_id,v_mobile_no,email_id,dob,gender,current_timestamp at time zone 'utc',
							v_favorite_player
					from 	labmi.labmi_web_user
					where mobile_no = v_mobile_no and is_verified = 1 and client_id = 5;

					p_result := 1;
					
			else

				p_result := 0;

			end if;	
				
		else
			   
			   
			if not exists(select 1 from labmi.labmi_whatsapp_bot_user
						 where mobile_no = v_mobile_no)	then

				v_whatsapp_bot_user_id := nextval('labmi.seq_labmi_whatsapp_bot_user_id');	
				
				raise notice '% 1',v_whatsapp_bot_user_id;

				insert into labmi.labmi_whatsapp_bot_user (whatsapp_bot_user_id,mobile_no,email_id,
														  dob,gender,created_date,favorite_player)
				values (v_whatsapp_bot_user_id,v_mobile_no,v_email_id,v_dob,v_gender,
						current_timestamp at time zone 'utc',v_favorite_player);

				p_result := 1;

			else

				p_result := 0;

			end if;
			
		end if;	
		
		else
		     
			 p_result := 2;
		 
		end if;
	
	end;

	
	$$;


--
