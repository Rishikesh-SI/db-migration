-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_asset_related_stories_r_change(numeric, numeric, numeric[], numeric)
-- Type: FUNCTION

-- Name: labrr_get_asset_related_stories_r_change(numeric, numeric, numeric[], numeric); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_asset_related_stories_r_change(p_asset_id numeric, p_asset_type_id numeric, p_entityrole_mapid numeric[], p_cnt numeric, OUT p_assetjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
 
declare

v_asset_published_date timestamp;
v_cnt numeric;
v_arr_asset_id numeric[];
v_assetjsonarr jsonb[];
v_category_arr numeric[];
    
begin

select published_date 
     into   v_asset_published_date
     from   labrr.labrr_asset_list 
     where  asset_id=p_asset_id 
     and    asset_type_id=p_asset_type_id;
	 
	 
select coalesce(count(1),0) into v_cnt
 from   labrr.labrr_asset_list
where    asset_type_id=p_asset_type_id
and tagged_entity @> p_entityrole_mapid::int[]
and asset_id<>p_asset_id;

if (p_entityrole_mapid::int[] @> array[3] or p_entityrole_mapid::int[] @> array[87]) then

if p_entityrole_mapid::int[] @> array[3] then
    select array_replace(p_entityrole_mapid::int[],3,87) into v_category_arr;
elsif p_entityrole_mapid::int[] @> array[87] then
    select array_replace(p_entityrole_mapid::int[],87,3) into v_category_arr;
end if;

select array_agg(asset_id) into v_arr_asset_id
from   labrr.labrr_asset_list 
where  asset_type_id=p_asset_type_id
and (tagged_entity @> p_entityrole_mapid::int[]
or tagged_entity @> v_category_arr::int[])
and asset_id<>p_asset_id;

else

select array_agg(asset_id) into v_arr_asset_id
 from   labrr.labrr_asset_list 
where  asset_type_id=p_asset_type_id
and tagged_entity @> p_entityrole_mapid::int[]
and asset_id<>p_asset_id;

end if;


if v_cnt>0 then

	select jsonb_build_object('items',jsonb_agg(row_data)) from
	(select row_to_json(row) as row_data
	from (select tab.*, row_number()over() as rno from 
	((select asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id,
                          short_desc, tags, primary_entity_role_map_id, secondary_entity_role_map_id, total_assets,
                          image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
                          published_version_number, is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by,
                          sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid, show_copyright, order_number, image_file_name, image_path
             ,u.user_name,emp.entity_name primary_entity_name,
             ems.entity_name secondary_entity_name
            from labrr.labrr_asset_list sl
			left join labrr.labrr_user u on u.user_id = sl.author_id 
                          join   labrr.labrr_entity_role_map ermp
                          on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
                          join   labrr.labrr_entity_role_map erms
                          on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
                          join   labrr.labrr_entity_master emp
                          on     emp.entity_master_id = ermp.entity_master_id
                          join   labrr.labrr_entity_master ems
                          on     ems.entity_master_id = erms.entity_master_id
             where sl.is_active=1
       		  and sl.is_deleted=0
              and    sl.is_published=1
			  and published_date<v_asset_published_date
              and    sl.asset_type_id in (p_asset_type_id)
             and  sl.asset_id in (select asset_id from unnest(v_arr_asset_id)asset_id)
			 order by sl.published_date desc)
			 
			 union all
			 
			 (select asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id,
                          short_desc, tags, primary_entity_role_map_id, secondary_entity_role_map_id, total_assets,
                          image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
                          published_version_number, is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by,
                          sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid, show_copyright, order_number, image_file_name, image_path
             ,u.user_name,emp.entity_name primary_entity_name,
             ems.entity_name secondary_entity_name
            from labrr.labrr_asset_list sl
			left join labrr.labrr_user u on u.user_id = sl.author_id 
                          join   labrr.labrr_entity_role_map ermp
                          on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
                          join   labrr.labrr_entity_role_map erms
                          on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
                          join   labrr.labrr_entity_master emp
                          on     emp.entity_master_id = ermp.entity_master_id
                          join   labrr.labrr_entity_master ems
                          on     ems.entity_master_id = erms.entity_master_id
             where sl.is_active=1
       		  and sl.is_deleted=0
              and    sl.is_published=1
			  and published_date>v_asset_published_date
              and    sl.asset_type_id in (p_asset_type_id)
             and  sl.asset_id in (select asset_id from unnest(v_arr_asset_id)asset_id)
             order by sl.published_date desc
             ))tab
			 )row)tab1 
			 into p_assetjson;			 

else

end if;

 
     
end;

 
$$;


--
