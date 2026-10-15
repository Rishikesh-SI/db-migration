-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_get_category_list_21082019_e2d2(character varying[], refcursor)
-- Type: FUNCTION

-- Name: stn_get_category_list_21082019_e2d2(character varying[], refcursor); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_get_category_list_21082019_e2d2(p_category character varying[], p_entity_master_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

    DECLARE
  
    BEGIN
           
      OPEN p_entity_master_cur FOR  
                    SELECT 
                    ERM.ENTITY_ROLE_MAP_ID,
                    em.entity_name,
                    em.entity_display_name,
                    ec.category_name                
                    FROM stn.stn_ENTITY_ROLE_MAP ERM
                    INNER JOIN  stn.stn_ENTITY_MASTER EM on EM.entity_master_id=erm.entity_master_id 
                    inner join stn.stn_ENTITY_CATEGORY ec on ec.entity_role_id=ERM.ENTITY_ROLE_ID
                    where ERM.ENTITY_ROLE_ID in (SELECT ENTITY_ROLE_ID FROM stn.stn_ENTITY_CATEGORY c1
                                                  INNER JOIN  UNNEST(p_category) M(CATEGORY_NAME)
                                                   ON M.CATEGORY_NAME=C1.CATEGORY_NAME
                                                  WHERE C1.IS_active=1
                                                  and c1.is_deleted=0
                                                  and c1.is_published=1
                                                  )
                    and ERM.IS_active=1
                    and EM.is_active=1
                    order by 1          ;                            
END;
    

$$;


--
