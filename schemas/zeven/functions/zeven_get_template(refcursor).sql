-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_template(refcursor)
-- Type: FUNCTION

-- Name: zeven_get_template(refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_template(p_template refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
 

 

DECLARE
  			
BEGIN
	
    OPEN p_template FOR  
    with
    component
    as
    (
    select T.template_id,  count(CM.component_id) component_count 
    from zeven.zeven_template T
    inner join zeven.zeven_template_component_map CM
    on (T.template_id = CM.template_id)
    where T.is_published = 1
    group by T.template_id
    ),
    page
    as
    (	
        select C.template_id , string_agg(P.title,',') page_details
        from zeven.zeven_template T
        inner join zeven.zeven_page P 
        on (T.page_id = P.page_id)
        inner join component C 
        on (T.parent_id = C.template_id)
        where T.is_active = 1
        and T.is_deleted = 0 
        and P.is_active = 1
        and P.is_deleted = 0
        group by  C.template_id
     )
      select T1.*, C.component_count , P.page_details
      from zeven.zeven_template T1
      inner join component C 
      on (T1.template_id = C.template_id)
      left join page P 
      on (T1.template_id = P.template_id)
      where T1.is_published = 1 
      and T1.is_deleted = 0 
        and T1.is_active = 1
     ; 
    
                                               
END;
    

 

 
$$;


--
