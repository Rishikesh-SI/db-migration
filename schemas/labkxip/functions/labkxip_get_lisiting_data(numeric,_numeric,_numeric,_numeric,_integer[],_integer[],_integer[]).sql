-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_get_lisiting_data(numeric, numeric, numeric, numeric, integer[], integer[], integer[])
-- Type: FUNCTION

-- Name: labkxip_get_lisiting_data(numeric, numeric, numeric, numeric, integer[], integer[], integer[]); Type: FUNCTION; Schema: labkxip; Owner: -
--

CREATE FUNCTION labkxip.labkxip_get_lisiting_data(p_page_id numeric, p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_entityrole_mapid integer[], p_any_entityrole_mapid integer[], p_exclude_ent_id integer[], OUT p_assetcount numeric, OUT p_assetjson1 jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
--do
--$$
 

declare
v_variable character varying;
v_tcmap_id jsonb;
v_widget_data jsonb;	
v_template_component_map_id numeric;	
v_widget_array jsonb;
v_asset_map jsonb;
v_asset_id1 numeric;
v_asset_id numeric[];
v_asset_array jsonb;
    v_anyentityrolemapidquery varchar(4000) := ' ';
	v_excentityrolemapidquery varchar(4000):=' ';
	v_limit smallint := case p_pagenumber when 1 then p_page1_size else p_itemnumber end;
	v_offset smallint := case p_pagenumber when 1 then 0 else (p_page1_size + (((p_pagenumber - 1) * p_itemnumber) - p_itemnumber)) end;
v_sysdate timestamp;
v_json jsonb;
    v_searchkeyword varchar(4000) := '';
    v_entitysearchquery varchar(4000) := ' ';
	v_item_array jsonb;
	v_item_data jsonb;
	v_app_asset_id numeric;
begin

     v_sysdate:= current_timestamp at time zone 'utc';
     v_anyentityrolemapidquery := ' and tagged_entity && $4';
	v_excentityrolemapidquery := ' and not tagged_entity && $3';
                v_entitysearchquery := ' and ( to_tsvector( sl.asset_title) @@@ to_tsquery( '''||v_searchkeyword||''') 
                                        or   to_tsvector( sl.short_desc) @@@ to_tsquery( '''||v_searchkeyword||'''))';

 
 select json_agg(x) from (select template_component_map_id from
							labkxip.labkxip_template_component_data
							where page_id=p_page_id and component_id=7)x
							into v_tcmap_id;
	raise notice 'v_tcmap_id %',v_tcmap_id;						

select widget_data into v_widget_data from labkxip.labkxip_template_component_data
where component_id=9 and page_id=p_page_id;

select v_widget_data->'data'->>'asset_map' into v_asset_map;
	--raise notice 'v_asset_map %',v_asset_map;		
	for v_widget_array in select * from jsonb_array_elements(v_asset_map)
	loop
		select v_widget_array->>'asset_id'
		into v_asset_id1;
	v_asset_id:=array_append(v_asset_id,v_asset_id1);
				
	end loop;

 	raise notice 'v_asset_id %',v_asset_id;		

	for v_asset_array in select * from jsonb_array_elements(v_tcmap_id)
	loop
		select v_asset_array->>'template_component_map_id'
		into v_template_component_map_id;
		
 	raise notice 'v_template_component_map_id %',v_template_component_map_id;	
	
 select p_assetjson from labkxip.labkxip_get_exc_asset_listing_r(1, p_itemnumber,p_page1_size, 
								 p_entityrole_mapid, p_any_entityrole_mapid, null, null, 
								 p_exclude_ent_id,v_asset_id)
								into p_assetjson1;

		raise notice 'p_assetjson1 %',p_assetjson1;		
		
	 select p_assetjson1->>'items' into v_item_array;
		
		for v_item_data in select * from jsonb_array_elements(v_item_array)
		loop
			select v_item_data->>'asset_id' into v_app_asset_id;
			
		v_asset_id:=array_append(v_asset_id,v_app_asset_id);
		
		raise notice 'v_app_asset_id %',v_app_asset_id;		

	
		end loop;
		update labkxip.labkxip_template_component_data
		set widget_data=p_assetjson1
		where template_component_map_id=v_template_component_map_id
		and page_id=p_page_id;
	end loop;
	
end;
$_$;


--
