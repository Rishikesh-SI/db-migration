-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_get_users_for_email()
-- Type: FUNCTION

-- Name: tmm_get_users_for_email(); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_get_users_for_email(OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
	declare

		v_user_data jsonb;
		i record;
	begin

 			select '{"data":'||json_agg(row)||'}' into v_user_data
			from(select  f.user_id, f.email_id as email,e.race_category_name,a.bib_no,f.user_full_name as user_name
            	from tmm.tmm_user_transaction a
				left join tmm.tmm_race_category e on a.race_category_id= e.race_category_id
				left join tmm.tmm_web_user f on a.user_guid = f.user_guid and 
				 		  a.race_category_id=f.race_category_id
            	--where a.mail_sent is null and lower(transaction_status)='success'
				limit 2
				)row ;
				
				for i in select b->>'user_id' user_id ,b->>'email' email
			from (select b from jsonb_array_elements(v_user_data->'data') b)as a 

			loop 
				  
				  update tmm.tmm_user_transaction
				  set mail_sent=1
				  where user_id = i.user_id::numeric ;

			end loop ;
	  
	  
	p_user_data := v_user_data;
	
	/*exception when others then 
		p_user_data:='{}';*/
	end ; 

	$$;


--
