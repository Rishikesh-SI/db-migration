-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labgrl_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labgrl; Owner: -
--

CREATE FUNCTION labgrl.labgrl_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labgrl.labgrl_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
