-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_topic_detail_preview_r_20180524(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: swa_get_topic_detail_preview_r_20180524(numeric, numeric, numeric); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_topic_detail_preview_r_20180524(p_topicid numeric, p_versionnumber numeric, p_is_preview numeric, OUT p_result numeric, OUT p_topicjson jsonb, OUT p_authorjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

---********************************PREFACE BLOCK*******************************
	--    NAME: _get_topic_detail_preview_r
	----  Purpose: to get the data is_preview case for topic
	----  Parameters:
	------  External Output:
	------  Written/Modified by:   Date:           Reason:
	--  Purushottam Kayarkar       09/05/2018       CREATION
	--********************************END PREFACE BLOCK***************************
    
declare
	
     v_versionnumber numeric;
     v_image_path varchar(4000);
     v_authorjsonarr jsonb[];
     v_authorjson jsonb;
     v_json1 varchar(30000) := '{"authors":[';
     v_author_count numeric;
     
     v_actual_topic_id numeric;
begin
     
/*     select topic_id into v_actual_topic_id
     from swa.swa_topic
     where channel_id=p_topicid;
*/

  if p_versionnumber is null then
  
     select  max(version_number) 
     into v_versionnumber
     from swa.swa_asset_draft 
     where asset_type_id = 5
     and (asset_data->'data'->>'channel_id')::numeric = p_topicid ;
     
  else
   
   v_versionnumber := p_versionnumber;
          
  end if;
  
     select asset_id 
     into v_actual_topic_id
     from swa.swa_asset_draft 
     where asset_type_id = 5
     and (asset_data->'data'->>'channel_id')::numeric = p_topicid
     and version_number = v_versionnumber;     
          
     select 	  asset_data
     into strict p_topicjson
     from   	  swa.swa_asset_draft
     where  	  asset_type_id  = 5
     and    	  asset_id       = v_actual_topic_id
	 and    	  version_number = v_versionnumber;
     
     /*select image_path
     into   v_image_path
     from 	swa.swa_image
     where image_id = (
     select asset_id
     from   swa.swa_topic_asset_map
     where  topic_id = p_topicid
     and is_cover = 1);*/
     
     -- p_topicjson := jsonb_set(p_topicjson,'{data,image_path}',v_image_path::text::jsonb);
     
     select array(
     select row_to_json(row) jsonrow
     from
     (select u.user_id, u.display_name
      from   swa.swa_user_role as ur
      join   swa.swa_user as u
      on     u.user_id = ur.user_id
      join   (select (jsonb_array_elements(a)->>'author_id')::text::numeric author_id , 
              		(jsonb_array_elements(a)->>'action_id')::text::numeric action_id
     		  from (select p_topicjson->'data'->'author_data' as a)c
              ) aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
     -- and    aa.asset_type_id = 5
      and    aa.action_id = 4
     -- and    aa.asset_id = v_actual_topic_id
     ) as row)
     into v_authorjsonarr;
     
     foreach v_authorjson in array v_authorjsonarr
     loop
     	v_json1 := v_json1||v_authorjson||',';
     end loop;
     
     SELECT COUNT(1)
     	INTO    v_author_count
     	FROM    UNNEST(v_authorjsonarr) author_id;
     	
     	IF v_author_count > 0 THEN
     		v_json1 := substring(v_json1,1,(length(v_json1)-1));
     	else
     		V_JSON1:= substring(v_json1,1,(length(v_json1)));
     	end if;
     
     v_json1 := v_json1||']}';
     
     p_authorjson := v_json1::jsonb;
     
     p_result := 1;
     
/*exception
	
     when others then
     	p_result := -1;
  */   
end;

$$;


--
