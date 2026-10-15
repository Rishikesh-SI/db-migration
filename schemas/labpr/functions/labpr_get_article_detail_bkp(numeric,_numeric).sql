-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_get_article_detail_bkp(numeric, numeric)
-- Type: FUNCTION

-- Name: labpr_get_article_detail_bkp(numeric, numeric); Type: FUNCTION; Schema: labpr; Owner: -
--

CREATE FUNCTION labpr.labpr_get_article_detail_bkp(p_articleid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_articlejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
 

declare
	
     v_versionnumber numeric;
     v_image_path varchar(4000);
	  v_imagejsonarr jsonb[];
	  v_publishedversionnumber numeric := 0;
     
begin
	
     if p_versionnumber is null then
     	
          select      published_version_number
          into strict v_versionnumber
          from   	  labpr.labpr_article
          where  	  article_id = p_articleid;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_articlejson
     from   	  labpr.labpr_asset_draft
     where  	  asset_type_id  = 1
     and    	  asset_id       = p_articleid
	and    	  version_number = v_versionnumber;
     
     select image_path
     into   v_image_path
     from 	labpr.labpr_image
     where image_id = (
     select asset_id
     from   labpr.labpr_article_asset_map
     where  article_id = p_articleid
     and is_cover = 1);
     
     -- p_articlejson := jsonb_set(p_articlejson,'{data,image_path}',v_image_path::jsonb,true);
	 
	 if v_versionnumber = v_publishedversionnumber then
	 	 execute 'select array(
     select row_to_json(row) jsonrow
     from
     (
     select asset_order as order_number, i.image_id, i.image_file_name,i.title_alias as title, i.image_path ,is_cover, al.entity_data as entitydata,
         i.image_caption, i.image_desc,
		aam.is_active, aam.is_deleted is_delete,
		i.copyright_text, aam.phototypeid
     from   labpr.labpr_album_asset_map aam
     join   labpr.labpr_image i	 
     on     i.image_id = aam.asset_id
     and    aam.asset_type_id = 3
	 join   labpr.labpr_asset_list al on 
	 al.asset_id = i.image_id and 
	 al.asset_type_id = 2
	left join   labpr.labpr_asset_entity_map aem
         on aem.asset_id = i.image_id
         and aem.asset_type_id = 3
     where  album_id = '|| p_articleid
         ||v_isdeletedquery||
         'group by asset_order, i.image_id, i.image_file_name, i.image_path ,is_cover, i.image_caption, i.image_desc, aam.is_active, aam.is_deleted, i.copyright_text, aam.phototypeid,al.entity_data
         order by order_number desc) as row)'
         into v_imagejsonarr;
     
	else
         
         execute 'with imagedata(t_asset_data, t_json)
        as(select asset_data, (asset_data->''data''->''images'')::json
        from   labpr.labpr_asset_draft as ad
        where  asset_type_id = 2
       and    asset_id = '|| p_articleid ||
     ' and    version_number = '||v_versionnumber||')
    select array(select row_to_json(row) jsonrow
             from (select asset_order::numeric as order_number, 
         			jd.image_id::numeric, i.image_file_name, i.image_path, is_cover::numeric, 
         			jd.image_alt image_caption,
         			jd.image_desc,
					jd.phototypeid,
					jd.is_active::numeric, 
					jd.is_deleted::numeric is_delete,
         			jd.title, al.entity_data  entitydata
                   		  -- i.copyright_text
         				
                   from   (select obj->''data''->>''order_number'' asset_order,
         					obj->''data''->>''image_id'' image_id,
         					obj->''data''->>''is_cover'' is_cover
         					, t_asset_data, obj->''data''->>''is_active'' is_active,
         					obj->''data''->>''is_delete'' is_deleted,
         					obj->''data''->>''title'' title,
         					obj->''data''->>''image_copyright'' image_copyright,
                            obj->''data''->>''image_desc'' image_desc,
                           obj->''data''->>''image_alt'' image_alt,
                          obj->''data''->>''order_number'' order_number,
						  obj->''data''->>''phototypeid'' phototypeid
                           from   imagedata id, json_array_elements(id.t_json#>''{}'') obj) jd
                           join   labpr.labpr_image i
                           on     i.image_id = jd.image_id::numeric
						   join labpr.labpr_asset_list al on al.asset_id = jd.image_id::numeric
						   ) row)'
into   v_imagejsonarr;

     end if;
     p_result := 1;
     
/*exception
	
     when others then
     	p_result := -1;*/
end;

 
$$;


--
