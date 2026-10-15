-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_get_users_for_email_verifcation()
-- Type: FUNCTION

-- Name: labmi_v1_get_users_for_email_verifcation(); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_get_users_for_email_verifcation(OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

	declare
	
		v_user_data jsonb;
		i record;

	begin
		/*select '{ "data": '||json_agg(tab)||'}' into v_user_data from(
		select user_full_name,email_id,verification_key,user_id from labmi_v1.labmi_v1_web_user
		where is_verified=0 and client_id =5
		and created_date between'2020-05-11 18:30:00' and '2020-05-11 21:30:00'
         and is_mail_sent is null
        limit 30)tab;*/
        
        select '{ "data": '||json_agg(tab)||'}' into v_user_data from(
		select user_full_name,email_id,verification_key,user_id from labmi_v1.labmi_v1_web_user
		where  is_mail_sent =0 and client_id =5
        limit 30)tab;
		
		for i in select b->>'user_id' user_id 
			from (select b from jsonb_array_elements(v_user_data->'data') b)as a 

			loop 
				  -- raise notice '%',i.user_id::numeric;
				  update labmi_v1.labmi_v1_web_user
				  set is_mail_sent = 1
				  where user_id = i.user_id::numeric;

			end loop ;
			
			p_user_data := v_user_data;
				
	end ; 	

	

$$;


--
