-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: lablsg_v1_get_asset_type_list(refcursor); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from lablsg_v1.lablsg_v1_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
