-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_get_category_list(character varying[], refcursor)
-- Type: FUNCTION

-- Name: u17wc_get_category_list(character varying[], refcursor); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_get_category_list(p_category character varying[], p_entity_master_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

     

    DECLARE
  
    BEGIN
           
      OPEN p_entity_master_cur FOR  
                    SELECT 
                    ERM.ENTITY_ROLE_MAP_ID,                    
                    em.entity_name,
                    em.entity_display_name,
                    ec.category_name ,
                    em.canonical_url,
                    (case when em.entity_name = 'English' and ec.category_name = 'Language' then 1 else 2 end) srno -- added for english language should be 1st
                    FROM u17wc.u17wc_ENTITY_ROLE_MAP ERM
                    INNER JOIN  u17wc.u17wc_ENTITY_MASTER EM on EM.entity_master_id=erm.entity_master_id 
                    inner join u17wc.u17wc_ENTITY_CATEGORY ec on ec.entity_role_id=ERM.ENTITY_ROLE_ID
                    where ERM.ENTITY_ROLE_ID in (SELECT ENTITY_ROLE_ID FROM u17wc.u17wc_ENTITY_CATEGORY c1
                                                 INNER JOIN  UNNEST(p_category) M(CATEGORY_NAME)
                                                 ON M.CATEGORY_NAME=C1.CATEGORY_NAME
                                                 WHERE C1.IS_active=1
                                                 and c1.is_deleted=0
                                                 and c1.is_published=1
                                                )
                    and ERM.IS_active=1
                    and EM.is_active=1
                    order by srno, 1   ;                            
END;
    

     

$$;


--
