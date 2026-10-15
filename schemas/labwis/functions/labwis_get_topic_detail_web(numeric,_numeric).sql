-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_get_topic_detail_web(numeric, numeric)
-- Type: FUNCTION

-- Name: labwis_get_topic_detail_web(numeric, numeric); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_get_topic_detail_web(p_topicid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_topicjson jsonb, OUT p_authorjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

    
declare
	
     v_versionnumber numeric;
     v_image_path varchar(4000);
     v_authorjsonarr jsonb[];
     v_authorjson jsonb;
     v_json1 varchar(30000) := '{"authors":[';
     v_author_count numeric;
     
     v_actual_topic_id numeric;
begin
     
     select topic_id into v_actual_topic_id
     from labwis.labwis_topic
     where channel_id=p_topicid;
     
     if p_versionnumber is null then
     	
          /*select      published_version_number
          into strict v_versionnumber
          from   	  labwis.labwis_topic
          where  	  topic_id = p_topicid;*/
          
          /*select version_number
          into strict v_versionnumber
          from labwis.labwis_asset_draft ad
          where asset_type_id = 5
          and asset_id = v_actual_topic_id
          order by version_number desc
          limit 1;*/
          
          select      published_version_number
          into strict v_versionnumber
          from   	  labwis.labwis_topic
          where  	  topic_id = v_actual_topic_id;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_topicjson
     from   	  labwis.labwis_asset_draft
     where  	  asset_type_id  = 5
     and    	  asset_id       = v_actual_topic_id
	and    	  version_number = v_versionnumber;
     
     /*select image_path
     into   v_image_path
     from 	labwis.labwis_image
     where image_id = (
     select asset_id
     from   labwis.labwis_topic_asset_map
     where  topic_id = p_topicid
     and is_cover = 1);*/
     
     -- p_topicjson := jsonb_set(p_topicjson,'{data,image_path}',v_image_path::text::jsonb);
     
     select array(
     select row_to_json(row) jsonrow
     from
     (select u.user_id, u.display_name
      from   labwis.labwis_user_role as ur
      join   labwis.labwis_user as u
      on     u.user_id = ur.user_id
      join   labwis.labwis_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = 5
      and    aa.action_id = 4
      and    aa.asset_id = v_actual_topic_id) as row)
     into v_authorjsonarr;
     
     foreach v_authorjson in array v_authorjsonarr
     loop
     	v_json1 := v_json1||v_authorjson||',';
     end loop;
     
     select count(1)
     	into    v_author_count
     	from    unnest(v_authorjsonarr) author_id;
     	
     	if v_author_count > 0 then
     		v_json1 := substring(v_json1,1,(length(v_json1)-1));
     	else
     		v_json1:= substring(v_json1,1,(length(v_json1)));
     	end if;
     
     v_json1 := v_json1||']}';
     
     p_authorjson := v_json1::jsonb;
     
     p_result := 1;
     
exception
	
     when others then
     	p_result := -1;
     
end;

 $$;


--
