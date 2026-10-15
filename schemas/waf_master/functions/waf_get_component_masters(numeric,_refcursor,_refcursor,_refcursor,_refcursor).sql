-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_get_component_masters(numeric, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: waf_get_component_masters(numeric, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_get_component_masters(p_group_id numeric, p_comp_list refcursor, p_comp_type_list refcursor, p_comp_group_list refcursor, p_group_comp_map refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
v_group_id varchar(200) :=' ';
begin 

if p_group_id is not null
then 
v_group_id:='and widget_group_id='|| p_group_id;
end if;

open p_comp_list for
select * from waf_master.waf_component
where is_active=1
and is_published=1
and is_deleted=0;

open p_comp_type_list for
select * from waf_master.waf_component_type
where is_active=1
and is_published=1
and is_deleted=0;

open  p_comp_group_list   for
select * from waf_master.waf_widget_group
where is_active=1
and is_deleted=0
and is_published=1;

open  p_group_comp_map   for execute '
select * from waf_master.waf_widget_group_component_map
where is_active=1
and is_deleted=0
and is_published=1 '||v_group_id

;

end

$$;


--
