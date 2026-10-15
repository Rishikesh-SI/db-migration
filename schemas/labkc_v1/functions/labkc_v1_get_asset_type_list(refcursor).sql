-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labkc_v1_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labkc_v1.labkc_v1_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
