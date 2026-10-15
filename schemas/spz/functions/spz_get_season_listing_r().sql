-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_get_season_listing_r()
-- Type: FUNCTION

-- Name: spz_get_season_listing_r(); Type: FUNCTION; Schema: spz; Owner: -
--

CREATE FUNCTION spz.spz_get_season_listing_r(OUT p_seasonjson jsonb, OUT p_count numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare
	
     
     
begin
    
    select '{"season" :' || array_to_json(array_agg(ab)) || '}' , max(count1) +1
    into  p_seasonjson,  p_count
    from 
    (
        
	select count(1) over () count1, rm.entity_role_map_id, m.entity_name, M.entity_display_name, M.canonical_url 
        from spz.spz_entity_master M
        inner join spz.spz_entity_role_map rm 
        on (M.entity_master_id = rm.entity_master_id)
        inner join spz.spz_entity_role r 
        on (rm.entity_role_id = r.entity_role_id)
        inner join spz.spz_entity_type t
        on (r.entity_type_id = t.entity_type_id)
        where t.entity_type_name = 'Season'
        and M.is_active = 1 
        and M.is_deleted = 0 
        and rm.is_active = 1 
    
    union 
    
    select  null, null , 'All Season' entity_name , 'All Season' entity_display_name, null  canonical_url
    order by  entity_name
    )ab	;
     
     
     
end;

 

$$;


--
