-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: labkkr_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labkkr_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labkkr_30012024; Owner: -
--

CREATE FUNCTION labkkr_30012024.labkkr_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labkkr.labkkr_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
