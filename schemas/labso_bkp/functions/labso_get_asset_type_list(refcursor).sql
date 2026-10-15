-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labso_bkp
-- Object: labso_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labso_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labso_bkp; Owner: -
--

CREATE FUNCTION labso_bkp.labso_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labso.labso_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
