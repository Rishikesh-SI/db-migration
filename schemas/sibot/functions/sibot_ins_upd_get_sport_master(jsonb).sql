-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_ins_upd_get_sport_master(jsonb)
-- Type: FUNCTION

-- Name: sibot_ins_upd_get_sport_master(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_ins_upd_get_sport_master(p_input_json jsonb, OUT p_sport_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

/*--opt_type = "S"-updating active and deactivate status,"U"- upadate sports,"I"-insert sports,"G"- get sports
select  sibot.sibot_ins_upd_get_sport_master(
'{
  "team_id": null,
  "opt_type": "G",
  "name": "Sport-Club Freiburg",
  "meta_data": "dsadas",
  "start_date": null,
  "end_date": null,
  "short_name": null,
  "sport_id": "1",
  "has_team": null,
  "schedule_image_id": null,
  "application_ids": null,
  "team_a_id": null,
  "team_b_id": null,
  "channel_id": null,
  "league_id": "4",
  "status": "0",
  "show_in_buddy": null,
  "image_url": null
}' -- > p_input_json jsonb
);
*/
declare
	v_opt_type character(2);
	v_sport_id numeric;
    v_sport_name character varying(50);
    v_keywords text;
    v_image_path character varying(500);
    v_status numeric;
begin
	select p_input_json->>'opt_type', p_input_json->>'name',
    p_input_json->>'meta_data',p_input_json->>'sport_id', p_input_json->>'status' 
    into v_opt_type, v_sport_name, v_keywords,v_sport_id, v_status;
    if v_opt_type = 'G' then
    	p_result = 1;
	elsif v_opt_type = 'I' or v_opt_type = 'U' then
   
    	if v_sport_id is null then
         if not exists(select 1 from sibot.sibot_sport where sport_name=v_sport_name)
         then
    		insert into sibot.sibot_sport(sport_id,sport_name,sport_payload_text,meta_data,status,created_date)
        	select nextval('sibot.seq_sibot_sport_id'),v_sport_name,replace(v_sport_name,' ',''),v_keywords,1,now()::date;
            end if;
        	p_result := 1;
    	elsif v_sport_id is not null then
    		update sibot.sibot_sport
        	set meta_data = v_keywords, 
                status = coalesce(v_status,status),
                updated_date = (select now()::date)
        	where sport_id = v_sport_id;
        	 p_result := 1;
            else
            p_result := -1;
    	end if;
    	elsif v_opt_type = 'S' and v_sport_id is not null then
        update sibot.sibot_sport
        	set status = coalesce(v_status,status),
                updated_date = (select now()::date)
        	where sport_id = v_sport_id;
        	p_result := 1;
            else
    	p_result := -1;
    end if;
    if p_result = 1 then
    	select ('{"sports":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
		from (select sport_id,sport_name,meta_data,status
              from sibot.sibot_sport order by created_date 
             )row
		into p_sport_json;
    else
    	p_sport_json := '{}'::jsonb;
    end if;
/*exception
	when others then
    	p_result := -1;
        p_sport_json := '{}'::jsonb;*/
end;

$$;


--
