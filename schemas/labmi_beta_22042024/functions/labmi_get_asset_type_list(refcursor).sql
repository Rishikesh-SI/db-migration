-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_get_asset_type_list(refcursor)
-- Type: FUNCTION

-- Name: labmi_get_asset_type_list(refcursor); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_get_asset_type_list(p_asset_list refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

  
begin

open p_asset_list for select * from labmi.labmi_asset_type where is_active=1 and is_deleted=0;

end 
  

 $$;


--
