-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_match_centre_detail_r(numeric, character varying, numeric, numeric, numeric, numeric, numeric[], numeric[])
-- Type: FUNCTION

-- Name: isl_get_match_centre_detail_r(numeric, character varying, numeric, numeric, numeric, numeric, numeric[], numeric[]); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_match_centre_detail_r(p_series_id numeric, p_match_source_object_id character varying, p_show_leaderboard numeric, p_page_number numeric, p_item_number numeric, p_page_size numeric, p_entity_role_map_id numeric[], p_asset_type_id numeric[], OUT p_json jsonb, OUT p_asset_count numeric) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
    v_match_centre_json jsonb;
    v_leader_board_json jsonb;
    v_match_id numeric;
    v_entity_role_map_id numeric[] := p_entity_role_map_id;
    v_listing_asset_count numeric;
    v_listing_asset_json jsonb;
    v_matchcentrejsonarray json[];
    v_matchcentredata json;
    v_matchcentredatajson text := '{"match_centre":[';
    v_matchreportpreviewjsonarray json[];
    v_matchreportpreview json;
    v_matchreportpreviewjson text := '{"match_report_preview":[';
    v_i numeric := 1;
    v_match_id_arr numeric[];
    v_match_id_count numeric;
    
begin
	
    select coalesce(array_length(string_to_array(p_match_source_object_id,','),1),0) into v_match_id_count;
    
    if p_match_source_object_id is not null and v_match_id_count = 1 then
    	
        if exists(select 1 from isl.isl_match_centre where match_source_object_id = p_match_source_object_id and series_id = p_series_id) then
        	
            select match_centre_json, leader_board, match_id into v_match_centre_json, v_leader_board_json, v_match_id
            from isl.isl_match_centre where match_source_object_id = p_match_source_object_id and series_id = p_series_id;
            
            if p_show_leaderboard = 1 then
        		v_match_centre_json := jsonb_set(v_match_centre_json,'{data,leader_board}',coalesce(v_leader_board_json,'[]')::text::jsonb,true);
			end if;
    		
    		select array_append(v_entity_role_map_id, v_match_id) into v_entity_role_map_id;
        	select * from isl.isl_get_asset_listing_r(p_page_number, p_item_number, p_page_size, v_entity_role_map_id, null, p_asset_type_id, null) s1
    		into v_listing_asset_count, v_listing_asset_json;
        	v_match_centre_json := jsonb_set(v_match_centre_json,'{data,assets}',v_listing_asset_json,true);
        	
        	select array(select row_to_json(row)
			from
			(
            	select a.asset_type, al.asset_id, al.asset_type_id, al.asset_title title, al.title_alias, erm.entity_role_map_id,
                		lower(em.entity_name) entity_name
				from
				(
                    select 'Report' asset_type, aem.asset_id, aem.asset_type_id
                    from isl.isl_asset_entity_map aem
                    where aem.entity_role_map_id in(825,v_match_id,p_entity_role_map_id[1])
                    group by aem.asset_id, aem.asset_type_id
                    having count(1) = 3
                    union
                	select 'Preview' asset_type, aem.asset_id, aem.asset_type_id
                	from isl.isl_asset_entity_map aem
                	where aem.entity_role_map_id in(826,v_match_id,p_entity_role_map_id[1])
                	group by aem.asset_id, aem.asset_type_id
                	having count(1) = 3
            	)a
            	join isl.isl_asset_list al
            	on al.asset_id = a.asset_id
            	and al.asset_type_id = a.asset_type_id
            	join isl.isl_entity_role_map erm
            	on erm.entity_role_map_id = al.secondary_entity_role_map_id
            	join isl.isl_entity_master em
            	on em.entity_master_id = erm.entity_master_id
        	)row)
			into v_matchreportpreviewjsonarray;
        	
        	if array_length(v_matchreportpreviewjsonarray, 1) > 0 then
            	foreach v_matchreportpreview in array v_matchreportpreviewjsonarray
            	loop
                	v_matchreportpreviewjson := v_matchreportpreviewjson||v_matchreportpreview||',';
				end loop;
            	if (select count(1) from unnest(v_matchreportpreviewjsonarray)) > 0 then
            		v_matchreportpreviewjson := substring(v_matchreportpreviewjson,1,(length(v_matchreportpreviewjson)-1));
				else
            		v_matchreportpreviewjson := substring(v_matchreportpreviewjson,1,(length(v_matchreportpreviewjson)));
				end if;
            	v_matchreportpreviewjson := v_matchreportpreviewjson||']}';
        	else
            	v_matchreportpreviewjson := '{"match_report_preview":[]}';
			end if;
        	
        	v_match_centre_json := jsonb_set(v_match_centre_json::jsonb,'{data,match_report_preview}'::text[],v_matchreportpreviewjson::jsonb,true);
            
        else
        	
			v_listing_asset_count := 0;
			v_match_centre_json := '{"data":null}'::jsonb;
			
        end if;
        
    else
       
        if v_match_id_count = 0 then
			-- select array(select match_id from isl.isl_match_centre where series_id = p_series_id) into v_match_id_arr;
            select array(select match_source_object_id from isl.isl_match_centre where series_id = p_series_id) into v_match_id_arr;
		else
        --	 raise notice 'else ';  
        	select string_to_array(p_match_source_object_id,',') into v_match_id_arr;
        end if ;
        
       	-- raise notice 'else %', v_match_id_arr ;
         
		foreach v_match_id in array v_match_id_arr
		loop
			select match_centre_json into v_match_centre_json 
            from isl.isl_match_centre
            where -- series_id = p_series_id 
            -- and match_id = v_match_id
             match_source_object_id  = v_match_id::varchar
            ;
            
			v_match_centre_json := jsonb_set(v_match_centre_json,'{data,leader_board}','[]'::text::jsonb,true);
			v_match_centre_json := jsonb_set(v_match_centre_json,'{data,assets}','[]'::text::jsonb,true);
			v_match_centre_json := jsonb_set(v_match_centre_json,'{data,match_report_preview}','[]'::text::jsonb,true);
			v_matchcentrejsonarray[v_i] := coalesce(v_match_centre_json,'{}');
			v_i := v_i + 1;
		end loop;
		
		if array_length(v_matchcentrejsonarray, 1) > 0 then
			
			foreach v_matchcentredata in array v_matchcentrejsonarray
			loop
                v_matchcentredatajson := v_matchcentredatajson||v_matchcentredata||',';
			end loop;
			
			if (select count(1) from unnest(v_matchcentrejsonarray)) > 0 then
				v_matchcentredatajson := substring(v_matchcentredatajson,1,(length(v_matchcentredatajson)-1));
			else
				v_matchcentredatajson := substring(v_matchcentredatajson,1,(length(v_matchcentredatajson)));
			end if;
			
		end if;
            
		v_listing_asset_count := 0;
		v_matchcentredatajson := v_matchcentredatajson||']}';
		v_match_centre_json := v_matchcentredatajson::jsonb;
        
        if p_show_leaderboard = 1 then
        	
            /*select leader_board into v_leader_board_json
            from isl.isl_match_centre
            where series_id = p_series_id
            and substring(match_title, '.*,Match (\d+)$')::numeric in(select max(substring(match_title, '.*,Match (\d+)$')::numeric)
                                                                      from isl.isl_match_centre
                                                                      where leader_board is not null);*/
			
            select leader_board into v_leader_board_json
			from isl.isl_match_centre
			where series_id = p_series_id  
			and leader_board is not null
			and match_centre_json->'data'->>'match_date' = (select max(match_centre_json->'data'->>'match_date') from isl.isl_match_centre
                                                            where series_id = p_series_id and leader_board is not null);
			
			v_match_centre_json := jsonb_set(v_match_centre_json::jsonb,'{leader_board}'::text[],coalesce(v_leader_board_json,'[]')::text::jsonb,true);
            
        end if;
		
    end if;
	

    p_asset_count := v_listing_asset_count;
    p_json := v_match_centre_json;
    
end;

$_$;


--
