-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_menu_by_parent_r(numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: swa_get_menu_by_parent_r(numeric, refcursor, refcursor); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_menu_by_parent_r(p_parent_id numeric, p_page_cur refcursor, p_page_ent_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

    DECLARE
  			v_sysdate timestamp:=current_timestamp at time zone 'utc';
            v_arr_page_id numeric[];
            v_page_asset_type_id numeric:=11;
            v_level_one_par numeric;
    BEGIN
    
     if p_parent_id is null then
     select ARRAY(  
     select page_id
     from swa.swa_page
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
                  FROM    SWA.SWA_PAGE
                  WHERE   page_id = p_parent_id
                  UNION ALL
                  SELECT  q.page_id, q.parent_id, m.level+1 AS level
                  FROM     SWA.SWA_PAGE q
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
                FROM swa.swa_page s1 WHERE page_id = v_level_one_par
                union 
                SELECT s1.page_id, s1.alias,s1.title, s1.page_id,S1.page_level
                FROM swa.swa_page s1   
                join nodes p on s1.parent_id = p.parent_id 
                and s1.is_published=1
                and s1.is_deleted=0
                and s1.is_active=1
                and s1.scheduled_publish<=v_sysdate
                )
        SELECT * FROM swa.swa_page where page_id in (select page_id from nodes)
            )A
            )
        into v_arr_page_id;   
        
     end if;
           
     OPEN p_page_cur FOR  
     select * from swa.swa_page
     where  page_id in (select page_id from UNNEST(v_arr_page_id) page_id) order by ordering;
     
     OPEN p_page_ent_cur FOR 
     select *,swa.swa_get_entity_known_as(entity_role_map_id) known_as  from swa.swa_asset_entity_map
     where asset_type_id = v_page_asset_type_id
     and asset_id in (select page_id from UNNEST(v_arr_page_id) page_id);
     
     
    
      
                                                     
END;
    

$$;


--
