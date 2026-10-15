-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_article_detail_r_ak(character varying)
-- Type: FUNCTION

-- Name: swa_get_article_detail_r_ak(character varying); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_article_detail_r_ak(p_titlealias character varying, OUT p_result numeric, OUT p_articlejson jsonb, OUT p_authorjson jsonb, OUT p_nextprevjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
     v_versionnumber numeric;
     v_articleid numeric;
     v_titlealias text := upper(p_titlealias);
     v_image_caption varchar(4000);
     v_authorjsonarr jsonb[];
     v_authorjson jsonb;
     v_json1 varchar(30000) := '{"authors":[';
     v_author_count numeric;
     v_primary_ent_id numeric;
     v_secondary_ent_id numeric;
     v_asset_type_id numeric:=1;
begin
	
     /*if p_versionnumber is null then
     	
          select      published_version_number
          into strict v_versionnumber
          from   	  swa.swa_article
          where  	  article_id = p_articleid;
          
          select version_number
          into strict v_versionnumber
          from swa.swa_asset_draft ad
          where asset_type_id = 1
          and asset_id = p_articleid
          order by version_number desc
          limit 1;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;*/
     
     select article_id, published_version_number
     into   v_articleid, v_versionnumber
     from   swa.swa_article
     where  upper(title_alias) = v_titlealias;
     
     select 	  asset_data
     into strict p_articlejson
     from   	  swa.swa_asset_draft
     where  	  asset_type_id  = 1
     and    	  asset_id       = v_articleid
	and    	  version_number = v_versionnumber;
     
     
     begin
     select image_caption
     into strict v_image_caption
     from 	swa.swa_image
     where image_id = (
     select asset_id
     from   swa.swa_article_asset_map
     where  article_id = v_articleid
     and is_cover = 1);
     exception
     	when no_data_found then
          	v_image_caption := ' ';
     end;
     p_articlejson := jsonb_set(p_articlejson, '{data,image_caption}', ('"'||v_image_caption||'"')::text::jsonb, true);
     
     -- p_articlejson := jsonb_set(p_articlejson,'{data,image_path}',v_image_path::text::jsonb);
     
     select array(
     select row_to_json(row) jsonrow
     from
     (select u.user_id, u.display_name user_name
      from   swa.swa_user_role as ur
      join   swa.swa_user as u
      on     u.user_id = ur.user_id
      join   swa.swa_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = 1
      and    aa.action_id = 4
      and    aa.asset_id = v_articleid) as row)
     into v_authorjsonarr;
     
     SELECT primary_entity_role_map_id,secondary_entity_role_map_id
     into v_primary_ent_id,v_secondary_ent_id
     FROM SWA.SWA_ASSET_LIST 
     WHERE ASSET_TYPE_ID=v_asset_type_id
     and asset_id=v_articleid;
     
     select s.p_assetjson
     from swa.swa_get_asset_next_prev_r(v_articleid,v_asset_type_id,ARRAY[v_primary_ent_id,v_secondary_ent_id]) s
     into p_nextprevjson;
     
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
     
     v_json1 := v_json1||']';
     
     p_authorjson := v_json1::jsonb;
     
     p_result := 1;
     
/*exception
	
     when others then
     	p_result := -1;*/
     
end;

$$;


--
