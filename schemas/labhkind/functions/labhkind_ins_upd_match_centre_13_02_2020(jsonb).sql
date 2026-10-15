-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_ins_upd_match_centre_13_02_2020(jsonb)
-- Type: FUNCTION

-- Name: labhkind_ins_upd_match_centre_13_02_2020(jsonb); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_ins_upd_match_centre_13_02_2020(p_match_json jsonb, OUT p_result numeric, OUT p_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_current_timestamp timestamp without time zone := current_timestamp at time zone 'utc';
    v_json jsonb := p_match_json;
    v_match_centre_id numeric;
    v_sport_id numeric;
    v_series_id numeric;
    v_match_source_object_id character varying(100);
    v_match_id numeric;
    v_match_title character varying(500);
    v_match_ticket_url character varying(500);
    v_league_ticket_url character varying(500);
    v_live_stream_embed_code_source character varying(100);
    v_live_stream_embed_code character varying(500);
    v_live_stream_url_source character varying(100);
    v_live_stream_url character varying(500);
    v_match_hashtag character varying(100);
    v_social_info character varying(500);
    v_match_day_battle jsonb;
    v_media_json jsonb;
    v_match_guid character varying(256);
    v_media_result numeric;
    v_media json;
    v_media_type character varying(10);
    v_media_caption character varying(100);
    v_media_desc character varying(500);
    v_media_path character varying(100);
    v_media_copyright_text character varying(100);
    v_media_file_name character varying(100);
    v_media_order_number numeric;
    v_media_title_alias character varying(100);
    v_media_unique_id character varying(15);
    v_media_is_desktop numeric;
    v_media_id numeric;
    v_media_guid character varying(256);
    v_counter numeric := 0;
    v_set_data character varying[];
	v_year text;
    
begin
	
    select v_json->'data'->>'match_centre_id',
    		v_json->'data'->>'sport_id',
            v_json->'data'->>'series_id',
    		v_json->'data'->>'match_source_object_id',
            v_json->'data'->>'match_title',
            v_json->'data'->>'match_ticket_url',
            v_json->'data'->>'league_ticket_url',
            v_json->'data'->>'live_stream_embed_code_source',
            v_json->'data'->>'live_stream_embed_code',
            v_json->'data'->>'live_stream_url_source',
            v_json->'data'->>'live_stream_url',
            v_json->'data'->>'match_hashtag',
            v_json->'data'->>'social_info',
            v_json->'data'->>'match_day_battle',
            v_json->'data'->>'media',
			v_json->'data'->>'year'
    into v_match_centre_id,
    		v_sport_id,
            v_series_id,
    		v_match_source_object_id,
            v_match_title,
            v_match_ticket_url,
            v_league_ticket_url,
            v_live_stream_embed_code_source,
            v_live_stream_embed_code,
            v_live_stream_url_source,
            v_live_stream_url,
            v_match_hashtag,
            v_social_info,
            v_match_day_battle,
            v_media_json,
			v_year;
    
	
    select entity_role_map_id
    into  v_match_id
    from   labhkind.labhkind_entity_role_map
    where  source_object_id = v_match_source_object_id
    and    entity_role_id = 6;
	
   v_match_id:= 0;
	
    v_json := jsonb_set(v_json, '{data,match_id}', v_match_id::text::jsonb, true);
   
    if v_match_centre_id is null then
	-- select 1/0;
    	 if not exists (select series_id from labhkind.labhkind_match_centre 
			   where is_active=1 and is_deleted=0 and series_id=v_series_id ) then 
		
        v_match_centre_id := nextval('labhkind.seq_labhkind_match_centre_id');
        v_match_guid := uuid_generate_v4();
        
        insert into labhkind.labhkind_match_centre(match_centre_id, sport_id, series_id, match_id, match_source_object_id, match_title, match_ticket_url, 
                                         league_ticket_url, live_stream_embed_code_source, live_stream_embed_code, live_stream_url_source, 
                                         live_stream_url, match_hashtag, social_info, match_day_battle, match_centre_guid, is_active, is_deleted, 
                                         created_by, updated_by, created_date, updated_date,year)
        select v_match_centre_id, v_sport_id, v_series_id, v_match_id, v_match_source_object_id, v_match_title, v_match_ticket_url, 
        		v_league_ticket_url, v_live_stream_embed_code_source, v_live_stream_embed_code, v_live_stream_url_source, v_live_stream_url, 
                v_match_hashtag, v_social_info, v_match_day_battle, v_match_guid, 1, 0, 1, 1, v_current_timestamp, v_current_timestamp,v_year;
        
        v_json := jsonb_set(v_json, '{data,match_centre_id}', v_match_centre_id::text::jsonb, true);
        v_json := jsonb_set(v_json, '{data,match_centre_guid}', ('"'||v_match_guid||'"')::text::jsonb, true);
        v_json := jsonb_set(v_json, '{data,created_by}', 1::text::jsonb, true);
        v_json := jsonb_set(v_json, '{data,created_date}', ('"'||v_current_timestamp||'"')::text::jsonb, true);
        v_json := jsonb_set(v_json, '{data,updated_date}', ('"'||v_current_timestamp||'"')::text::jsonb, true);
        	p_json := v_json;
            p_result := 1;
		else 
	
	    p_json := v_json;
        p_result := 0;
	end if; 

    else
    	
        update labhkind.labhkind_match_centre
        set    sport_id = v_sport_id,
        		series_id = v_series_id,
        		match_id = v_match_id,
        		match_source_object_id = v_match_source_object_id,
                match_title = v_match_title,
        		match_ticket_url = v_match_ticket_url,
        		league_ticket_url = v_league_ticket_url,
                live_stream_embed_code_source = v_live_stream_embed_code_source,
                live_stream_embed_code = v_live_stream_embed_code,
                live_stream_url_source = v_live_stream_url_source,
                live_stream_url = v_live_stream_url,
                match_hashtag = v_match_hashtag,
                social_info = v_social_info,
                match_day_battle = v_match_day_battle,
                updated_date = v_current_timestamp,
				year=v_year
        where  match_centre_id = v_match_centre_id;
        
    end if;
    
    delete from labhkind.labhkind_media 
	where media_id in(select media_id from labhkind.labhkind_match_media_map where match_id = v_match_id);
    delete from labhkind.labhkind_match_media_map where match_id = v_match_id;
    
    if v_media_json is not null then
    	
        for v_media in select * from json_array_elements(v_media_json::json)
        loop
        	
            select  v_media->>'media_type',
            		v_media->>'media_caption',
                    v_media->>'media_desc',
                    v_media->>'media_path',
                    v_media->>'media_copyright_text',
                    v_media->>'media_file_name',
                    v_media->>'media_order_number',
                    v_media->>'media_title_alias',
                    v_media->>'media_unique_id',
                    v_media->>'is_desktop'
            into    v_media_type,
            		v_media_caption,
                    v_media_desc,
                    v_media_path,
                    v_media_copyright_text,
                    v_media_file_name,
                    v_media_order_number,
                    v_media_title_alias,
                    v_media_unique_id,
                    v_media_is_desktop;
            
            v_media_id := nextval('labhkind.seq_labhkind_media_id');
            v_media_guid := uuid_generate_v4();
            
            insert into labhkind.labhkind_media(media_id, media_type, media_caption, media_desc, media_path, media_copyright_text, media_file_name, 
                                      media_order_number, media_title_alias, media_guid, is_active, is_deleted, created_by, updated_by, created_date, 
                                      updated_date, is_desktop, media_unique_id)
			select v_media_id, v_media_type, v_media_caption, v_media_desc, v_media_path, v_media_copyright_text, v_media_file_name, 
            		v_media_order_number, v_media_title_alias, v_media_guid, 1, 0, 1, 1, v_current_timestamp, v_current_timestamp, v_media_is_desktop, 
                    v_media_unique_id;
            
            insert into labhkind.labhkind_match_media_map(match_media_map_id, match_id, media_id, media_match_map_guid, is_active, is_deleted, created_by, 
                                                updated_by, created_date, updated_date)
            select nextval('labhkind.seq_labhkind_match_media_map_id'), v_match_id, v_media_id, uuid_generate_v4(), 1, 1, 1, 1, v_current_timestamp, 
            		v_current_timestamp;
			
            v_set_data :=string_to_array('data,media,'||v_counter::text||',media_id',',');
            v_json := jsonb_set(v_json, v_set_data, v_media_id::text::jsonb, true);
            
            v_set_data :=string_to_array('data,media,'||v_counter::text||',media_guid',',');
            v_json := jsonb_set(v_json, v_set_data, ('"'||v_media_guid||'"')::text::jsonb, true);
            
            v_counter := v_counter + 1;
            
        end loop;
        
		p_json := v_json;
        p_result := 1;
    end if;
	
    update labhkind.labhkind_match_centre 
	set match_centre_json = v_json
	where match_centre_id = v_match_centre_id;
    
    
   
/*exception
	when others then
    	p_result := -1;*/
    
end;

$$;


--
