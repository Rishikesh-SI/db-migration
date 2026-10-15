-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_ins_upd_get_main_menu_master(jsonb)
-- Type: FUNCTION

-- Name: sibot_ins_upd_get_main_menu_master(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_ins_upd_get_main_menu_master(p_input_json jsonb, OUT p_event_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

/*--opt_type = "S"-updating active and deactivate status,"U"- upadate sports,"I"-insert sports,"G"- get sports
select  * from sibot.sibot_ins_upd_get_sport_master(
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
	v_event_id numeric;
	v_application_id numeric;
	v_image_url text;
	v_event_name character varying(70);
begin
	select p_input_json->>'opt_type',p_input_json->>'status',
	p_input_json->>'event_id',p_input_json->>'application_id',
	p_input_json->>'img_url',p_input_json->>'event_name'   
    into v_opt_type, v_status,v_event_id,v_application_id,v_image_url,v_event_name;
	-- raise notice 'v_event_id:%',v_event_id;
	-- raise notice 'v_status:%',v_status;
	-- raise notice 'v_application_id:%',v_application_id;
	--select 1/0;
    if v_opt_type = 'G'
	then
    	p_result = 1;
   elsif v_opt_type='U'
   then
   
       if v_event_name is not null 
	   then 
		   update sibot.sibot_application_event_widget_message
		   set message_text=v_event_name
		   where application_id=v_application_id and event_id=v_event_id
				 and main_status=1;
		   p_result = 1;
	   elsif v_image_url is not null 
	   then
	       update sibot.sibot_application_event_widget_message
		   set image_url=v_image_url
		   where application_id=v_application_id and event_id=v_event_id
				 and main_status=1;
		   p_result = 1;
	   end if;

   elsif v_opt_type = 'S'  
   then
	/*raise notice 'v_application_id:%',v_application_id;
	raise notice 'v_event_id:%',v_event_id;
	raise notice 'v_status:%',v_status;
	select 1/0;*/
	--select * from sibot.sibot_application_event_widget_map where event_id=4
         update sibot.sibot_application_event_widget_map
         set is_active = coalesce (v_status,is_active)
         where event_id=v_event_id and application_id=v_application_id;
        	 
		 p_result := 1;
     else
         p_result := -1;
    end if;
    	
    
    if p_result = 1 then
    	select ('{"events":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
		from (/*select distinct e.event_id as event_id,aewmm.message_text as event_name,
			         aewm.is_active as is_active 
                     from sibot.sibot_event e 
                     join sibot.sibot_application_event_widget_map aewm
                     on e.event_id=aewm.event_id 
                     join sibot.sibot_application_event_widget_message aewmm
                     on e.event_id=aewmm.event_id
                     where aewmm.message_text is not null 
			               and image_url is not null
                           and main_status=1 
			               and aewmm.application_id=2*/
			
			select distinct aewmm.event_id,aewmm.message_text as event_name,
aewm.is_active as is_active,aewmm.image_url as image_url from sibot.sibot_application_event_widget_map aewm
join sibot.sibot_application_event_widget_message aewmm
on aewm.application_id=aewmm.application_id
and aewm.event_id=aewmm.event_id and aewm.widget_id=aewmm.widget_id
where main_status=1 and aewmm.application_id=v_application_id
             )row
		into p_event_json;
    else
    	p_event_json := '{}'::jsonb;
    end if;
	--raise notice 'p_event_json:%',p_event_json;
	--select 1/0;
/*exception
	when others then
    	p_result := -1;
        p_event_json := '{}'::jsonb;*/
end;

$$;


--
