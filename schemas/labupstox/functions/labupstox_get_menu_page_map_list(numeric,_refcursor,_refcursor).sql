-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_get_menu_page_map_list(numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labupstox_get_menu_page_map_list(numeric, refcursor, refcursor); Type: FUNCTION; Schema: labupstox; Owner: -
--

CREATE FUNCTION labupstox.labupstox_get_menu_page_map_list(p_menu_id numeric, p_cursor refcursor, p_entity_cursor refcursor, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

 declare v_asset_type_id numeric := 22 ;
 

begin
open p_cursor for 
/*select * from (
with recursive q as
  (
  select menu_page_map_id,
         menu_id,
         page_id, 
         title, 
         page_level ,
         parent_page_id,
         order_number, 
         order_number as par_ord,
         cast(order_number as varchar(1000))ord,
         upfront,
         is_published,
          no_action,
          external_url,
          function_info,
          meta_info,
          is_deleted as menu_page_deleted
  from labupstox.labupstox_menu_page_map
  where coalesce(parent_page_id,0) = 0 
      -- parent_page_id is null      
  and menu_id           = p_menu_id
  and is_published=1
  and is_deleted=0
  and is_active=1
  
  union all
  
  select m.menu_page_map_id,
         m.menu_id,
         m.page_id,
         m.title,
         m.page_level,
         m.parent_page_id,
         m.order_number,
         q.order_number as par_ord,
         cast(ord|| '->'|| m.order_number as varchar(1000)) as ord,
         m.upfront,
         m.is_published,
         m.no_action,
          m.external_url,
         m.function_info,
  m.meta_info,
  m.is_deleted as menu_page_deleted
  from labupstox.labupstox_menu_page_map m
  join q
  on q.page_id   = m.parent_page_id
  where m.menu_id=p_menu_id
  and m.is_published=1
  and m.is_deleted=0
  and is_active=1
  )
select 
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

from q
left join labupstox.labupstox_menu pm on q.menu_id=pm.menu_id
order by upfront desc,
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
from labupstox.labupstox_menu pm
left join (with recursive q as
  (
  select menu_page_map_id,
         menu_id,
         page_id, 
         title, 
         page_level ,
         parent_page_id,
         order_number, 
         order_number as par_ord,
         cast(order_number as varchar(1000))ord,
         upfront,
         is_published,
          no_action,
          external_url,
          function_info,
          meta_info,
          is_deleted as menu_page_deleted
  from labupstox.labupstox_menu_page_map
  where coalesce(parent_page_id,0) = 0 
  -- parent_page_id is null      
  and menu_id           = p_menu_id
  and is_published=1
  and is_deleted=0
  and is_active=1
  
  union all
  
  select m.menu_page_map_id,
         m.menu_id,
         m.page_id,
         m.title,
         m.page_level,
         m.parent_page_id,
         m.order_number,
         q.order_number as par_ord,
         cast(ord|| '->'|| m.order_number as varchar(1000)) as ord,
         m.upfront,
         m.is_published,
         m.no_action,
          m.external_url,
         m.function_info,
  m.meta_info,
  m.is_deleted as menu_page_deleted
  from labupstox.labupstox_menu_page_map m
  join q
  on q.page_id   = m.parent_page_id
  where m.menu_id=p_menu_id
  and m.is_published=1
  and m.is_deleted=0
  and is_active=1
  )
select 
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

from q) a on a.menu_id=pm.menu_id
left join labupstox.labupstox_page c on c.page_id=a.page_id 
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
       from labupstox.labupstox_asset_entity_map a
 join labupstox.labupstox_entity_role_map b on b.entity_role_map_id=a.entity_role_map_id
 join labupstox.labupstox_entity_master c on c.entity_master_id=b.entity_master_id
 join labupstox.labupstox_entity_role d on d.entity_role_id=b.entity_role_id
 join  labupstox.labupstox_entity_type e on e.entity_type_id=d.entity_type_id 
 join labupstox.labupstox_entity_group f on f.entity_group_id=d.entity_group_id
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
