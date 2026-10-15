-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_filter_details(refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_filter_details(refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_filter_details(p_cur_filter_type refcursor, p_cur_filter_values refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
begin
  open p_cur_filter_type for
    select  zeven_filter_masterid ,filter_name, display_name ,filter_tablename ,is_active, is_deleted, 
            is_searchable ,filter_level, parent_filter_id, is_leaf_node, created_date, updated_date,is_venue_lvl_filter
    from    zeven.zeven_filter_master
    where   coalesce(parent_filter_id,0) = 0 and coalesce(filter_level,0) = 0 and is_leaf_node = 0
    order by zeven_filter_masterid;
    
  open p_cur_filter_values for
    select  fm.zeven_filter_masterid ,fm.filter_name, fm.display_name ,fm.filter_tablename ,fm.is_active, fm.is_deleted, 
            fm.is_searchable ,fm.filter_level, fm.parent_filter_id,fmp.filter_name as filter_name_parent, fmp.display_name as display_name_parent ,fm.is_leaf_node, 
            fm.created_date, fm.updated_date,fmp.is_venue_lvl_filter
    from    zeven.zeven_filter_master fm
    left join zeven.zeven_filter_master fmp
          on  fmp.zeven_filter_masterid = fm.parent_filter_id
    where   fm.is_leaf_node = 1
    order by fm.zeven_filter_masterid;
    
   
end;
$$;


--
