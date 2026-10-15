-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_migration_listing()
-- Type: FUNCTION

-- Name: labisp_migration_listing(); Type: FUNCTION; Schema: labisp; Owner: -
--

CREATE FUNCTION labisp.labisp_migration_listing(OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	i record ;
	v_json jsonb;
	v_counter numeric := 0;
	begin
	for i in (select * from labisp.labisp_asset_list
			 where is_published=1 and asset_type_id in (1,5) and web_listing_json is null)
	loop
	select p_json into v_json from labisp._get_web_list_json('labisp',i.asset_type_id,i.asset_id);
	update labisp.labisp_asset_list
	set web_listing_json = v_json
	where asset_id = i.asset_id and asset_type_id= i.asset_type_id;
	
	v_counter := v_counter + 1;
	
	end loop ;
	
	p_result := v_counter;

end ;
$$;


--
