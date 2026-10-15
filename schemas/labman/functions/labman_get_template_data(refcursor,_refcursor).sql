-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labman
-- Object: labman_get_template_data(refcursor, refcursor)
-- Type: FUNCTION

-- Name: labman_get_template_data(refcursor, refcursor); Type: FUNCTION; Schema: labman; Owner: -
--

CREATE FUNCTION labman.labman_get_template_data(p_template_cursor refcursor, p_temp_comp_map_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  

declare 
v_temp_id varchar(200):=' ';
begin 

open p_template_cursor for   
select 
*
from labman.labman_template
where 
is_deleted=0
and is_active=1
;

open p_temp_comp_map_cursor for 
select * from labman.labman_template_component_map
where is_deleted=0
and is_active=1
;

-- open p_template_layout_cur for
-- select temp.*,lay.layout_html,lay.layout_name from labman.labman_template temp
-- inner join labman.labman_layout  lay on  lay.layout_id=temp.layout_id

-- order by case when parent_id is null then 0 else parent_id  end asc ,template_name 

-- ;

-- p_result:=1;
end 

  

 $$;


--
