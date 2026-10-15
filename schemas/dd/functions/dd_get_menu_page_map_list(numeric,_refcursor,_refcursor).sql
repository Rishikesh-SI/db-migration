-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_get_menu_page_map_list(numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: dd_get_menu_page_map_list(numeric, refcursor, refcursor); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_get_menu_page_map_list(p_menu_id numeric, p_cursor refcursor, p_entity_cursor refcursor, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

 declare v_asset_type_id numeric := 22 ;
 

BEGIN
open p_cursor for 
/*select * from (
WITH RECURSIVE q AS
  (
  SELECT menu_page_map_id,
         menu_id,
         page_id, 
         title, 
         page_level ,
         parent_page_id,
         order_number, 
         order_number AS par_ord,
         CAST(order_number AS VARCHAR(1000))ord,
         upfront,
         is_published,
          no_action,
          external_url,
          function_info,
          meta_info,
          is_deleted as menu_page_deleted
  FROM dd.dd_menu_page_map
  WHERE coalesce(parent_page_id,0) = 0 
      -- parent_page_id IS NULL      
  and menu_id           = p_menu_id
  and is_published=1
  and is_deleted=0
  and is_active=1
  
  UNION ALL
  
  SELECT m.menu_page_map_id,
         m.menu_id,
         m.page_id,
         m.title,
         m.page_level,
         m.parent_page_id,
         m.order_number,
         q.order_number AS par_ord,
         CAST(ord|| '->'|| m.order_number AS VARCHAR(1000)) AS ord,
         m.upfront,
         m.is_published,
         m.no_action,
          m.external_url,
         m.function_info,
  m.meta_info,
  m.is_deleted as menu_page_deleted
  FROM dd.dd_menu_page_map m
  JOIN q
  ON q.page_id   = m.parent_page_id
  WHERE m.menu_id=p_menu_id
  and m.is_published=1
  and m.is_deleted=0
  and is_active=1
  )
SELECT 
  menu_page_map_id,
  pm.menu_type,
  q.menu_id,
  pm.menu_name,
  pm.display_name,
  pm.updated_by,
  pm.is_active,
  pm.is_deleted,
  pm.is_published,
  page_id,
  page_level,
  ord,
  title,
  parent_page_id,
  order_number,
  par_ord,
  upfront,
  q.is_published,
  no_action,
  external_url,
  function_info,
  meta_info,
  menu_page_deleted,pm.is_dynamic,pm.max_level, pm.include_child_pages

FROM q
left join dd.dd_menu pm on q.menu_id=pm.menu_id
ORDER BY upfront DESC,
  ord  )tab;
  */
  
  select 
 a.menu_page_map_id,
pm.menu_type,
 pm.menu_id,
 pm.menu_name,
  pm.display_name,
 pm.updated_by,
 pm.is_active,
  pm.is_deleted,
  pm.is_published,
   a.page_id,
   a.page_level,
   a.ord,
   a.title,
   a.parent_page_id,
  a. order_number,
   a.par_ord,
   a.upfront,
  a.is_published,
   a.no_action,
   a.external_url,
   a.function_info,
   a.meta_info,
   a.menu_page_deleted,
   pm.is_dynamic,pm.max_level, 
   pm.include_child_pages  ,
   c.is_custom_menu,
   pm.language_id
from dd.dd_menu pm
left join (WITH RECURSIVE q AS
  (
  SELECT menu_page_map_id,
         menu_id,
         page_id, 
         title, 
         page_level ,
         parent_page_id,
         order_number, 
         order_number AS par_ord,
         CAST(order_number AS VARCHAR(1000))ord,
         upfront,
         is_published,
          no_action,
          external_url,
          function_info,
          meta_info,
          is_deleted as menu_page_deleted
  FROM dd.dd_menu_page_map
  WHERE coalesce(parent_page_id,0) = 0 
  -- parent_page_id IS NULL      
  and menu_id           = p_menu_id
  and is_published=1
  and is_deleted=0
  and is_active=1
  
  UNION ALL
  
  SELECT m.menu_page_map_id,
         m.menu_id,
         m.page_id,
         m.title,
         m.page_level,
         m.parent_page_id,
         m.order_number,
         q.order_number AS par_ord,
         CAST(ord|| '->'|| m.order_number AS VARCHAR(1000)) AS ord,
         m.upfront,
         m.is_published,
         m.no_action,
          m.external_url,
         m.function_info,
  m.meta_info,
  m.is_deleted as menu_page_deleted
  FROM dd.dd_menu_page_map m
  JOIN q
  ON q.page_id   = m.parent_page_id
  WHERE m.menu_id=p_menu_id
  and m.is_published=1
  and m.is_deleted=0
  and is_active=1
  )
SELECT 
  menu_page_map_id,
 -- pm.menu_type,
  q.menu_id,
 -- pm.menu_name,
 -- pm.display_name,
 -- pm.updated_by,
 -- pm.is_active,
  --pm.is_deleted,
 -- pm.is_published,
  page_id,
  page_level,
  ord,
  title,
  parent_page_id,
  order_number,
  par_ord,
  upfront,
  q.is_published,
  no_action,
  external_url,
  function_info,
  meta_info,
  menu_page_deleted 
           -- ,pm.is_dynamic,pm.max_level, pm.include_child_pages

FROM q) a on a.menu_id=pm.menu_id
left join dd.dd_page c on c.page_id=a.page_id 
where pm.menu_id=p_menu_id
;
  
  p_result :=1;
  
  open p_entity_cursor for 
  select  a.entity_role_map_id,
       c.entity_name,f.group_name, e.entity_type_name,
       a.is_linkable,
       a.is_visible,
       a.priority ,
       a.is_required
       from dd.dd_asset_entity_map a
 join dd.dd_entity_role_map b on b.entity_role_map_id=a.entity_role_map_id
 join dd.dd_entity_master c on c.entity_master_id=b.entity_master_id
 join dd.dd_entity_role d on d.entity_role_id=b.entity_role_id
 join  dd.dd_entity_type e on e.entity_type_id=d.entity_type_id 
 join dd.dd_entity_group f on f.entity_group_id=d.entity_group_id
 where a.asset_type_id = v_asset_type_id
 and a.asset_id = p_menu_id 
    and a.is_active = 1
    and a.is_deleted = 0 ;
    
  
  exception when others then p_result:= -1;
  open p_cursor for 
  select -1 as ret;
end
 
 

$$;


--
