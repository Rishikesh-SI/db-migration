-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_get_image_detail(numeric)
-- Type: FUNCTION

-- Name: yho_get_image_detail(numeric); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_get_image_detail(p_imageid numeric, OUT p_imagejson jsonb) RETURNS jsonb
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
                        FROM  yho.yho_asset_entity_map aem
                        join  yho.yho_entity_role_map erm
                        on erm.entity_role_map_id = aem.entity_role_map_id
                        join yho.yho_entity_master em
                        on em.entity_master_id = erm.entity_master_id
                        join yho.yho_entity_role er
                        on er.entity_role_id = erm.entity_role_id
                        join yho.yho_entity_type et
                        on et.entity_type_id = er.entity_type_id
                        join yho.yho_entity_group eg
                        on eg.entity_group_id = er.entity_group_id
                        WHERE asset_type_id = 3
                        and asset_id = p_imageid
                    ) d
                ) as entity
            from   yho.yho_image
            where  image_id = p_imageid
            ) t
            into p_imagejson;            

end; 

 $$;


--
