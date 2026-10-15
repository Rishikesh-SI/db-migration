-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_get_sub_menu(numeric, numeric[])
-- Type: FUNCTION

-- Name: labfih_get_sub_menu(numeric, numeric[]); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_get_sub_menu(p_parent_id numeric, p_template_comp_map_id numeric[]) RETURNS jsonb
    LANGUAGE sql
    AS $$
WITH RECURSIVE menu_tree AS (
    -- Anchor
    SELECT 
        a.page_id,
        a.title,
        a.menu_id,
        a.upfront,
        a.meta_info,
        a.is_active,
        a.no_action,
        a.created_by,
        a.is_deleted,
        a.mpmap_guid,
        a.updated_by,
        a.created_date,
        a.external_url,
        a.is_published,
        a.updated_date,
        a.function_info,
        a.is_opennewtab,
        a.published_date,
        a.menu_page_map_id,
        a.parent_page_id,
        a.page_level,
        a.order_number,
        p.alias,
        b.template_component_map_id
    FROM labfih.labfih_menu_page_map a
    JOIN labfih.labfih_page_template_component_menu_map b
        ON b.menu_id = a.menu_id
    JOIN labfih.labfih_page p
        ON p.page_id = a.page_id
    WHERE a.parent_page_id = p_parent_id
      AND b.template_component_map_id = ANY (p_template_comp_map_id)
      AND a.is_active=1 AND a.is_deleted=0
      AND b.is_active=1 AND b.is_deleted=0 AND b.is_published=1
      AND p.is_active=1 AND p.is_deleted=0

    UNION ALL

    -- Recursive step
    SELECT 
        a.page_id,
        a.title,
        a.menu_id,
        a.upfront,
        a.meta_info,
        a.is_active,
        a.no_action,
        a.created_by,
        a.is_deleted,
        a.mpmap_guid,
        a.updated_by,
        a.created_date,
        a.external_url,
        a.is_published,
        a.updated_date,
        a.function_info,
        a.is_opennewtab,
        a.published_date,
        a.menu_page_map_id,
        a.parent_page_id,
        a.page_level,
        a.order_number,
        p.alias,
        b.template_component_map_id
    FROM labfih.labfih_menu_page_map a
    JOIN labfih.labfih_page_template_component_menu_map b
        ON b.menu_id = a.menu_id
    JOIN labfih.labfih_page p
        ON p.page_id = a.page_id
    JOIN menu_tree mt
        ON a.parent_page_id = mt.page_id
    WHERE b.template_component_map_id = ANY (p_template_comp_map_id)
      AND a.is_active=1 AND a.is_deleted=0
      AND b.is_active=1 AND b.is_deleted=0 AND b.is_published=1
      AND p.is_active=1 AND p.is_deleted=0
),
-- Step 2: build JSON with children
menu_json AS (
    SELECT 
        mt.parent_page_id,
        jsonb_agg(
            jsonb_build_object(
                'alias', mt.alias,
                'title', mt.title,
                'menu_id', mt.menu_id,
                'page_id', mt.page_id,
                'upfront', mt.upfront,
                'is_active', mt.is_active,
                'meta_info', mt.meta_info,
                'no_action', mt.no_action,
                'created_by', mt.created_by,
                'is_deleted', mt.is_deleted,
                'mpmap_guid', mt.mpmap_guid,
                'page_level', mt.page_level,
                'updated_by', mt.updated_by,
                'created_date', mt.created_date,
                'external_url', mt.external_url,
                'is_published', mt.is_published,
                'order_number', mt.order_number,
                'updated_date', mt.updated_date,
                'function_info', mt.function_info,
                'is_opennewtab', mt.is_opennewtab,
                'parent_page_id', mt.parent_page_id,
                'published_date', mt.published_date,
                'menu_page_map_id', mt.menu_page_map_id,
                'template_component_map_id', mt.template_component_map_id
                -- recursive placeholder (will be replaced by child aggregation)
               
            )
			|| 
CASE 
    WHEN c.children IS NULL OR jsonb_array_length(c.children) = 0 
        THEN '{}'::jsonb
    ELSE jsonb_build_object('sub_menu', c.children)
END
            ORDER BY mt.order_number
        ) AS children
    FROM menu_tree mt
    LEFT JOIN LATERAL (
        SELECT jsonb_agg(row_to_json(child)) AS children
        FROM (
            SELECT *
            FROM menu_tree c
            WHERE c.parent_page_id = mt.page_id
            ORDER BY c.order_number
        ) child
    ) c ON TRUE
    GROUP BY mt.parent_page_id
)
-- Step 3: return root
SELECT children
FROM menu_json
WHERE parent_page_id = p_parent_id;

$$;


--
