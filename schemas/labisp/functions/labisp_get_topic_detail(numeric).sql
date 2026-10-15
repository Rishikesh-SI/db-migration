-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_get_topic_detail(numeric)
-- Type: FUNCTION

-- Name: labisp_get_topic_detail(numeric); Type: FUNCTION; Schema: labisp; Owner: -
--

CREATE FUNCTION labisp.labisp_get_topic_detail(p_topic_master_id numeric, OUT p_topicjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	
    
	 v_topicjson jsonb;

begin

     if p_topic_master_id is not null  then
		
		select '{"data":'||string_agg(row_to_json(tab)::text,',')||'}' into v_topicjson from (
		select 
		topic_master_id,
		sport_id,
		sport_name,
		match_id,
		match_name,
		channel_type,
		channel_name,
		handle_value,
		channel_id
		from labisp.labisp_topic
		where topic_master_id=p_topic_master_id
		)tab;
      
	  
	  end if ;
	 p_topicjson:=v_topicjson;

-- exception

   --when others then
  	--p_result := -1;
end;

$$;


--
