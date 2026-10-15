-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: labtmum_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labtmum_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labtmum; Owner: -
--

CREATE FUNCTION labtmum.labtmum_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labtmum.labtmum_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
