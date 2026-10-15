-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: labgt_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labgt_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labgt_bkp; Owner: -
--

CREATE FUNCTION labgt_bkp.labgt_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labgt.labgt_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
