-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_get_article_detail_web(numeric, numeric)
-- Type: FUNCTION

-- Name: u17wc_get_article_detail_web(numeric, numeric); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_get_article_detail_web(p_articleid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_articlejson jsonb, OUT p_authorjson jsonb) RETURNS record
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
          from   	  u17wc.u17wc_article
          where  	  article_id = p_articleid;*/
          
          select version_number
          into strict v_versionnumber
          from u17wc.u17wc_asset_draft ad
          where asset_type_id = 1
          and asset_id = p_articleid
          order by version_number desc
          limit 1;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_articlejson
     from   	  u17wc.u17wc_asset_draft
     where  	  asset_type_id  = 1
     and    	  asset_id       = p_articleid
	and    	  version_number = v_versionnumber;
     
     select image_path
     into   v_image_path
     from 	u17wc.u17wc_image
     where image_id = (
     select asset_id
     from   u17wc.u17wc_article_asset_map
     where  article_id = p_articleid
     and is_cover = 1);
     
     -- p_articlejson := jsonb_set(p_articlejson,'{data,image_path}',v_image_path::text::jsonb);
     
     select array(
     select row_to_json(row) jsonrow
     from
     (select u.user_id, u.user_name
      from   u17wc.u17wc_user_role as ur
      join   u17wc.u17wc_user as u
      on     u.user_id = ur.user_id
      join   u17wc.u17wc_author_action aa
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
     
exception
	
     when others then
     	p_result := -1;
     
end;

     $$;


--
