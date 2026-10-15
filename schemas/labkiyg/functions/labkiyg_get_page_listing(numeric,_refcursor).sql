-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiyg
-- Object: labkiyg_get_page_listing(numeric, refcursor)
-- Type: FUNCTION

-- Name: labkiyg_get_page_listing(numeric, refcursor); Type: FUNCTION; Schema: labkiyg; Owner: -
--

CREATE FUNCTION labkiyg.labkiyg_get_page_listing(p_lag_id numeric, OUT p_result numeric, p_page_cursor refcursor) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

 
 

begin 

open p_page_cursor for 
-- select * from labkiyg.labkiyg_page
-- where is_published=1
-- and is_deleted=0
-- and is_active=1
-- order by case when parent_id is null then 0 else parent_id  end asc ,page_level,title ;

select  a.*,coalesce(b.show_in_web,0)show_in_web,
coalesce(b.show_in_mobile,0)show_in_mobile,
coalesce(b.is_responsive,0)is_responsive,
b.template_name from (
 with recursive q as (select page_id,alias,page_level ,title,parent_id,ordering,ordering as par_ord,
                      cast(ordering as varchar(1000))ord,
                      upfront,is_published
                       from labkiyg.labkiyg_page
                      where coalesce(parent_id,0)=0 -- parent_id is null
                     and page_id in (select asset_id from labkiyg.labkiyg_asset_entity_map
                      where asset_type_id=11
                      and entity_role_map_id=p_lag_id)
                       and  is_deleted=0
                         and is_active=1
                      and is_custom_menu=0
                      union all
                     select m.page_id,m.alias,m.page_level,m.title,m.parent_id,m.ordering,q.ordering as par_ord,
                      cast(ord || '->' || m.ordering as varchar(1000)) as ord,                    
                      m.upfront,m.is_published
                       from labkiyg.labkiyg_page m
                       join q on q.page_id = m.parent_id::numeric
                     where m.page_id in (select asset_id from labkiyg.labkiyg_asset_entity_map
                      where asset_type_id=11
                      and entity_role_map_id=p_lag_id)
                     and  is_deleted=0
                         and is_active=1
                       and is_custom_menu=0
                         )
        select page_id,alias,page_level,ord,title,parent_id,ordering,par_ord,
    upfront,is_published from q 
 -- order by upfront desc,ord 
   )a 
left join (select 
ct.page_id,pt.template_name,
(case when (pt.template_html is null or pt.template_html='') then 0 else 1 end ) as show_in_web ,
(case when (pt.mobile_html is null or pt.mobile_html='')  then 0 else 1 end) as show_in_mobile,
pt.is_responsive
from  labkiyg.labkiyg_template ct
join  labkiyg.labkiyg_template pt
on    ct.parent_id=pt.template_id
where 
ct.is_deleted=0
and ct.is_active=1
and ct.is_published=1
-- and ct.is_inherited=1 
          ) b on b.page_id=a.page_id 

 order by  a.upfront desc,a.ord ;
p_result:=1;
end 

 
 

 $$;


--
