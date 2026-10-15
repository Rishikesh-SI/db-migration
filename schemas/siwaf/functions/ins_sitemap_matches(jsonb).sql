-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_sitemap_matches(jsonb)
-- Type: FUNCTION

-- Name: _ins_sitemap_matches(jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_sitemap_matches(p_data jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
	declare

		i record;
		v_created_date timestamp ;
		v_sitemap_url text;
		v_sitemap_match_id numeric;
	begin
		for i in 
			select b->>'url' as url,
				   b->>'gameid' as gameid,
				   b->>'clientcode' as clientcode,
				   b->>'enddate' as enddate from (select b from jsonb_array_elements(p_data->'data') b)as a 

		loop
		
	   		/*if not exists (select 1 from siwaf.siwaf_sitemap_matches
						   where trim(match_id) = trim(i.gameid) and 
						   trim(client_code) = trim(i.clientcode) and trim(sitemap_url) = trim(i.url))then
	 
	      		v_sitemap_match_id := nextval('siwaf.seq_sitemap_match_id');
		  		v_created_date := current_timestamp at time zone 'utc'; 
		   		insert into siwaf.siwaf_sitemap_matches (sitemap_match_id,client_code,match_id,match_end_date,sitemap_url,created_date )
		   		values(v_sitemap_match_id,i.clientcode,i.gameid,i.enddate::timestamp,i.url,v_created_date);
	
	   		end if;*/
			
			begin
	  			 select sitemap_url into strict v_sitemap_url 
				 from siwaf.siwaf_sitemap_matches
	  			 where trim(match_id) = trim(i.gameid)
				 and trim(client_code) = trim(i.clientcode)
				 and trim(sitemap_url) = trim(i.url);
	   
				 -- raise notice '%',v_sitemap_url;
	   			exception when no_data_found then
				
	 		 
	      		v_sitemap_match_id := nextval('siwaf.seq_sitemap_match_id');
		  		v_created_date := current_timestamp at time zone 'utc'; 
		   		insert into siwaf.siwaf_sitemap_matches (sitemap_match_id,client_code,match_id,match_end_date,sitemap_url,created_date,p_data )
		   		values(v_sitemap_match_id,i.clientcode,i.gameid,i.enddate::timestamp,i.url,v_created_date,p_data);
				
	   		end;
			
	
		end loop;
		
		 p_result := 1;
		
		exception when others then
		 p_result:= null;	
    
	end ;
	$$;


--
