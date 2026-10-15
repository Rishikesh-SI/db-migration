-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_get_menu_by_parent_r(numeric, numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labdms_get_menu_by_parent_r(numeric, numeric, refcursor, refcursor); Type: FUNCTION; Schema: labdms; Owner: -
--

CREATE FUNCTION labdms.labdms_get_menu_by_parent_r(p_parent_id numeric, p_language_id numeric, p_page_cur refcursor, p_page_ent_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

    declare
  			v_sysdate timestamp:=current_timestamp at time zone 'utc';
            v_arr_page_id numeric[];
            v_page_asset_type_id numeric:=11;
            v_level_one_par numeric;
            v_lang_filter_query varchar(1000) := ' ';
    begin
    
    if p_language_id is not null then
		v_lang_filter_query := ' and page_id in(select asset_id
        										from labdms.labdms_asset_entity_map
                                                where asset_type_id = 11
                                                and entity_role_map_id in($1)) ';
    end if;
    
     
     if p_parent_id is null then
     execute 'select array(  
     select page_id
     from labdms.labdms_page
     where upfront = 1
      and visible = 1
     and is_published=1
     and is_deleted=0
     and is_active=1
     and scheduled_publish<='''||v_sysdate||''' '
     ||v_lang_filter_query||
     ')'
     into v_arr_page_id
     using p_language_id;
     
     else
          
          
          select page_id 
          into v_level_one_par
          from 
          (
          with    recursive ancestors as
                  (
                  select page_id, parent_id, 0 as level
                  from    labdms.labdms_page
                  where   page_id = p_parent_id
                  union all
                  select  q.page_id, q.parent_id, m.level+1 as level
                  from     labdms.labdms_page q
                  join    ancestors m
                  on      q.page_id = m.parent_id
                  )
          select  page_id,row_number() over(order by level desc) rno
          from    ancestors
              
              ) pa
          where rno=2;

          execute'select array(
        select page_id 
        from (
                with recursive nodes(page_id,alias,title,parent_id) as 
                (
                select s1.page_id, s1.alias,s1.title, s1.page_id parent_id,s1.page_level
                from labdms.labdms_page s1 where page_id = '||coalesce(v_level_one_par,-1)||'
				 -- and  alias like replace(alias,''^'',''^^'')
                union 
                select s1.page_id, s1.alias,s1.title, s1.page_id,s1.page_level
                from labdms.labdms_page s1   
                join nodes p on s1.parent_id = p.parent_id 
                and s1.is_published=1
                     and s1.visible = 1
                and s1.is_deleted=0
                and s1.is_active=1
				and alias not like''(.*)/(.*)/(.*)/(attachment)/(.*)''
                and s1.scheduled_publish<='''||v_sysdate||'''
				 and alias like replace(alias,''^'',''^^'')
                )
        select * from labdms.labdms_page where page_id in (select page_id from nodes)'
        ||v_lang_filter_query||
        '
            )a
            )'
        into v_arr_page_id
        using p_language_id;   
        
     end if;
     
     open p_page_cur for  
   --  select * from labdms.labdms_page
    -- where  page_id in (select page_id from unnest(v_arr_page_id) page_id) 
	-- and alias like replace(alias,'^','^^')
	-- order by ordering;
     
     select * from (
select * from labdms.labdms_page
     where  page_id in (select page_id from unnest(v_arr_page_id) page_id) 
	 and alias like replace(alias,'^','^^')
	
    union all 
select b. page_id,
ltrim(external_url,'/')external_url,
b.title,
b.page_level,
b.upfront,
b.upfront_app,
b.upfront_mobile,
b.is_wrapper,
b.parent_id,
b.visible,
b.visible_app,
b.visible_mobile,
b.scheduled_publish,
b.scheduled_unpublish,
b.ordering,
b.title_mobile,
b.title_app,
b.is_redirect,
b.published_version_number,
b.created_date,
b.updated_date,
b.created_by,
b.updated_by,
b.is_active,
b.is_deleted,
b.is_published,
b.page_guid,
b.asset_type_id,
b.breadcrumbs,
b.is_custom_menu,
b.is_amp
from labdms.labdms_menu_page_map a
join labdms.labdms_page b on a.page_id=b.page_id
where  a.is_active=1 and b.is_custom_menu=1 and external_url is not null and menu_id <>8 
)a order by ordering;
     
     open p_page_ent_cur for 
     select *,labdms.labdms_get_entity_known_as(entity_role_map_id) known_as  from labdms.labdms_asset_entity_map
     where asset_type_id = v_page_asset_type_id
     and asset_id in (select page_id from unnest(v_arr_page_id) page_id);
     
     
    
      
                                                     
end;
    

$_$;


--
