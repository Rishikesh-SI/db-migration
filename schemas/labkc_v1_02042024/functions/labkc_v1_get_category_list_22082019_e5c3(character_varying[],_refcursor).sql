-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_get_category_list_22082019_e5c3(character varying[], refcursor)
-- Type: FUNCTION

-- Name: labkc_v1_get_category_list_22082019_e5c3(character varying[], refcursor); Type: FUNCTION; Schema: labkc_v1_02042024; Owner: -
--

CREATE FUNCTION labkc_v1_02042024.labkc_v1_get_category_list_22082019_e5c3(p_category character varying[], p_entity_master_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
 

    declare
  
    begin
           
      open p_entity_master_cur for  
                    select 
                    erm.entity_role_map_id,
                    em.entity_name,
                    em.entity_display_name,
                    ec.category_name      ,
					em.canonical_url
                    from labkc_v1.labkc_v1_entity_role_map erm
                    inner join  labkc_v1.labkc_v1_entity_master em on em.entity_master_id=erm.entity_master_id 
                    inner join labkc_v1.labkc_v1_entity_category ec on ec.entity_role_id=erm.entity_role_id
                    where erm.entity_role_id in (select entity_role_id from labkc_v1.labkc_v1_entity_category c1
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
