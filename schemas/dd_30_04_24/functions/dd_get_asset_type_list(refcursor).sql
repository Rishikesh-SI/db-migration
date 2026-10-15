-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: dd_get_asset_type_list(refcursor); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

  
begin

open p_asset_list for select * from dd.dd_asset_type where is_active=1 and is_deleted=0;

end 
  

$$;


--
