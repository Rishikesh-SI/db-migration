-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: labal_nassr_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labal_nassr_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labal_nassr; Owner: -
--

CREATE FUNCTION labal_nassr.labal_nassr_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labal_nassr.labal_nassr_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
