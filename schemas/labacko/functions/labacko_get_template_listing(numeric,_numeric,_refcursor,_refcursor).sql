-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_get_template_listing(numeric, numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labacko_get_template_listing(numeric, numeric, refcursor, refcursor); Type: FUNCTION; Schema: labacko; Owner: -
--

CREATE FUNCTION labacko.labacko_get_template_listing(p_flag numeric, p_template_id numeric, p_template_cursor refcursor, p_layout_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  

declare 
v_temp_id varchar(200):=' ';
v_is_inherited varchar(200):=' ';
begin 

if p_template_id is not null then 
 
   v_temp_id :='and template_id = '||p_template_id ;

end if; 

if p_flag=2 then 
v_is_inherited='and is_inherited=0';
end if;

open p_template_cursor for  execute' 
select 
(case when (template_html is null or template_html='''') then 0 else 1 end ) as template_html ,
(case when (mobile_html is null or mobile_html='''')  then 0 else 1 end) as mobile_html,
template_id,
template_name,
template_desc,
layout_id,
parent_id,
is_inherited,
is_master,
is_responsive

from  labacko.labacko_template
where 
is_deleted=0
and is_active=1 '|| v_temp_id ||v_is_inherited ||' 
 

order by template_id'
-- case when parent_id is null then 0 else parent_id  end asc ,template_name
-- '
;

-- open p_template_layout_cur for
-- select temp.*,lay.layout_html,lay.layout_name from labacko.labacko_template temp
-- inner join labacko.labacko_layout  lay on  lay.layout_id=temp.layout_id

-- order by case when parent_id is null then 0 else parent_id  end asc ,template_name 

-- ;

-- p_result:=1;
open p_layout_cursor for 
select layout_id,layout_name,layout_desc,is_master,master_template_id,image_file_name,image_path from labacko.labacko_layout
where is_published=1
and is_deleted=0;

end 

  

 $$;


--
