-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_get_menu_by_parent_r_20180711_bak(numeric, numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: abp_get_menu_by_parent_r_20180711_bak(numeric, numeric, refcursor, refcursor); Type: FUNCTION; Schema: abpp; Owner: -
--

CREATE FUNCTION abpp.abp_get_menu_by_parent_r_20180711_bak(p_parent_id numeric, p_language_id numeric, p_page_cur refcursor, p_page_ent_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

    DECLARE
  			v_sysdate timestamp:=current_timestamp at time zone 'utc';
            v_arr_page_id numeric[];
            v_page_asset_type_id numeric:=11;
            v_level_one_par numeric;
            v_lang_filter_query varchar(1000) := ' ';
            v_parent_id numeric;
            v_rno numeric;
    BEGIN
    
    if p_language_id is not null then
		v_lang_filter_query := ' and page_id in(select asset_id
        										from abp.abp_asset_entity_map
                                                where asset_type_id = 11
                                                and entity_role_map_id in($1)) ';
    end if;
    
     /*if p_parent_id is null then
     select ARRAY(  
     select page_id
     from abp.abp_page
     where upfront = 1
     and is_published=1
     and is_deleted=0
     and is_active=1
     and scheduled_publish<=v_sysdate)
     
     into v_arr_page_id;
     
     else
          
          
          SELECT page_id 
          into v_level_one_par
          FROM 
          (
          WITH    RECURSIVE Ancestors AS
                  (
                  SELECT page_id, parent_id, 0 AS level
                  FROM    abp.abp_PAGE
                  WHERE   page_id = p_parent_id
                  UNION ALL
                  SELECT  q.page_id, q.parent_id, m.level+1 AS level
                  FROM     abp.abp_PAGE q
                  JOIN    Ancestors m
                  ON      q.page_id = m.parent_id
                  )
          SELECT  page_id,row_number() over(order by level desc) rno
          FROM    Ancestors
              
              ) pa
          where rno=2;

          SELECT ARRAY(
        select page_id 
        from (
                WITH RECURSIVE nodes(page_id,alias,title,parent_id) AS 
                (
                SELECT s1.page_id, s1.alias,s1.title, s1.page_id parent_id,S1.page_level
                FROM abp.abp_page s1 WHERE page_id = v_level_one_par
                union 
                SELECT s1.page_id, s1.alias,s1.title, s1.page_id,S1.page_level
                FROM abp.abp_page s1   
                join nodes p on s1.parent_id = p.parent_id 
                and s1.is_published=1
                and s1.is_deleted=0
                and s1.is_active=1
                and s1.scheduled_publish<=v_sysdate
                )
        SELECT * FROM abp.abp_page where page_id in (select page_id from nodes)
            )A
            )
        into v_arr_page_id;   
        
     end if;*/
     
     if p_parent_id is null then
     execute 'select ARRAY(  
     select page_id
     from abp.abp_page
     where upfront = 1
     and is_published=1
     and is_deleted=0
     and is_active=1
     and alias not in (''amp'', ''push-test'') and alias not like ''http%''
     and scheduled_publish<='''||v_sysdate||''' '
     ||v_lang_filter_query||
     ')'
     into v_arr_page_id
     using p_language_id;
     
     else
          
          select parent_id
          into v_parent_id
          from abp.abp_page
          where page_id = p_parent_id;
          
          if v_parent_id is null then
          	v_rno = 1;
          else
          	v_rno = 2;
          end if;
          
          SELECT page_id 
          into v_level_one_par
          FROM 
          (
          WITH    RECURSIVE Ancestors AS
                  (
                  SELECT page_id, parent_id, 0 AS level
                  FROM    abp.abp_PAGE
                  WHERE   page_id = p_parent_id
                  and alias not in ('amp', 'push-test') and alias not like 'http%'   
                  UNION ALL
                  SELECT  q.page_id, q.parent_id, m.level+1 AS level
                  FROM     abp.abp_PAGE q
                  JOIN    Ancestors m
                  ON      q.page_id = m.parent_id
                  where   q.alias not in ('amp', 'push-test') and q.alias not like 'http%'     
                  )
          SELECT  page_id,row_number() over(order by level desc) rno
          FROM    Ancestors
              
              ) pa
          where rno=v_rno;

          execute'SELECT ARRAY(
        select page_id 
        from (
                WITH RECURSIVE nodes(page_id,alias,title,parent_id) AS 
                (
                SELECT s1.page_id, s1.alias,s1.title, s1.page_id parent_id,S1.page_level
                FROM abp.abp_page s1 WHERE page_id = '||coalesce(v_level_one_par,-1)||'
                and alias not in (''amp'', ''push-test'') and alias not like ''http%''
                union 
                SELECT s1.page_id, s1.alias,s1.title, s1.page_id,S1.page_level
                FROM abp.abp_page s1   
                join nodes p on s1.parent_id = p.parent_id 
                and s1.is_published=1
                and s1.is_deleted=0
                and s1.is_active=1
                and s1.alias not in (''amp'', ''push-test'') and s1.alias not like ''http%''
                and s1.scheduled_publish<='''||v_sysdate||'''
                )
        SELECT * FROM abp.abp_page where page_id in (select page_id from nodes)'
        ||v_lang_filter_query||
        '
            )A
            )'
        into v_arr_page_id
        using p_language_id;   
        
     end if;
     
     OPEN p_page_cur FOR  
     select * from abp.abp_page
     where  page_id in (select page_id from UNNEST(v_arr_page_id) page_id) order by ordering;
     
     OPEN p_page_ent_cur FOR 
     select *,abp.abp_get_entity_known_as(entity_role_map_id) known_as  from abp.abp_asset_entity_map
     where asset_type_id = v_page_asset_type_id
     and asset_id in (select page_id from UNNEST(v_arr_page_id) page_id);
     
     
    
      
                                                     
END;
    

$_$;


--
