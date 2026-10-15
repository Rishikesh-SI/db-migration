-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labw88_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labw88; Owner: -
--

CREATE FUNCTION labw88.labw88_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labw88.labw88_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
