-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: labpc_get_menu_listing(refcursor, refcursor)
-- Type: FUNCTION

-- Name: labpc_get_menu_listing(refcursor, refcursor); Type: FUNCTION; Schema: labpc; Owner: -
--

CREATE FUNCTION labpc.labpc_get_menu_listing(p_menu_cursor refcursor, p_page_menu_map_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

 
 

begin
open p_menu_cursor for 
select menu.menu_id,menu.menu_name,menu.display_name,menu.menu_type, count(tcm.menu_id) assign_pages
from labpc.labpc_menu menu
left join labpc.labpc_page_template_component_menu_map tcm 
on tcm.menu_id=menu.menu_id and tcm.is_active=1
where menu.is_active=1
and menu.is_published=1
and menu.is_deleted=0
-- and tcm.is_active=1
group by menu.menu_id,menu.menu_name,menu.display_name;

open p_page_menu_map_cursor for
select tcm.template_component_map_id,tcm.component_id,tcm.title,
t.page_id,ptcm.page_template_component_menu_map_id,ptcm.menu_id,ptcm.is_published,
(case when ptcm.menu_id is not null then 1 else 0 end) as is_checked ,
t.template_id, t.template_name, p.title as page_name
from labpc.labpc_template_component_map tcm
join labpc.labpc_template t
on tcm.template_id= t.template_id -- t.parent_id
left join labpc.labpc_page  p 
on (t.page_id = p.page_id)
left join  labpc.labpc_page_template_component_menu_map ptcm
on tcm.template_component_map_id = ptcm.template_component_map_id
and ptcm.is_active=1
and ptcm.is_deleted=0
and t.page_id=ptcm.page_id
-- and ptcm.is_active=1
-- and ptcm.is_deleted=0 
where tcm.component_id in (41)
and t.is_active=1
and t.is_deleted=0
 and tcm.is_active=1  -- added by purushottam 
 and tcm.is_deleted=0 -- added by purushottam 
order by tcm.template_component_map_id;

end

 
 

 $$;


--
