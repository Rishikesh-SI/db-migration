-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_ruf
-- Object: labecn_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labecn_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labecn_ruf; Owner: -
--

CREATE FUNCTION labecn_ruf.labecn_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labecn.labecn_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
