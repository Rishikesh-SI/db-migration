-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_get_article_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: yho_get_article_detail(numeric, numeric); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_get_article_detail(p_articleid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_articlejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
     v_versionnumber numeric;
     v_image_path varchar(4000);
     v_assettype numeric;
     
begin
	
     
     select (case is_live_blog when 1 then 5 else 1 end )  into v_assettype from yho.yho_article
		where article_id=p_articleid;
          
     if p_versionnumber is null then
     	
          select      published_version_number
          into strict v_versionnumber
          from   	  yho.yho_article
          where  	  article_id = p_articleid;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_articlejson
     from   	  yho.yho_asset_draft
     where  	  asset_type_id  = v_assettype
     and    	  asset_id       = p_articleid
	and    	  version_number = v_versionnumber
     limit 1;
     
     select image_path
     into   v_image_path
     from 	yho.yho_image
     where image_id = (
     select asset_id
     from   yho.yho_article_asset_map
     where  article_id = p_articleid
     and is_cover = 1);
     
     -- p_articlejson := jsonb_set(p_articlejson,'{data,image_path}',v_image_path::jsonb,true);
     
     p_result := 1;
     
/*exception
	
     when others then
     	p_result := -1;*/
end;

$$;


--
