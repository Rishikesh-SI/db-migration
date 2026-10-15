-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_get_menu_by_parent(numeric, refcursor)
-- Type: FUNCTION

-- Name: dd_get_menu_by_parent(numeric, refcursor); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_get_menu_by_parent(p_parent_id numeric, p_page_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

    DECLARE
  
    BEGIN

           
      OPEN p_page_cur FOR  
     select * from dd.dd_page
     where upfront = 1;
     --     select * from (
--          WITH RECURSIVE nodes(page_id,alias,title,parent_id) AS (
--        SELECT s1.page_id, s1.alias,s1.title, s1.parent_id,S1.page_level
--       FROM dd.dd_page_temp s1 WHERE page_id = coalesce(p_parent_id, page_id)
--      union 
--      SELECT s1.page_id, s1.alias,s1.title, s1.parent_id,S1.page_level
--      FROM dd.dd_page_temp s1 WHERE parent_id = coalesce(p_parent_id, parent_id)
--        UNION
--    SELECT s2.page_id, s2.alias,s2.title, s2.parent_id,S1.page_level
--    FROM dd.dd_page_temp s2, nodes s1 WHERE s2.parent_id = s1.page_id
--    )
--    SELECT * FROM nodes
--    )A;   
      
                                                     
END;
    

$$;


--
