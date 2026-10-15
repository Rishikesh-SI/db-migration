-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_get_category_list_21082019_79e2(character varying[], refcursor)
-- Type: FUNCTION

-- Name: labhsl_get_category_list_21082019_79e2(character varying[], refcursor); Type: FUNCTION; Schema: labhsl; Owner: -
--

CREATE FUNCTION labhsl.labhsl_get_category_list_21082019_79e2(p_category character varying[], p_entity_master_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

    declare
  
    begin
           
      open p_entity_master_cur for  
                    select 
                    erm.entity_role_map_id,
                    em.entity_name,
                    em.entity_display_name,
                    ec.category_name                
                    from labhsl.labhsl_entity_role_map erm
                    inner join  labhsl.labhsl_entity_master em on em.entity_master_id=erm.entity_master_id 
                    inner join labhsl.labhsl_entity_category ec on ec.entity_role_id=erm.entity_role_id
                    where erm.entity_role_id in (select entity_role_id from labhsl.labhsl_entity_category c1
                                                  inner join  unnest(p_category) m(category_name)
                                                   on m.category_name=c1.category_name
                                                  where c1.is_active=1
                                                  and c1.is_deleted=0
                                                  and c1.is_published=1
                                                  )
                    and erm.is_active=1 
                    order by 1          ;                            
end;
    

 $$;


--
