-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labbsc_dev_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labbsc_dev.labbsc_dev_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
