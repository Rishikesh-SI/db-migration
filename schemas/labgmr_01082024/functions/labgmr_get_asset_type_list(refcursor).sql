-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: labgmr_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labgmr_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labgmr_01082024; Owner: -
--

CREATE FUNCTION labgmr_01082024.labgmr_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labgmr.labgmr_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
