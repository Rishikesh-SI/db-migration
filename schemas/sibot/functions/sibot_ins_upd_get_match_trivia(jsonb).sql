-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_ins_upd_get_match_trivia(jsonb)
-- Type: FUNCTION

-- Name: sibot_ins_upd_get_match_trivia(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_ins_upd_get_match_trivia(p_input_json jsonb, OUT p_out_json jsonb, OUT p_result numeric) RETURNS record
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
	v_opt_type character(2);
	v_sport_id numeric;
	v_league_id numeric;
    v_channel_name character varying(50);
    /*v_keywords text;
    v_image_path character varying(500); */
    v_application_id numeric;
	v_url text;
	v_message_text text ;
	v_current_timestamp timestamp  := current_timestamp at time zone 'utc';
	v_session_by text;
	v_file_type text;
	v_json jsonb := '{"data":[]}'::jsonb;
	--v_application_id numeric;
	--v_type text;
	
begin
	select p_input_json->>'opt_type' ,p_input_json->>'application_id',p_input_json->>'image_url',
	       p_input_json->>'message_text' ,p_input_json->>'created_by',p_input_json->>'file_type',
		   p_input_json->>'application_id',p_input_json->>'sport_id',p_input_json->>'league_id'  
    into v_opt_type,v_application_id,v_url,v_message_text,v_session_by,v_file_type,v_application_id,
	     v_sport_id,v_league_id;
	
	/*raise notice 'v_option_type:%',v_option_type;
	raise notice 'v_url:%',v_url;
	raise notice 'v_message_text:%',v_message_text;
	raise notice 'v_file_type:%',v_file_type;
	raise notice 'v_session_by:%',v_session_by;
	select 1/0;*/
	--v_current_timestamp:=v_current_timestamp - '5.5 hours'::interval;
    if v_opt_type = 'G' 
    then
	
	
	/* v_json := jsonb_set(v_json,'{data,1}',coalesce(v_audit_list,'{}'),true);
     v_json := jsonb_set(v_json,'{data,2}',coalesce(v_type_list,'{}'),true);
     v_json := jsonb_set(v_json,'{data,3}',coalesce(v_league_list,'{}'),true);
     
     p_out_json := v_json;*/
     p_result := 1;
	
	
/*	raise notice 'p_out_json:%',p_out_json;	
	select 1/0;*/

		
	elsif v_opt_type = 'I' 
    then
	
       -- select * from sibot.sibot_match_trivia_post
                    insert into sibot.sibot_match_trivia_post (match_trivia_post_id,application_id,image_url,
																  message_text,file_type,created_date,created_by,sport_id,league_id)
                    select nextval('sibot.seq_sibot_match_trivia_post_id'),v_application_id,v_url,v_message_text,
					v_file_type,v_current_timestamp,null,v_sport_id,v_league_id;
                    
                 
    	            p_result :=1;
    
   else
       p_result := -1;
    end if;
	
	       if  p_result =1 
           then
		   
		select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
               from (select s.sport_name,l.league_name,mtp.* 
					        from sibot.sibot_match_trivia_post mtp 
                            join sibot.sibot_sport s 
					        on mtp.sport_id=s.sport_id
							join sibot.sibot_league l 
					 		on mtp.league_id=l.league_id
					)row 
		into p_out_json;
else
p_out_json := '{}'::jsonb;
end if;
/*exception
	when others then
    	p_result := -1;
        p_out_json := '{}'::jsonb;*/
end;

$$;


--
