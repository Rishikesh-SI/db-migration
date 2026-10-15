-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_get_image_detail(numeric)
-- Type: FUNCTION

-- Name: abp_get_image_detail(numeric); Type: FUNCTION; Schema: abpp; Owner: -
--

CREATE FUNCTION abpp.abp_get_image_detail(p_imageid numeric, OUT p_imagejson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare

BEGIN
        
            select row_to_json(t)
            from (
            select 
                content_source_id,
                copyright_text,
                image_caption,
                image_desc,
                image_path,
                image_file_name,
                title_alias,
                is_published,
                (
                    select array_to_json(array_agg(row_to_json(d)))
            		from
                    (
                        SELECT em.entity_display_name as entity_name, aem.priority, aem.is_linkable, aem.is_visible, aem.entity_role_map_id,
                        		 er.entity_role_id, er.entity_type_id, et.entity_type_name, er.entity_group_id, eg.group_name
                        FROM  abp.abp_asset_entity_map aem
                        join  abp.abp_entity_role_map erm
                        on erm.entity_role_map_id = aem.entity_role_map_id
                        join abp.abp_entity_master em
                        on em.entity_master_id = erm.entity_master_id
                        join abp.abp_entity_role er
                        on er.entity_role_id = erm.entity_role_id
                        join abp.abp_entity_type et
                        on et.entity_type_id = er.entity_type_id
                        join abp.abp_entity_group eg
                        on eg.entity_group_id = er.entity_group_id
                        WHERE asset_type_id = 3
                        and asset_id = p_imageid
                    ) d
                ) as entity
            from   abp.abp_image
            where  image_id = p_imageid
            ) t
            into p_imagejson;            

end; 

$$;


--
