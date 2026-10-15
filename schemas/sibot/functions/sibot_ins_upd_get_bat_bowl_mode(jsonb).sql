-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_ins_upd_get_bat_bowl_mode(jsonb)
-- Type: FUNCTION

-- Name: sibot_ins_upd_get_bat_bowl_mode(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_ins_upd_get_bat_bowl_mode(p_input_json jsonb, OUT p_out_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

/*SELECT * from  sibot.sibot_ins_upd_get_bat_bowl_mode(
	'
{
  "audit_info": {
    "option_type": "G",
    "type": "Bat",
    "asset_url": null,
    "message_text": "hi, this is test message admin panel",
    "created_by": null,
    "created_date": null,
	"template_type": "Video"
  },
  "attachment_id": null,
  "template_type": "1",
  "media_type": null,
  "league_id": "4"
}
'
)*/

declare
	v_option_type character(2);
	v_channel_id numeric;
    v_channel_name character varying(50);
    /*v_keywords text;
    v_image_path character varying(500); */
    v_application_id numeric;
	v_url text;
	v_message_text text ;
	v_current_timestamp timestamp  ; --:= current_timestamp at time zone 'utc';
	v_session_by text;
	v_file_type text;
	v_audit_list jsonb;
	v_league_list jsonb;
	v_type_list jsonb;
	v_json jsonb := '{"data":[]}'::jsonb;
	v_type text;
	
begin
	select p_input_json->'audit_info'->>'option_type' ,p_input_json->>'application_id',p_input_json->'audit_info'->>'asset_url',
	       p_input_json->'audit_info'->>'message_text' ,p_input_json->'audit_info'->>'created_by',p_input_json->'audit_info'->>'template_type',
		   p_input_json->'audit_info'->>'type',p_input_json->'audit_info'->>'created_date'  
    into v_option_type,v_application_id,v_url,v_message_text,v_session_by,v_file_type,v_type,
	v_current_timestamp;
	
	/*raise notice 'v_option_type:%',v_option_type;
	raise notice 'v_url:%',v_url;
	raise notice 'v_message_text:%',v_message_text;
	raise notice 'v_file_type:%',v_file_type;
	raise notice 'v_session_by:%',v_session_by;
	select 1/0;*/
	--v_current_timestamp:=v_current_timestamp - '5.5 hours'::interval;
    if v_option_type = 'G' 
    then
	
	
	/* v_json := jsonb_set(v_json,'{data,1}',coalesce(v_audit_list,'{}'),true);
     v_json := jsonb_set(v_json,'{data,2}',coalesce(v_type_list,'{}'),true);
     v_json := jsonb_set(v_json,'{data,3}',coalesce(v_league_list,'{}'),true);
     
     p_out_json := v_json;*/
     p_result := 1;
	
	
/*	raise notice 'p_out_json:%',p_out_json;	
	select 1/0;*/

		
	elsif v_option_type = 'I' 
    then
	
       -- select * from sibot.sibot_bat_bowl_mode_post
                    insert into sibot.sibot_bat_bowl_mode_post (bat_bowl_mode_post_id,url,
																  message_text,file_type,opt_type,created_date,created_by)
                    select nextval('sibot.seq_sibot_bat_bowl_mode_id'),v_url,v_message_text,
					v_file_type,v_type,v_current_timestamp,null;
                    
                 
    	            p_result :=1;
    
   else
       p_result := -1;
    end if;
	
	       if  p_result =1 
           then
		   
		select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
               from (select opt_type as type,url as asset_url,message_text as message_text,
				            created_by as created_by,created_date -- + '5.5 hours'::interval 
					        as created_date,file_type as template_type 
					        from sibot.sibot_bat_bowl_mode_post
					)row 
		into v_audit_list;
		
		--raise notice 'v_audit_list:%',v_audit_list;	

		select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
			from (select distinct l.league_id,l.league_name 
				  from sibot.sibot_league l 
				  where l.league_id in (select league_id 
											from sibot.sibot_application_league_map 
											where show_in_buddy=1 and bat_bowl_mode=1)
				)row
		into v_league_list;
		-- raise notice 'v_league_list:%',v_league_list;
		
		select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
				from (select application_bat_bowl_mode_id as type_id,opt_type as type_name  
			          from sibot.sibot_application_bat_bowl_mode order by 1
			          )row
		into v_type_list;
		   select row_to_json(row)::jsonb
	       from (select v_audit_list as audit_list,v_league_list as league_list,
				        v_type_list as type_list  
		        )row
	       into p_out_json;
		   else
    	      p_out_json := '{}'::jsonb;
          end if;
exception
	when others then
    	p_result := -1;
        p_out_json := '{}'::jsonb;
end;

$$;


--
