-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_sunday_contest_winner(numeric, numeric)
-- Type: FUNCTION

-- Name: isl_get_sunday_contest_winner(numeric, numeric); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_sunday_contest_winner(p_poll_id numeric, p_entity_id numeric, OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

	declare

	begin
		
		
		if not exists(select 1 from isl.isl_sunday_contest_winner
			 		  where poll_id = p_poll_id ) then

			insert into isl.isl_sunday_contest_winner  
			select a.* from (select nextval('isl.seq_isl_sunday_contest_winner_id'),poll_id,module_name,firstname,dob,lastname,pincode,phone,email,userFrom,country,contestSource,
						 	 b->>'question' question ,b->>'answer' answer,(b->>'poll_option_id')::numeric poll_option_id,0
						 	from(	select module_name,custom_module_id,client_mod_json->'data'->'user'->>'firstname' firstname,
						  	  		to_date(client_mod_json->'data'->'user'->>'dob','DD-MM-YYYY') dob,
						  			client_mod_json->'data'->'user'->>'lastname' lastname ,
						  			client_mod_json->'data'->'user'->>'pincode' pincode,
						 			client_mod_json->'data'->'user'->>'phone' phone,
						  			client_mod_json->'data'->'user'->>'email' email,
						  			client_mod_json->'data'->'user'->>'country' country,
						  			client_mod_json->'data'->'user'->>'userFrom' userFrom,
						  			client_mod_json->'data'->'user'->>'contestSource' contestSource,
						  			(client_mod_json->>'poll_id')::numeric poll_id,
						  			jsonb_array_elements(client_mod_json->'data'->'poll') b 
						  			from isl.isl_client_web_cust_model
						  			where (client_mod_json->>'poll_id')::numeric  = p_poll_id )tab)a
			join isl.isl_poll_option c on a.poll_option_id = c.poll_option_id and a.poll_id =c.poll_id
			join isl.isl_poll d on a.poll_id =d.poll_id
			where c.is_ans=1 and lower(a.country) ='india' 
			and (d.poll_desc::json->>'end_date')::timestamp < current_timestamp + '5.5 hours'::interval
			and d.poll_id = p_poll_id
			order by random()
			limit 101;
			
			update isl.isl_sunday_contest_winner
			set bike_winner = 1
			where sunday_contest_winner_id = ( select sunday_contest_winner_id from isl.isl_sunday_contest_winner
										   		where EXTRACT(year FROM age(current_date,dob))>= 18 and poll_id = p_poll_id
										  		order by random()
												limit 1);
		
	end if;
			
		select '{"data":'||json_agg(row)||'}' into p_user_data
		from (select * from isl.isl_sunday_contest_winner
			  where poll_id = p_poll_id and bike_winner = 0 )row;

	end;

	$$;


--
