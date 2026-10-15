-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_image_detail(numeric)
-- Type: FUNCTION

-- Name: labbsc_dev_get_image_detail(numeric); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_image_detail(p_imageid numeric, OUT p_imagejson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

declare

begin
        
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
                        select em.entity_display_name as entity_name, aem.priority, aem.is_linkable, aem.is_visible, aem.entity_role_map_id,
                        		 er.entity_role_id, er.entity_type_id, et.entity_type_name, er.entity_group_id, eg.group_name
                        from  labbsc_dev.labbsc_dev_asset_entity_map aem
                        join  labbsc_dev.labbsc_dev_entity_role_map erm
                        on erm.entity_role_map_id = aem.entity_role_map_id
                        join labbsc_dev.labbsc_dev_entity_master em
                        on em.entity_master_id = erm.entity_master_id
                        join labbsc_dev.labbsc_dev_entity_role er
                        on er.entity_role_id = erm.entity_role_id
                        join labbsc_dev.labbsc_dev_entity_type et
                        on et.entity_type_id = er.entity_type_id
                        join labbsc_dev.labbsc_dev_entity_group eg
                        on eg.entity_group_id = er.entity_group_id
                        where asset_type_id = 3
                        and asset_id = p_imageid
                    ) d
                ) as entity
            from   labbsc_dev.labbsc_dev_image
            where  image_id = p_imageid
            ) t
            into p_imagejson;            

end; 

 $$;


--
