-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: tmmimg_upd_get_asset_type_list(refcursor); Type: FUNCTION; Schema: tmmimg_upd; Owner: -
--

CREATE FUNCTION tmmimg_upd.tmmimg_upd_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from tmmimg_upd.tmmimg_upd_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
