-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_get_menu_by_parent_r(numeric, numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labbsc_get_menu_by_parent_r(numeric, numeric, refcursor, refcursor); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_get_menu_by_parent_r(p_parent_id numeric, p_language_id numeric, p_page_cur refcursor, p_page_ent_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

    DECLARE
  			v_sysdate timestamp:=current_timestamp at time zone 'utc';
            v_arr_page_id numeric[];
            v_page_asset_type_id numeric:=11;
            v_level_one_par numeric;
            v_lang_filter_query varchar(1000) := ' ';
    BEGIN
    
    if p_language_id is not null then
		v_lang_filter_query := ' and page_id in(select asset_id
        										from labbsc.labbsc_asset_entity_map
                                                where asset_type_id = 11
                                                and entity_role_map_id in($1)) ';
    end if;
    
     
     if p_parent_id is null then
     execute 'select ARRAY(  
     select page_id
     from labbsc.labbsc_page
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
          
          
          SELECT page_id 
          into v_level_one_par
          FROM 
          (
          WITH    RECURSIVE Ancestors AS
                  (
                  SELECT page_id, parent_id, 0 AS level
                  FROM    labbsc.labbsc_PAGE
                  WHERE   page_id = p_parent_id
                  UNION ALL
                  SELECT  q.page_id, q.parent_id, m.level+1 AS level
                  FROM     labbsc.labbsc_PAGE q
                  JOIN    Ancestors m
                  ON      q.page_id = m.parent_id
                  )
          SELECT  page_id,row_number() over(order by level desc) rno
          FROM    Ancestors
              
              ) pa
          where rno=2;

          execute'SELECT ARRAY(
        select page_id 
        from (
                WITH RECURSIVE nodes(page_id,alias,title,parent_id) AS 
                (
                SELECT s1.page_id, s1.alias,s1.title, s1.page_id parent_id,S1.page_level
                FROM labbsc.labbsc_page s1 WHERE page_id = '||coalesce(v_level_one_par,-1)||'
				 -- and  alias like replace(alias,''^'',''^^'')
                union 
                SELECT s1.page_id, s1.alias,s1.title, s1.page_id,S1.page_level
                FROM labbsc.labbsc_page s1   
                join nodes p on s1.parent_id = p.parent_id 
                and s1.is_published=1
                     and s1.visible = 1
                and s1.is_deleted=0
                and s1.is_active=1
				and alias not like''(.*)/(.*)/(.*)/(attachment)/(.*)''
                and s1.scheduled_publish<='''||v_sysdate||'''
				 and alias like replace(alias,''^'',''^^'')
                )
        SELECT * FROM labbsc.labbsc_page where page_id in (select page_id from nodes)'
        ||v_lang_filter_query||
        '
            )A
            )'
        into v_arr_page_id
        using p_language_id;   
        
     end if;
     
     OPEN p_page_cur FOR  
   --  select * from labbsc.labbsc_page
    -- where  page_id in (select page_id from UNNEST(v_arr_page_id) page_id) 
	-- and alias like replace(alias,'^','^^')
	-- order by ordering;
     
     select * from (
select * from labbsc.labbsc_page
     where  page_id in (select page_id from UNNEST(v_arr_page_id) page_id) 
	 and alias like replace(alias,'^','^^')
	
    union all 
select b. page_id,
LTRIM(external_url,'/')external_url,
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
from labbsc.labbsc_menu_page_map a
join labbsc.labbsc_page b on a.page_id=b.page_id
where  a.is_active=1 and b.is_custom_menu=1 and external_url is not null and menu_id <>8 
)a order by ordering;
     
     OPEN p_page_ent_cur FOR 
     select *,labbsc.labbsc_get_entity_known_as(entity_role_map_id) known_as  from labbsc.labbsc_asset_entity_map
     where asset_type_id = v_page_asset_type_id
     and asset_id in (select page_id from UNNEST(v_arr_page_id) page_id);
     
     
    
      
                                                     
END;
    

$_$;


--
