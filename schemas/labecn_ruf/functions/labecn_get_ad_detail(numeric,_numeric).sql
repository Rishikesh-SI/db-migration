-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_ruf
-- Object: labecn_get_ad_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labecn_get_ad_detail(numeric, numeric); Type: FUNCTION; Schema: labecn_ruf; Owner: -
--

CREATE FUNCTION labecn_ruf.labecn_get_ad_detail(p_ad_id numeric, p_version_number numeric, OUT p_ad_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare

	v_ad_asset_type_id numeric := 16;

begin

     select asset_data into p_ad_json
	 from labecn.labecn_asset_draft where asset_id = p_ad_id and asset_type_id = v_ad_asset_type_id and version_number = p_version_number;

exception

     when others then 
     	p_ad_json := '{"data":{}}'::jsonb;

end;

$$;


--
