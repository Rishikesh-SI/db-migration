-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_ins_tigertrack_datatest(jsonb)
-- Type: FUNCTION

-- Name: tmmimg_upd_ins_tigertrack_datatest(jsonb); Type: FUNCTION; Schema: tmmimg_upd; Owner: -
--

CREATE FUNCTION tmmimg_upd.tmmimg_upd_ins_tigertrack_datatest(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
 

  declare
        
		i record;
		v_user_level numeric;
		v_bib_number numeric;
		v_count numeric;
		v_url text;
		v_type text;

  begin
	
			
		
		
		CREATE TEMP TABLE duplicate_msg(msg_id character varying(500));
	  
		for i in select b->>'pubisher' pubisher, b->>'msg_text' msg_text,
					b->>'user_id' user_id, b->>'msg_id' msg_id,b
				 from (select b from jsonb_array_elements(p_json->'data') b)as a 

		loop 
		
		  
		  raise notice 'test % ',p_json;
		  --select 1/0;
			if exists (select 1 from tmmimg_upd.tmmimg_upd_tigertrack_data
					  	where social_user_id = i.user_id) then
						
				select bib_number into v_bib_number 
				from tmmimg_upd.tmmimg_upd_tigertrack_data
				where social_user_id = i.user_id;
				
			else 
				
				select round(random() * 90000 + 10001)   into v_bib_number;
				
    			WHILE exists(select 1 from tmmimg_upd.tmmimg_upd_tigertrack_data
					  	where bib_number= v_bib_number ) LOOP
						
      					select round(random() * 90000 + 10001)  into v_bib_number;
						
    			END LOOP;

			
			end if;
			
			if not exists(select 1 from tmmimg_upd.tmmimg_upd_tigertrack_data
					  	where social_user_id = i.user_id and msg_id=i.msg_id)then
		
					select 
					string_agg(url,',') as url,
					string_agg(mediaType,',') as mediaType
					into v_url,v_type
					from 
					(select 
					jsonb_array_elements((jsonb_array_elements((i.b->>'targetMedia')::jsonb)->>'mediaURLs')::jsonb)->>'url' as url,
					jsonb_array_elements((jsonb_array_elements((i.b->>'targetMedia')::jsonb)->>'mediaURLs')::jsonb)->>'mediaType' as mediaType
					 ) tab;
										
					insert into tmmimg_upd.tmmimg_upd_tigertrack_data (tigertrack_data_id,bib_number,social_user_id ,msg_text,pubisher,msg_id,created_date,user_json,url,media_type)
					values(nextval('tmmimg_upd.seq_tigertrack_data_id'),v_bib_number,i.user_id,i.msg_text,i.pubisher,i.msg_id,
				  	current_timestamp at time zone 'utc',i.b,v_url,v_type);
				
				
					
					If CURRENT_DATE between '2019-11-07' and '2019-11-13' then 
						v_user_level := 1;
					elsif CURRENT_DATE between '2019-11-14' and '2019-11-20' then	
						v_user_level := 2;
					elsif CURRENT_DATE between '2019-11-21' and '2019-11-27' then
						v_user_level := 3;
					elsif CURRENT_DATE between '2019-11-28' and '2019-12-04' then
						v_user_level := 4;
					else 	
						v_user_level := 5;
					end if;	
					
				
					if not exists(select 1 from tmmimg_upd.tmmimg_upd_tigertrack_user_level
					  			  where social_user_id = i.user_id and user_level = v_user_level)  then
						
							select max(user_level) into v_user_level
							from tmmimg_upd.tmmimg_upd_tigertrack_user_level
							where social_user_id = i.user_id ;
						
							v_user_level := coalesce(v_user_level,0)+1;
						
							insert into tmmimg_upd.tmmimg_upd_tigertrack_user_level (tigertrack_user_level_id,social_user_id,user_level,mail_sent,created_date)
							values (nextval('tmmimg_upd.seq_tigertrack_user_level_id'),i.user_id,v_user_level,0,current_date);
						
					end if;
					
				else
					 
					 INSERT INTO duplicate_msg (msg_id) VALUES(i.msg_id);
				
				end if;
			
			end loop ;

		select count(1) into v_count from duplicate_msg;
	
		if v_count > 0  then
	
		p_result := 2;
		
		else
		
		p_result := 1;
		
		end if;
		
	 DROP TABLE duplicate_msg;
	--exception when others then
    --p_result := -1;
      

end;

 
$$;


--
