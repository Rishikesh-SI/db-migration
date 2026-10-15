-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: labmi_v1_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labmi_v1_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labmi_v1_bkp; Owner: -
--

CREATE FUNCTION labmi_v1_bkp.labmi_v1_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labmi_v1.labmi_v1_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
