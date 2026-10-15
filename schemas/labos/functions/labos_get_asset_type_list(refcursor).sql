-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labos_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labos; Owner: -
--

CREATE FUNCTION labos.labos_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labos.labos_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
