-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_get_article_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labsaw_get_article_detail(numeric, numeric); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_get_article_detail(p_articleid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_articlejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
 

declare
	
     v_versionnumber numeric;
     v_image_path varchar(4000);
     
begin
	
     if p_versionnumber is null then
     	
          select      published_version_number
          into strict v_versionnumber
          from   	  labsaw.labsaw_article
          where  	  article_id = p_articleid;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_articlejson
     from   	  labsaw.labsaw_asset_draft
     where  	  asset_type_id  = 1
     and    	  asset_id       = p_articleid
	and    	  version_number = v_versionnumber;
     
     select image_path
     into   v_image_path
     from 	labsaw.labsaw_image
     where image_id = (
     select asset_id
     from   labsaw.labsaw_article_asset_map
     where  article_id = p_articleid
     and is_cover = 1);
     
     -- p_articlejson := jsonb_set(p_articlejson,'{data,image_path}',v_image_path::jsonb,true);
     
     p_result := 1;
     
exception

     when others then
     	p_result := -1;
        INSERT INTO siwaf.siwaf_sp_logs(schema_name, sp_name, error_code, error_message, created_date)
            VALUES ('labsaw', 'labsaw_get_article_detail',SQLSTATE,SQLERRM,current_timestamp);
end;

 
$$;


--
