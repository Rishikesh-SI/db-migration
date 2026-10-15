-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_ins_image(jsonb)
-- Type: FUNCTION

-- Name: sibot_ins_image(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_ins_image(p_input_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

/*
{
  "opt_type": "",
  "application_id": "",
  "is_source_id": ""
  "match_id": "",
  "player_id": "",
  "image_url": ""
}
*/
declare
	
    v_opt_type text;
   	v_application_id numeric;
    v_league_id numeric;
    v_is_source_id numeric;
    v_images jsonb;
    v_asset_id_arr numeric[];
    v_image_url_arr text[];
    v_asset_id_count numeric;
    v_image_url_count numeric;
    
begin
	
    select p_input_json->>'opt_type', p_input_json->>'application_id', p_input_json->>'is_source_id'
    into v_opt_type, v_application_id, v_is_source_id;
    
    select string_to_array(string_agg((images->>'asset_id'),','),',')
    from (select json_array_elements(a->'images') images
          from (select p_input_json::json a)b)c
	into v_asset_id_arr;
    
    select string_to_array(string_agg((images->>'image_url'),','),',')
    from (select json_array_elements(a->'images') images
          from (select p_input_json::json a)b)c
    into v_image_url_arr;
	
    select array_length(v_asset_id_arr, 1), array_length(v_image_url_arr, 1) into v_asset_id_count, v_image_url_count;
    
    if v_asset_id_count = v_image_url_count then
    	if v_is_source_id = 0 then
        	if v_opt_type = 'MS' or v_opt_type = 'MR' then
            	for i in 1..v_asset_id_count
                loop
                	update sibot.sibot_application_match_map
                    set match_schedule_image_url = v_image_url_arr[i]
                    where application_id = v_application_id
                    and match_id = v_asset_id_arr[i];
				end loop;
			elsif v_opt_type = 'P' then
            	for i in 1..v_asset_id_count
                loop
                	update sibot.sibot_application_league_team_player_map
                    set player_image_url = v_image_url_arr[i]
                    where application_id = v_application_id
                    and player_id = v_asset_id_arr[i];
				end loop;
			elsif v_opt_type = 'MA' then
               	for i in 1..v_asset_id_count
                loop
                	update sibot.sibot_application_match_map
                    set match_alert_image_url = v_image_url_arr[i]
                    where application_id = v_application_id
                    and match_id = v_asset_id_arr[i];
				end loop;
        	end if;
		else
        	if v_opt_type = 'MS' or v_opt_type = 'MR' then
            	for i in 1..v_asset_id_count
                loop
                	update sibot.sibot_application_match_map amm
                    set match_schedule_image_url = v_image_url_arr[i]
                    from sibot.sibot_match m
                    where amm.application_id = v_application_id
                    and m.match_id = amm.match_id
                    and m.source_id = v_asset_id_arr[i]::text;
				end loop;
              elsif  v_opt_type = 'SMR' then
            	for i in 1..v_asset_id_count
                loop
                	update sibot.sibot_application_match_map amm
                    set match_result_image_url = v_image_url_arr[i]
                    from sibot.sibot_match m
                    where amm.application_id = v_application_id
                    and m.match_id = amm.match_id
                    and m.source_id = v_asset_id_arr[i]::text;
				end loop;
                    p_result := 1;
			elsif v_opt_type = 'P' then
               
               
            	for i in 1..v_asset_id_count
                loop
                	update sibot.sibot_application_league_team_player_map altpm
                    set player_image_url = v_image_url_arr[i]
                    /* from sibot.sibot_player p
                    where altpm.application_id = v_application_id
                    and p.player_id = altpm.player_id
                    and p.source_id = v_asset_id_arr[i];*/
                    where player_id = v_asset_id_arr[i];
                    
                    /*raise notice 'v_opt_type:%',v_opt_type;
               select 1/0;*/
            	end loop;
               elsif v_opt_type = 'MA' then
               	for i in 1..v_asset_id_count
                loop
                	update sibot.sibot_application_match_map amm
                    set match_alert_image_url = v_image_url_arr[i]
                    from sibot.sibot_match m
                    where amm.application_id = v_application_id
                    and m.match_id = amm.match_id
                    and m.source_id = v_asset_id_arr[i]::text;
				end loop;
			end if;
        end if;
    end if;
    
end;

$$;


--
