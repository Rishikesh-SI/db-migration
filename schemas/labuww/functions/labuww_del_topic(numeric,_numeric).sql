-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_del_topic(numeric, numeric)
-- Type: FUNCTION

-- Name: labuww_del_topic(numeric, numeric); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_del_topic(p_option numeric, p_channelid numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
    v_topicid numeric;
    v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
    v_assettypeid numeric := 5;
    
begin
	
    begin
    	select topic_id
        into strict v_topicid
        from   labuww.labuww_topic
        where  channel_id = p_channelid;
  	exception
     	when no_data_found then
          	v_topicid := null;
            p_result := 0;
  	end;
    
    if v_topicid is not null and p_option = 1 then
    	
        update labuww.labuww_topic
        set    is_published = 0,
        	   is_trashed   = 1,
               is_active    = 0,
               is_deleted   = 1,
               updated_date = v_currenttimestamp
		where  topic_id     = v_topicid;
        
        update labuww.labuww_asset_list
        set    updated_date    = v_currenttimestamp,
               is_active       = 0,
               is_deleted      = 1,
               is_published    = 0,
               is_trashed      = 1
		where  asset_id        = v_topicid
        and    asset_type_id   = v_assettypeid;
        
        p_result := 1;
        
    end if;
end;

 $$;


--
