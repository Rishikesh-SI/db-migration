-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_get_component_listing(numeric, numeric, numeric, numeric, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: waf_get_component_listing(numeric, numeric, numeric, numeric, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_get_component_listing(p_comp_id numeric, p_client_id numeric, p_is_responsive numeric, p_comp_type numeric, p_comp_layout_list refcursor, p_comp_lay_client_list refcursor, p_comp_lay_child refcursor, p_comp_type_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

declare
v_comp_id1 varchar(200) :=' ';
v_comp_type varchar(200):= ' ';
v_is_responsive varchar(200):=' ';
v_client_id  varchar(200):=' ';

v_comp_id numeric [];
begin 

if p_comp_id is null then 
select widget_group_id into p_comp_id from waf_master.waf_widget_group
where is_active=1
and is_published=1
and is_deleted=0
order by 1 limit 1;
end if;
 raise notice '%',p_comp_id;
/*if p_comp_type is null then 
select component_type_id into p_comp_type from waf_master.waf_component_type
where is_active=1
and is_published=1
and is_deleted=0
order by 1 limit 1;
end if;
*/

select array(
select component_id 
from waf_master.waf_widget_group_component_map
where widget_group_id=p_comp_id)
into v_comp_id ;

 raise notice '%',v_comp_id;

if p_comp_id is not null then 
v_comp_id1:=' and component_id in(select id from unnest($1) U(id))' ;
end if;

 raise notice '%',v_comp_id1;
if p_client_id is not null then 
v_client_id:=' and b.client_id='||p_client_id ;
end if;
if p_is_responsive is not null then 
v_is_responsive:=' and is_responsive='||p_is_responsive ;
end if;
if p_comp_type is not null then 
v_comp_type:=' and component_type_id='||p_comp_type;
end if;

/*open p_comp_list for
select * from waf_master.waf_component
where is_active=1
and is_published=1
and is_deleted=0;

open p_comp_type_list for
select * from waf_master.waf_component_type
where is_active=1
and is_published=1
and is_deleted=0;
*/

open p_comp_layout_list for execute '
select a.*,b.client_id from waf_master.waf_component_layout a
inner join  waf_master.waf_client_component_layout_map b on b.component_layout_id=a.component_layout_id
where a.is_active=1
and a.is_published=1
and a.is_deleted=0 '||v_client_id||v_comp_id1||v_is_responsive||v_comp_type
using v_comp_id
;

open p_comp_lay_client_list for execute '
select * from  waf_master.waf_client_component_layout_map
where component_layout_id in (
select a.component_layout_id from waf_master.waf_component_layout a
inner join  waf_master.waf_client_component_layout_map b on b.component_layout_id=a.component_layout_id
where a.is_active=1
and a.is_published=1
and a.is_deleted=0 '||v_client_id||v_comp_id1||v_is_responsive||v_comp_type||'
)order by component_layout_id,client_id'
using v_comp_id;

open p_comp_lay_child for 
select  a.component_layout_id,
a.child_component_layout_id,
b.* ,
/*b.layout_name,
b.layout_display_name,
b.component_type_id,
b.component_id  ,
*/
a.meta_info
from waf_master.waf_component_layout_dependency_map a
join waf_master.waf_component_layout b on b.component_layout_id=a.child_component_layout_id
 ;

open p_comp_type_list for execute 
'select * from waf_master.waf_component_type
where is_active=1
and is_published=1
and is_deleted=0 '|| v_comp_id1 
using v_comp_id;

end

$_$;


--
