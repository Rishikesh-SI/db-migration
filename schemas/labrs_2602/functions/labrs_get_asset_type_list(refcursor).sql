-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs_2602
-- Object: labrs_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labrs_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labrs_2602; Owner: -
--

CREATE FUNCTION labrs_2602.labrs_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labrs.labrs_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
