-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: labupw_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labupw_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labupw; Owner: -
--

CREATE FUNCTION labupw.labupw_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labupw.labupw_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
