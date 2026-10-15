-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_venue_master(jsonb)
-- Type: FUNCTION

-- Name: sibot_get_venue_master(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_venue_master(p_input_json jsonb, OUT p_venue_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

/*--opt_type = "S"-updating active and deactivate status,"U"- upadate sports,
                "I"-insert sports,"G"- get sports,"F" - auto-searching functionality.
select  sibot.sibot_get_venue_master(
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
	v_channel_id numeric;
    v_channel_name character varying(50);
    /*v_keywords text;
    v_image_path character varying(500);
    v_status numeric; */
begin
	select p_input_json->>'opt_type', p_input_json->>'name',p_input_json->>'channel_id' 
    into v_opt_type, v_channel_name,v_channel_id;
    if v_opt_type = 'G' 
    then
    	p_result = 1;
	/*elsif v_opt_type = 'I' or v_opt_type = 'U' 
    then
            if v_channel_id is null 
            then
                if not exists (select 1 from sibot.sibot_channel 
                               where lower(channel_name) = lower(v_channel_name))
                then
                    insert into sibot.sibot_channel(channel_id,channel_name,created_date)
                    select nextval('sibot.seq_sibot_channel_id'),v_channel_name,now()::date;
                    p_result := currval('sibot.seq_sibot_channel_id');  
                 else
                    p_result :=1;
                  end if;
            elsif v_channel_id is not null 
            then
    	        update sibot.sibot_channel
                set channel_name = v_channel_name,
                    updated_date = (select now()::date) 
                where channel_id = v_channel_id;
                p_result := v_channel_id;
           else
               p_result := -1;
       end if;
   else
       p_result := -1;*/
    end if;
           if p_result =1
           then
    	       select ('{"venues":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
		       from (select *
               from sibot.sibot_venue where status=1 order by 1
               )row
		       into p_venue_json;
          else
    	      p_venue_json := '{}'::jsonb;
          end if;
exception
	when others then
    	p_result := -1;
        p_venue_json := '{}'::jsonb;
end;

$$;


--
