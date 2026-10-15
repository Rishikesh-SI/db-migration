-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_get_menu_by_parent(numeric, refcursor)
-- Type: FUNCTION

-- Name: labrstg_get_menu_by_parent(numeric, refcursor); Type: FUNCTION; Schema: labrstg; Owner: -
--

CREATE FUNCTION labrstg.labrstg_get_menu_by_parent(p_parent_id numeric, p_page_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

    declare
  
    begin

           
      open p_page_cur for  
     select * from labrstg.labrstg_page
     where upfront = 1;
     --     select * from (
--          with recursive nodes(page_id,alias,title,parent_id) as (
--        select s1.page_id, s1.alias,s1.title, s1.parent_id,s1.page_level
--       from labrstg.labrstg_page_temp s1 where page_id = coalesce(p_parent_id, page_id)
--      union 
--      select s1.page_id, s1.alias,s1.title, s1.parent_id,s1.page_level
--      from labrstg.labrstg_page_temp s1 where parent_id = coalesce(p_parent_id, parent_id)
--        union
--    select s2.page_id, s2.alias,s2.title, s2.parent_id,s1.page_level
--    from labrstg.labrstg_page_temp s2, nodes s1 where s2.parent_id = s1.page_id
--    )
--    select * from nodes
--    )a;   
      
                                                     
end;
    

 $$;


--
