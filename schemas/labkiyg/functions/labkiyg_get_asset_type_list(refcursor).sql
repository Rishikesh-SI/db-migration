-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkiyg
-- Object: labkiyg_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labkiyg_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labkiyg; Owner: -
--

CREATE FUNCTION labkiyg.labkiyg_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labkiyg.labkiyg_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
