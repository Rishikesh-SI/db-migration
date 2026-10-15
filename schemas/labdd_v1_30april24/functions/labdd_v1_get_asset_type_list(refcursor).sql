-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: labdd_v1_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labdd_v1_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labdd_v1_30april24; Owner: -
--

CREATE FUNCTION labdd_v1_30april24.labdd_v1_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labdd_v1.labdd_v1_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
