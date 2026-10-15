-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_get_article_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: abp_get_article_detail(numeric, numeric); Type: FUNCTION; Schema: abpp; Owner: -
--

CREATE FUNCTION abpp.abp_get_article_detail(p_articleid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_articlejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
     v_versionnumber numeric;
     v_image_path varchar(4000);
     v_assettype numeric;
     v_published_date_ist timestamp;
     
begin
	
     
     select (case is_live_blog when 1 then 5 else 1 end )  into v_assettype from abp.abp_article
		where article_id=p_articleid;
          
     if p_versionnumber is null then
     	
          select      published_version_number
          into strict v_versionnumber
          from   	  abp.abp_article
          where  	  article_id = p_articleid;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_articlejson
     from   	  abp.abp_asset_draft
     where  	  asset_type_id  = v_assettype
     and    	  asset_id       = p_articleid
	and    	  version_number = v_versionnumber
     limit 1;
     
     select image_path
     into   v_image_path
     from 	abp.abp_image
     where image_id = (
     select asset_id
     from   abp.abp_article_asset_map
     where  article_id = p_articleid
     and is_cover = 1);
     
     -- p_articlejson := jsonb_set(p_articlejson,'{data,image_path}',v_image_path::jsonb,true);
     
     select published_date+'5.5 hours'::interval into v_published_date_ist
	from abp.abp_article where article_id = p_articleid;
	
     p_articlejson := jsonb_set(p_articlejson,'{data,published_date_ist}',('"'||v_published_date_ist||'"')::text::jsonb,true);
     
     p_result := 1;
     
/*exception
	
     when others then
     	p_result := -1;*/
end;

$$;


--
