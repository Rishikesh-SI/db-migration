-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_get_article_detail_bkp(numeric, numeric)
-- Type: FUNCTION

-- Name: labgfg_get_article_detail_bkp(numeric, numeric); Type: FUNCTION; Schema: labgfg; Owner: -
--

CREATE FUNCTION labgfg.labgfg_get_article_detail_bkp(p_articleid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_articlejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_versionnumber numeric;
     v_image_path varchar(4000);
     v_entity_role_map_id numeric;
	 v_entity_data jsonb;
	 i jsonb;
	 v_name character varying;
	 p_entityjson jsonb;
begin
	
     if p_versionnumber is null then
     	
          select      published_version_number
          into strict v_versionnumber
          from   	  labgfg.labgfg_article
          where  	  article_id = p_articleid;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_articlejson
     from   	  labgfg.labgfg_asset_draft
     where  	  asset_type_id  = 1
     and    	  asset_id       = p_articleid
	and    	  version_number = v_versionnumber;
     
     select image_path
     into   v_image_path
     from 	labgfg.labgfg_image
     where image_id = (
     select asset_id
     from   labgfg.labgfg_article_asset_map
     where  article_id = p_articleid
     and is_cover = 1);
     
	 
	 select p_articlejson->'data'->>'entitydata' into v_entity_data;
	 raise notice 'p_articlejson %',v_entity_data;
	 for i in select * from jsonb_array_elements(v_entity_data)
	 loop
	 	select i->>'entity_role_map_id'
		into v_entity_role_map_id;
		raise notice 'v_entity_role_map_id %',v_entity_role_map_id;
		
		select a.entity_display_name
		into v_name
		from labgfg.labgfg_entity_master a
		join labgfg.labgfg_entity_role_map b
		on a.entity_master_id=b.entity_master_id
		where b.entity_role_map_id =v_entity_role_map_id;
		
		raise notice 'v_name %',v_name;
		
     	v_entity_data := jsonb_set(v_entity_data,'{0,ent_disp_name}',('"'||v_name||'"'),true);
		raise notice 'v_entity_data %',v_entity_data;
	 end loop;
		
     --p_articlejson := jsonb_set(p_articlejson,'{data,image_path}',v_image_path::jsonb,true);
     
     p_result := 1;
     
/*exception
	
     when others then
     	p_result := -1;*/
end;

 $$;


--
