-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_get_recommended_content_r(jsonb)
-- Type: FUNCTION

-- Name: labdms_get_recommended_content_r(jsonb); Type: FUNCTION; Schema: labdms; Owner: -
--

CREATE FUNCTION labdms.labdms_get_recommended_content_r(p_input_json jsonb, OUT p_asset_count numeric, OUT p_asset_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
-- select * from labdms.labdms_get_recommended_content_r(
-- 	'{"user_guid":"",
-- 	"guest_guid":"95885569-5a81-4261-b0b4-5c3baef260c1-1001202006031315",
-- 	"asset_id":null,
-- 	"asset_type_id":null,
-- 	"count":4,
-- 	"days":10}'-- <p_input_json jsonb>, 
-- )
declare
	
	v_user_guid character varying(500);
	v_guest_guid character varying(500);
	v_asset_id numeric;
	v_asset_type_id numeric;
	v_count numeric;
	v_days numeric;
	v_tagged_entity numeric[];
	v_entity_count numeric;
	v_filter_timestamp timestamp;
	v_user_asset_list_id_arr numeric[];
	v_asset_list_id_arr numeric[];
	v_asset_count numeric;
	v_required_count numeric;
	v_asset_list_id_arr_more numeric[];
	
begin
	
	select p_input_json->>'user_guid', p_input_json->>'guest_guid', p_input_json->>'asset_id', p_input_json->>'asset_type_id',
			p_input_json->>'count', p_input_json->>'days'
	into v_user_guid, v_guest_guid, v_asset_id, v_asset_type_id, v_count, v_days;
	
	v_days := 2;
	
	execute 'select (current_timestamp at time zone ''utc'' - '''||v_days||' days''::interval)::date::timestamp'
	into v_filter_timestamp;
	
	raise notice 'v_filter_timestamp : %',v_filter_timestamp;
	
	select array(select asset_list_id
				 from labdms.labdms_asset_list
				 where (asset_id, asset_type_id) in(select asset_id, asset_type_id
													from labdms.labdms_user_action_tracking
													where ((user_guid = v_user_guid and v_user_guid != '')
														   or (guest_guid = v_guest_guid and v_guest_guid != ''))
													and action_date >= v_filter_timestamp
													and asset_type_id in(1,2,4)
													group by asset_id, asset_type_id)
				 -- and web_listing_json is not null
				)
	into v_user_asset_list_id_arr;
	
	raise notice 'v_user_asset_list_id_arr : %',v_user_asset_list_id_arr;
	
	if v_asset_id is not null and v_asset_type_id is not null then
		
		select tagged_entity
		into v_tagged_entity
		from labdms.labdms_asset_list
		where asset_id = v_asset_id
		and asset_type_id = v_asset_type_id;
		
	else
		
		select array(select distinct unnest(tagged_entity)
					 from (select tagged_entity
						   from labdms.labdms_asset_list
						   where asset_list_id =any(v_user_asset_list_id_arr)
						  ) tab
					)
		into v_tagged_entity;
		
	end if;
	
	v_tagged_entity := v_tagged_entity::int[] - '{35366,35366,35521}'::int[];
	v_entity_count := array_length(v_tagged_entity::int[] , 1);
	
	raise notice 'v_tagged_entity : %',v_tagged_entity;
	raise notice 'v_entity_count : %',v_entity_count;
	
	select array(select asset_list_id
				 from (select asset_list_id,
					   			(coalesce(array_length((v_tagged_entity::int[] - tagged_entity), 1),
										  v_entity_count)::real / v_entity_count) * 100 percent_match
					   from labdms.labdms_asset_list
					   where published_date >= (current_timestamp at time zone 'utc' - '30 days'::interval)
					   and published_date <= (current_timestamp at time zone 'utc' - '3 hours'::interval)
					   and tagged_entity && v_tagged_entity::int[]
					   and not (asset_list_id =any(v_user_asset_list_id_arr))
					   and web_listing_json is not null
					   order by published_date desc
					  ) tab
				 order by percent_match
				 limit v_count)
	into v_asset_list_id_arr;
	
	raise notice 'v_asset_list_id_arr : %',v_asset_list_id_arr;
	
	v_asset_count := coalesce(array_length(v_asset_list_id_arr, 1),0);
	v_required_count := greatest((v_count - v_asset_count), 0);
	
	raise notice 'v_asset_count : %',v_asset_count;
	raise notice 'v_required_count : %',v_required_count;
	
	if v_required_count > 0 then
		
		select array(select asset_list_id
					 from labdms.labdms_asset_list
					 where not (asset_list_id =any(v_asset_list_id_arr))
					 and asset_type_id in(1,2,4)
					 and web_listing_json is not null
					 and published_date <= (current_timestamp at time zone 'utc' - '3 hours'::interval)
					 order by published_date desc
					 limit v_required_count)
		into v_asset_list_id_arr_more;
		
		v_asset_list_id_arr := array_cat(v_asset_list_id_arr, v_asset_list_id_arr_more);
		
		raise notice 'v_asset_list_id_arr_more : %',v_asset_list_id_arr_more;
		raise notice 'v_asset_list_id_arr : %',v_asset_list_id_arr;
		
	end if;
	
	v_asset_count := array_length(v_asset_list_id_arr, 1);
	
	raise notice 'v_asset_count : %',v_asset_count;
	
	if v_asset_count > 0 then
		
		p_asset_count := v_asset_count;
		
		select '{"items":['||string_agg(web_listing_json::text,',')||']}'
		from (select web_listing_json
			  from labdms.labdms_asset_list
			  where asset_list_id =any(v_asset_list_id_arr)
			 )tab
    	into p_asset_json;
		
	end if;
	
	raise notice 'p_asset_json : %',p_asset_json;
	
	-- select 1/0;
	
-- exception
-- 	when others then
-- 		p_asset_count := 0;
--         p_asset_json := '{"items":[]}';
	
end;
$$;


--
