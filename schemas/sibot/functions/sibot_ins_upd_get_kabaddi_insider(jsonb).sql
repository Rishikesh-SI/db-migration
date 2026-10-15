-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_ins_upd_get_kabaddi_insider(jsonb)
-- Type: FUNCTION

-- Name: sibot_ins_upd_get_kabaddi_insider(jsonb); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_ins_upd_get_kabaddi_insider(p_input_json jsonb, OUT p_user_kabaddi_insider_json jsonb, OUT p_receivers text[], OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

/*SELECT * from sibot.sibot_ins_upd_get_kabaddi_insider(
	'{
  "opt_type": "P",
  "image_url": "uuuud.url",
  "video_url": "uururu.url",
  "message_text": "whata astddsgds",
  "created_by": "reddy"
}'
)*/

declare
	v_opt_type character(2);
	v_channel_id numeric;
    v_channel_name character varying(50);
    /*v_keywords text;
    v_image_path character varying(500); */
    v_application_id numeric;
	v_image_url text;
	v_video_url text;
	v_message_text text ;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_session_by text;
begin
	select p_input_json->>'opt_type' ,p_input_json->>'application_id',p_input_json->>'image_url',p_input_json->>'video_url',
	       p_input_json->>'message_text' ,p_input_json->>'created_by' 
    into v_opt_type,v_application_id,v_image_url,v_video_url,v_message_text,v_session_by;
    if v_opt_type = 'G' 
    then
	    update sibot.sibot_user_kabaddi_insider 
		 set alert_status=1,alert_stopped_till =null
		 where alert_stopped_till::date < v_current_timestamp::date;
		 
		 
    	select array(select distinct u.receiver_id
                     from sibot.sibot_user_kabaddi_insider uki
                     join sibot.sibot_user u
                     on u.user_id = uki.user_id
                     where u.application_id = v_application_id
                     and uki.alert_status = 1 )
		into p_receivers;
		p_result :=1;
	elsif v_opt_type = 'P' 
    then
       -- select * from sibot.sibot_kabaddi_insider_post   
                    insert into sibot.sibot_kabaddi_insider_post (sibot_kabaddi_insider_post_id,image_url,
																  video_url,message_text,created_date,created_by)
                    select nextval('sibot.seq_sibot_kabaddi_insider_post_id'),v_image_url,v_video_url,v_message_text,
					v_current_timestamp,v_session_by;
                    
                 
    	            p_result :=1;
    elsif v_opt_type = 'L' 
    then     
	   p_result=2;
	
   else
       p_result := -1;
    end if;
           if p_result =2
           then
    	       select ('['||string_agg(row_to_json(row)::text,',')||']')::jsonb
		       from (select *
               from sibot.sibot_kabaddi_insider_post
               )row
		       into p_user_kabaddi_insider_json;
          else
    	      p_user_kabaddi_insider_json := '{}'::jsonb;
          end if;
/*exception
	when others then
    	p_result := -1;
        p_user_kabaddi_insider_json := '{}'::jsonb;*/
end;

$$;


--
