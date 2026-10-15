-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_get_article_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labisp_get_article_detail(numeric, numeric); Type: FUNCTION; Schema: labisp; Owner: -
--

CREATE FUNCTION labisp.labisp_get_article_detail(p_articleid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_articlejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare
	
     v_versionnumber numeric;
     v_image_path varchar(4000);
	 v_schema_prefix text;
	 v_assettype numeric;
begin
v_schema_prefix := 'labisp';

	execute 'select (case is_live_blog when 1 then 5 else 1 end ) ,published_version_number
	 from '||v_schema_prefix||'.'||v_schema_prefix||'_article
	 where article_id='||p_articleid
	 into v_assettype,v_versionnumber;
	 
	 if p_versionnumber is not null then 
	 
	 v_versionnumber:=p_versionnumber;
	 end if;
	 
    /* if p_versionnumber is null then
     	
         execute 'select  published_version_number
                  from  '||v_schema_prefix||'.'||v_schema_prefix||'_article
                  where  article_id = '||p_articleid
                  into strict v_versionnumber ;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
	*/ 
     
         execute' select asset_data
                  from '||v_schema_prefix||'.'||v_schema_prefix||'_asset_draft
                  where asset_type_id ='||v_assettype||'
                  and  asset_id = '||p_articleid||'
	              and  version_number = '||v_versionnumber
                  into strict p_articlejson;
     
    /* execute 'select image_path
               from '||v_schema_prefix||'.'||v_schema_prefix||'_image
                where image_id = (select asset_id
                                  from  '||v_schema_prefix||'.'||v_schema_prefix||'_article_asset_map
                                  where  article_id = '||p_articleid||'
                                  and is_cover = 1)'into   v_image_path;
     */
     -- p_articlejson := jsonb_set(p_articlejson,'{data,image_path}',v_image_path::jsonb,true);
     
     p_result := 1;
     
/*exception
	
     when others then
     	p_result := -1;*/
end;

 

$$;


--
