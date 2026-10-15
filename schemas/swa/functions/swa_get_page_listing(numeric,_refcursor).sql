-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_page_listing(numeric, refcursor)
-- Type: FUNCTION

-- Name: swa_get_page_listing(numeric, refcursor); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_page_listing(p_lag_id numeric, OUT p_result numeric, p_page_cursor refcursor) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

 
 

begin 

open p_page_cursor for 
-- select * from swa.swa_page
-- where is_published=1
-- and is_deleted=0
-- and is_active=1
-- order by case when parent_id is null then 0 else parent_id  end asc ,page_level,title ;

select  a.*,coalesce(b.show_in_web,0)show_in_web,
coalesce(b.show_in_mobile,0)show_in_mobile,
coalesce(b.is_responsive,0)is_responsive,
b.template_name from (
 WITH RECURSIVE q AS (SELECT page_id,alias,page_level ,title,parent_id,ordering,ordering as par_ord,
                      CAST(ordering As varchar(1000))ord,
                      upfront,is_published
                       FROM swa.swa_page
                      WHERE coalesce(parent_id,0)=0 -- parent_id is null
                     and page_id in (select asset_id from swa.swa_asset_entity_map
                      where asset_type_id=11
                      and entity_role_map_id=p_lag_id)
                       and  is_deleted=0
                         and is_active=1
                      and is_custom_menu=0
                      UNION ALL
                     SELECT m.page_id,m.alias,m.page_level,m.title,m.parent_id,m.ordering,q.ordering as par_ord,
                      CAST(ord || '->' || m.ordering As varchar(1000)) As ord,                    
                      m.upfront,m.is_published
                       FROM swa.swa_page m
                       JOIN q ON q.page_id = m.parent_id::numeric
                     where m.page_id in (select asset_id from swa.swa_asset_entity_map
                      where asset_type_id=11
                      and entity_role_map_id=p_lag_id)
                     and  is_deleted=0
                         and is_active=1
                       and is_custom_menu=0
                         )
        SELECT page_id,alias,page_level,ord,title,parent_id,ordering,par_ord,
    upfront,is_published FROM q 
 -- ORDER BY upfront desc,ord 
   )a 
left join (select 
ct.page_id,pt.template_name,
(case when (pt.template_html is null or pt.template_html='') then 0 else 1 end ) as show_in_web ,
(case when (pt.mobile_html is null or pt.mobile_html='')  then 0 else 1 end) as show_in_mobile,
pt.is_responsive
from  swa.swa_template ct
join  swa.swa_template pt
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
