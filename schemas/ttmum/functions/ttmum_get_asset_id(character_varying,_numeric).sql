-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ttmum_get_asset_id(character varying, numeric)
-- Type: FUNCTION

-- Name: ttmum_get_asset_id(character varying, numeric); Type: FUNCTION; Schema: ttmum; Owner: -
--

CREATE FUNCTION ttmum.ttmum_get_asset_id(p_titlealias character varying, p_assettypeid numeric, OUT p_assetid numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
begin
	select asset_id into strict  p_assetid from ttmum.ttmum_asset_list where lower(title_alias) = lower(p_titlealias) and asset_type_id = p_assettypeid;
exception
	when no_data_found then
    	p_assetid := -1;
end;
$$;


--
