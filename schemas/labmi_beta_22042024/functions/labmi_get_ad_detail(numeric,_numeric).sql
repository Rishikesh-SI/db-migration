-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_get_ad_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labmi_get_ad_detail(numeric, numeric); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_get_ad_detail(p_ad_id numeric, p_version_number numeric, OUT p_ad_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare

	v_ad_asset_type_id numeric := 16;
   -- p_ad_id numeric :=221;
begin
if p_version_number is null then 
select published_version_number into p_version_number
from labmi.labmi_advertisement
where ad_id=p_ad_id;

end if;
     select asset_data into p_ad_json
	 from labmi.labmi_asset_draft 
     where asset_id = p_ad_id and asset_type_id = v_ad_asset_type_id and version_number = p_version_number;

exception

     when others then 
     	p_ad_json := '{"data":{}}'::jsonb;

end;

$$;


--
