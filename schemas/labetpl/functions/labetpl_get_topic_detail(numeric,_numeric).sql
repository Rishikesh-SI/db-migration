-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_get_topic_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labetpl_get_topic_detail(numeric, numeric); Type: FUNCTION; Schema: labetpl; Owner: -
--

CREATE FUNCTION labetpl.labetpl_get_topic_detail(p_topicid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_topicjson jsonb, OUT p_authorjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_versionnumber numeric;
     v_image_path varchar(4000);
     v_authorjsonarr jsonb[];
     v_authorjson jsonb;
     v_json1 varchar(30000) := '{"authors":[';
     v_author_count numeric;
     
begin
	
     if p_versionnumber is null then
     	
          select      published_version_number
          into strict v_versionnumber
          from   	  labetpl.labetpl_topic
          where  	  topic_id = p_topicid;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_topicjson
     from   	  labetpl.labetpl_asset_draft
     where  	  asset_type_id  = 5
     and    	  asset_id       = p_topicid
	and    	  version_number = v_versionnumber;
     
     begin
     	
          /*select image_path
     	into   v_image_path
     	from 	labetpl.labetpl_image
     	where image_id = (
     	select asset_id
     	from   labetpl.labetpl_topic_asset_map
     	where  topic_id = p_topicid
     	and is_cover = 1);*/
     	
     	-- p_topicjson := jsonb_set(p_topicjson,'{data,image_path}',v_image_path::jsonb,true);
          
     	select array(
     	select row_to_json(row) jsonrow
     	from
     	(select u.user_id, u.user_name
      	from   labetpl.labetpl_user_role as ur
      	join   labetpl.labetpl_user as u
      	on     u.user_id = ur.user_id
      	join   labetpl.labetpl_author_action aa
      	on     aa.author_id = u.user_id
      	where  u.is_active = 1
      	and    u.is_deleted = 0
      	and    aa.asset_type_id = 5
      	and    aa.action_id = 4
      	and    aa.asset_id = p_topicid) as row)
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
          
     end;
     
     p_result := 1;
     
exception
	
     when others then
     	p_result := -1;
end;

 $$;


--
