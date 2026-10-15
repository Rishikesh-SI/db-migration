-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_get_article_detail_web(numeric, numeric)
-- Type: FUNCTION

-- Name: labisp_get_article_detail_web(numeric, numeric); Type: FUNCTION; Schema: labisp; Owner: -
--

CREATE FUNCTION labisp.labisp_get_article_detail_web(p_articleid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_articlejson jsonb, OUT p_authorjson jsonb) RETURNS record
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
     	
          /*select      published_version_number
          into strict v_versionnumber
          from   	  labisp.labisp_article
          where  	  article_id = p_articleid;*/
          
          select version_number
          into strict v_versionnumber
          from labisp.labisp_asset_draft ad
          where asset_type_id = 1
          and asset_id = p_articleid
          order by version_number desc
          limit 1;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_articlejson
     from   	  labisp.labisp_asset_draft
     where  	  asset_type_id  = 1
     and    	  asset_id       = p_articleid
	and    	  version_number = v_versionnumber;
     
     select image_path
     into   v_image_path
     from 	labisp.labisp_image
     where image_id = (
     select asset_id
     from   labisp.labisp_article_asset_map
     where  article_id = p_articleid
     and is_cover = 1);
     
     -- p_articlejson := jsonb_set(p_articlejson,'{data,image_path}',v_image_path::text::jsonb);
     
     select array(
     select row_to_json(row) jsonrow
     from
     (select u.user_id, u.user_name
      from   labisp.labisp_user_role as ur
      join   labisp.labisp_user as u
      on     u.user_id = ur.user_id
      join   labisp.labisp_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = 1
      and    aa.action_id = 4
      and    aa.asset_id = p_articleid) as row)
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
