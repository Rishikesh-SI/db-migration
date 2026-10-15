-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_get_template_data(refcursor, refcursor)
-- Type: FUNCTION

-- Name: labkc_v1_get_template_data(refcursor, refcursor); Type: FUNCTION; Schema: labkc_v1_02042024; Owner: -
--

CREATE FUNCTION labkc_v1_02042024.labkc_v1_get_template_data(p_template_cursor refcursor, p_temp_comp_map_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  

declare 
v_temp_id varchar(200):=' ';
begin 

open p_template_cursor for   
select 
*
from labkc_v1.labkc_v1_template
where 
is_deleted=0
and is_active=1
;

open p_temp_comp_map_cursor for 
select * from labkc_v1.labkc_v1_template_component_map
where is_deleted=0
and is_active=1
;

-- open p_template_layout_cur for
-- select temp.*,lay.layout_html,lay.layout_name from labkc_v1.labkc_v1_template temp
-- inner join labkc_v1.labkc_v1_layout  lay on  lay.layout_id=temp.layout_id

-- order by case when parent_id is null then 0 else parent_id  end asc ,template_name 

-- ;

-- p_result:=1;
end 

  

 $$;


--
