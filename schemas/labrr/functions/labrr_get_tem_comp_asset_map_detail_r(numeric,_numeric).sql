-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_tem_comp_asset_map_detail_r(numeric, numeric)
-- Type: FUNCTION

-- Name: labrr_get_tem_comp_asset_map_detail_r(numeric, numeric); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_tem_comp_asset_map_detail_r(p_asset_id numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_assetmapjson jsonb, OUT p_title jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare
     v_asset_type_id numeric :=8;
     v_versionnumber numeric;
     v_image_path varchar(4000);
    
     
begin
	
     if p_versionnumber is null then

          select     max(published_version_number)     into strict v_versionnumber
          from   	  labRR.labRR_template_component_asset_map
          where  	  template_component_map_id = p_asset_id;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	distinct  a.asset_data
     into strict p_assetmapjson
     from   	  labRR.labRR_asset_draft a
     inner join labRR.labRR_template_component_asset_map  b on b.template_component_map_id=a.asset_id
     where  	  a.asset_type_id  = v_asset_type_id
     and    	  a.asset_id       = p_asset_id
	  and    	  a.version_number = v_versionnumber
       and b.is_published=1 ;
    
     
     
      -- select title into p_title
          -- from   labRR.labRR_template_component_map
          -- where  template_component_map_id = p_asset_id;
          
          
              select array_to_json(array_agg(a)) into p_title from (
               select tca.asset_id,tca.asset_type_id,al.title_alias from swa.swa_template_component_asset_map tca
              left join swa.swa_asset_list al
             on tca.asset_id =  al.asset_id
              and tca.asset_type_id =  al.asset_type_id
               where template_component_map_id=p_asset_id)a;
          
          
     -- p_articlejson := jsonb_set(p_articlejson,'{data,image_path}',v_image_path::jsonb,true);
     
     p_result := 1;
     
 exception
	
     when others then
    	p_result := -1;
end;

 $$;


--
