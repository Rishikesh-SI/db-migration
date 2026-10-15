-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr_beta
-- Object: labtkr_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labtkr_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labtkr_beta; Owner: -
--

CREATE FUNCTION labtkr_beta.labtkr_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labtkr.labtkr_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
