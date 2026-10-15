-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_get_page_data(numeric, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: khi_get_page_data(numeric, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_get_page_data(p_page_id numeric, p_page_cursor refcursor, p_template_cur refcursor, p_seo_cursor refcursor, p_entity_cursor refcursor, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

 

 

declare
v_asset_type_id numeric :=11;
begin 
if p_page_id is not null then 

open p_page_cursor for 
select * from khi.khi_page
where page_id=p_page_id;

open p_template_cur for 
select (case when tp.is_deleted=1 then null else tp.template_id end )template_id ,
tc.page_id,
(case when tp.is_deleted=1 then null else tp.template_name end )template_name,
tc.parent_id,
tm.is_master,
tc.is_published,
tm.template_name as master_template_name,
tm.is_published as master_is_published
from khi.khi_template tc
join khi.khi_template tp
on tc.parent_id=tp.template_id  
join khi.khi_template tm
on tp.layout_id=tm.template_id
where tc.page_id=p_page_id
and tc.is_active=1
and tc.is_deleted=0
-- and tp.is_deleted=
-- and is_published=1 
and tm.is_master=1 ;

open p_seo_cursor for
select * from khi.khi_seo_data
where asset_id=p_page_id
and asset_type_id=v_asset_type_id;

open p_entity_cursor for
select  a.entity_role_map_id,
       c.entity_name,f.group_name, e.entity_type_name,
       a.is_linkable,
       a.is_visible,
       a.priority ,
       a.is_required,
       a.is_active,
       a.is_deleted
       from khi.khi_asset_entity_map a
 join khi.khi_entity_role_map b on b.entity_role_map_id=a.entity_role_map_id
 join khi.khi_entity_master c on c.entity_master_id=b.entity_master_id
 join khi.khi_entity_role d on d.entity_role_id=b.entity_role_id
 join  khi.khi_entity_type e on e.entity_type_id=d.entity_type_id 
 join khi.khi_entity_group f on f.entity_group_id=d.entity_group_id
 where a.asset_type_id=v_asset_type_id
 and a.asset_id=p_page_id
;

end if;

end

 

 

$$;


--
