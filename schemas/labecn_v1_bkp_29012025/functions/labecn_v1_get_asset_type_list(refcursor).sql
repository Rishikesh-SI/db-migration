-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: labecn_v1_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labecn_v1_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labecn_v1_bkp_29012025; Owner: -
--

CREATE FUNCTION labecn_v1_bkp_29012025.labecn_v1_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labecn_v1.labecn_v1_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
