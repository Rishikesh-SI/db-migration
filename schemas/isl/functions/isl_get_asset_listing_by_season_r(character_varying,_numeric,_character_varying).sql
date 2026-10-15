-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_asset_listing_by_season_r(character varying, numeric, character varying)
-- Type: FUNCTION

-- Name: isl_get_asset_listing_by_season_r(character varying, numeric, character varying); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_asset_listing_by_season_r(p_season_id character varying, p_limit numeric, p_asset_type character varying, OUT p_assetjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

    declare
	
	v_entity_role_map_id numeric ;
	v_assetjson jsonb;
	v_asset_query text ;
	v_limit numeric ;
	v_limit_query text ;
	v_ent_array numeric[];
	begin
		v_limit := p_limit;
	
		select entity_role_map_id into v_entity_role_map_id 
		from isl.isl_entity_role_map
		where entity_role_id = 7 and source_object_id = p_season_id ;
	
		select string_to_array(p_asset_type, ',')::int[] into v_ent_array;

		if v_ent_array::text='{}' or v_ent_array is null then
     
				v_asset_query := ' and sl.asset_type_id in (1,2,4,5)';
	
		else  
	       		v_asset_query := 'and sl.asset_type_id = any($1)';
  
		end if;
	
		if v_limit is not null then
	
			v_limit_query := 'limit $2';
	
		end if;
		
		
		execute  'with cte_data as(select distinct a.entity_role_map_id,b.source_object_id from isl.isl_asset_entity_map a
								  left join isl.isl_entity_role_map b on a.entity_role_map_id = b.entity_role_map_id
								  left join isl.isl_entity_master d on b.entity_master_id = d.entity_master_id	
								  where b.entity_role_id = 6 and exists(select 1 from isl.isl_asset_entity_map c
								                                       where c.asset_id = a.asset_id and c.asset_type_id = a.asset_type_id
																	   and  c.entity_role_map_id = '||v_entity_role_map_id||'))

				select (''{"matches":[''||string_agg((row_to_json(tab1))::text,'','')||'']}'') 
				from(select source_object_id as match_id,(select array_to_json(array_agg(a))
				      from(select b.* from ((select asset_list_id, sl.asset_id, sl.asset_type_id, sl.asset_title, sl.title_alias, author_id,
                                   short_desc, tags, primary_entity_role_map_id, secondary_entity_role_map_id, total_assets,
                                   image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
                                   published_version_number, sl.is_trashed, sl.created_date, sl.updated_date, sl.created_by, sl.updated_by,
                                   sl.is_active, sl.is_deleted, sl.is_published, published_date, asset_guid, show_copyright, order_number,
                                   image_file_name, image_path,ermp_1.source_object_id
                                   ,row_number()over (order by sl.published_date desc) as rno,u.display_name display_name,u.user_name user_name,
                                    u.full_name full_name,emp.entity_name primary_entity_name, ems.entity_name secondary_entity_name,
                                    coalesce(pel.entity_display_name,emp.entity_display_name) pri_ent_disp_name,
                                    coalesce(sel.entity_display_name,ems.entity_display_name) sec_ent_disp_name,sl.short_title 
									from isl.isl_asset_list sl 
									join isl.isl_asset_entity_map aem
						            on sl.asset_id = aem.asset_id and sl.asset_type_id = aem.asset_type_id
                                    join   isl.isl_entity_role_map ermp
                                    on     ermp.entity_role_map_id = sl.primary_entity_role_map_id
                                    join   isl.isl_entity_role_map erms
                                    on     erms.entity_role_map_id = sl.secondary_entity_role_map_id
                                    join   isl.isl_entity_master emp
                                    on     emp.entity_master_id = ermp.entity_master_id
                                    left join isl.isl_entity_language_map pel
                                    on     emp.entity_master_id=pel.entity_master_id
                                    join   isl.isl_entity_master ems
                                    on     ems.entity_master_id = erms.entity_master_id
                                    left join isl.isl_entity_language_map sel
                                    on     ems.entity_master_id=sel.entity_master_id
						  			left join isl.isl_entity_role_map ermp_1
									on  aem.entity_role_map_id = ermp_1.entity_role_map_id
			                       left join isl.isl_user u
                                   on u.user_id = sl.author_id
                                   where sl.is_active=1
       		                       and sl.is_deleted=0
                                   and    sl.is_published=1 
                                   and   aem.entity_role_map_id = tab.entity_role_map_id '
                                  ||v_asset_query|| '
			                       order by  published_date desc))b
                                  join isl.isl_asset_entity_map aem1 on b.asset_id = aem1.asset_id and b.asset_type_id = aem1.asset_type_id
                                  and aem1.entity_role_map_id= 37'
                                  || v_limit_query||')a
                                  )"data"
                   from cte_data tab)tab1'
					into  v_assetjson
					using v_ent_array,v_limit;
					
			p_assetjson := 	v_assetjson;	
			
		exception
		when others then
   
          p_assetjson := null;
	
	end;
	
	

$_$;


--
