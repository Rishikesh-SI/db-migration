-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_process_template_component_map_data(numeric, numeric)
-- Type: FUNCTION

-- Name: labsaw_process_template_component_map_data(numeric, numeric); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_process_template_component_map_data(p_tempate_id numeric, p_page_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_exist numeric ;
v_is_deleted numeric;
v_page_id_arr numeric[];
v_is_master numeric;
v_temp_html text;
v_mobile_html text;
v_alias text;
v_page_ent numeric[];
v_count numeric ;

begin 

insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'input-process_template_component_map_data',p_tempate_id::text,uuid_generate_v4(),null,current_timestamp,'labsaw',p_page_id::text);

if (p_tempate_id is null and p_page_id is not null) then

select parent_id into p_tempate_id from labsaw.labsaw_template where page_id=p_page_id;

end if;

  select array_agg(page_id)
  into v_page_id_arr
  from labsaw.labsaw_template
  where parent_id=p_tempate_id and page_id !=0 and is_active=1 and is_deleted=0 and is_published=1
  group by is_master,template_html,mobile_html;
  
  raise notice 'v_page_id_arr %',v_page_id_arr;
  
  select template_html,mobile_html ,is_master,is_deleted
 into v_temp_html,v_mobile_html,v_is_master,v_is_deleted
  from labsaw.labsaw_template
  where template_id=p_tempate_id
  ;
 
 if v_is_master =1 then
 v_page_id_arr=array[-1];
 end if;
   --raise notice '% % % %',v_temp_html,v_mobile_html,v_is_master,v_page_id_arr;
	--select 1/0;
	 
 if (v_page_id_arr is not null or v_is_master =1) then 
-- select 1/0;
  begin
  
     select 1  into strict v_exist  
	 from labsaw.labsaw_template_component_data
	 where template_id=p_tempate_id limit 1;
	 
	 
	
	--select 1/0;
	
	if v_is_deleted = 1 then 
	--select 1/0;
	   delete from  labsaw.labsaw_template_component_data
	   where template_id=p_tempate_id;
	   
	else 
	   
	 
	   
	   delete from  labsaw.labsaw_template_component_data
	   where template_id=p_tempate_id;
	   
	   select count(1) into v_count  
	 from labsaw.labsaw_template_component_data
	 where template_id=p_tempate_id ;
	   
	  raise notice '% p_tempate_id',v_page_id_arr;
	   
	  -- raise notice '% v_page_id_arr',v_page_id_arr;
	   
	   --select 1/0;
	   -- select * from labsaw.labsaw_template_component_data;
	   insert into labsaw.labsaw_template_component_data
		select  template_id,
			    template_component_map_id,
		        component_id,
				tab.required_entities,
				other_entities,
				exclude_entities,
				tagged_entities,
				(case when component_id=7 then (select p_assetjson 
 						from labsaw.labsaw_get_asset_listing_r(1, web_item_number,web_item_number, 
								   						   tab.required_entities, other_entities, null, null, 
														   exclude_entities ))
				     when component_id=1 then 
				 		  (SELECT p_ad_json from labsaw.labsaw_get_ad_r(null, 1,tab.required_entities, 1))
				 	 when component_id=9 then
	           coalesce((SELECT p_showcase_json from labsaw.labsaw_get_showcase_det_r('labsaw',template_component_map_id, tab.required_entities, tab.other_entities, null, 1, coalesce(web_item_number,10), 10, is_fallback)),'[]')
  		        when component_id=41 then (SELECT * from labsaw.labsaw_get_navigation_r(0, array[template_component_map_id], null))
				else '{}'
				 end )
				 ,
				status,
				current_timestamp,
				current_timestamp,
				web_item_number,
				mob_item_number,
				tab.page_id,
			(select  array_agg(entity_role_map_id order by entity_role_map_id )
											from labsaw.labsaw_asset_entity_map aem
												where aem.asset_id = tab.page_id
												and aem.asset_type_id = 11

									) as page_tagged_entities,
			a.alias	,
			tcmap_guid,
			is_responsive as is_responsive,
									fetch_from,
									(select  array_agg(entity_role_map_id order by entity_role_map_id )
											from labsaw.labsaw_asset_entity_map aem
												where aem.asset_id = tab.page_id
												and aem.asset_type_id = 11
												and is_required=1
									) as page_req_entities,
									is_fallback,
									null as is_mobile,
									a.is_amp,
									parent_tcmap_id
		from (
		select
		tcm.template_id,
		template_component_map_id,
		component_id,
		(select array_agg(entity_role_map_id order by entity_role_map_id )
											from labsaw.labsaw_asset_entity_map aem
												where aem.asset_id = tcm.template_component_map_id
												and aem.asset_type_id = 13
												and aem.is_required = 1
									) as required_entities,
										(select  array_agg(entity_role_map_id order by entity_role_map_id )
											from labsaw.labsaw_asset_entity_map aem
												where aem.asset_id = tcm.template_component_map_id
												and aem.asset_type_id = 13
												and (aem.is_required = 0 or aem.is_required is null)
									) as other_entities,
									(select  array_agg(entity_role_map_id order by entity_role_map_id )
											from labsaw.labsaw_asset_entity_map aem
												where aem.asset_id = tcm.template_component_map_id
												and aem.asset_type_id = 13
												and aem.is_required = 2
									) as exclude_entities,
									(select  array_agg(entity_role_map_id order by entity_role_map_id )
											from labsaw.labsaw_asset_entity_map aem
												where aem.asset_id = tcm.template_component_map_id
												and aem.asset_type_id = 13

									) as tagged_entities,
				(case when component_id=41 then (SELECT * from labsaw.labsaw_get_navigation_r(0, array[template_component_map_id], null))
				else '{}'
				
				 end ),
		0 as status,
		current_timestamp,
		current_timestamp,
		(meta_info->>'lg_row')::numeric as web_item_number,
		(meta_info->>'sm_row')::numeric as mob_item_number	,
		unnest(v_page_id_arr) as page_id,
		tcmap_guid	,
		fetch_from,
		(meta_info->>'fb')::numeric	 as is_fallback	,
		t.is_responsive	,
		parent_tcmap_id	
		from labsaw.labsaw_template_component_map tcm join
			 labsaw.labsaw_template t on t.template_id=tcm.template_id
		where tcm.template_id=p_tempate_id and tcm.is_active=1 and tcm.is_deleted=0 and tcm.is_published=1
			)tab
			left join labsaw.labsaw_page a on a.page_id=tab.page_id;

	 
	end if;
	 
 exception when no_data_found then 	 

-- select 1/0;
		insert into labsaw.labsaw_template_component_data
		
		select  template_id,
			    template_component_map_id,
		        component_id,
				tab.required_entities,
				tab.other_entities,
				tab.exclude_entities,
				tab.tagged_entities,
				(case when component_id=7 then (select p_assetjson 
 						from labsaw.labsaw_get_asset_listing_r(1, web_item_number,web_item_number, 
								   						   tab.required_entities, tab.other_entities, null, null, 
														   tab.exclude_entities ))
				     when component_id=1 then 
				 		  (SELECT p_ad_json from labsaw.labsaw_get_ad_r(null, 1,tab.required_entities, 1))
				 when component_id=9 then
	           coalesce((SELECT p_showcase_json from labsaw.labsaw_get_showcase_det_r('labsaw',template_component_map_id, tab.required_entities, tab.other_entities, null, 1, coalesce(web_item_number,10), 10, is_fallback)),'[]')
  		       when component_id=41 then (SELECT * from labsaw.labsaw_get_navigation_r(0, array[template_component_map_id], null))
			  else '{}'
				
				 end ),
				status,
				current_timestamp,
				current_timestamp,
				web_item_number,
				mob_item_number,
				tab.page_id
				,(select  array_agg(entity_role_map_id order by entity_role_map_id )
											from labsaw.labsaw_asset_entity_map aem
												where aem.asset_id = tab.page_id
												and aem.asset_type_id = 11

									) as page_tagged_entities,
									a.alias,
									tcmap_guid,
									is_responsive as is_responsive,
									fetch_from,
									(select  array_agg(entity_role_map_id order by entity_role_map_id )
											from labsaw.labsaw_asset_entity_map aem
												where aem.asset_id = tab.page_id
												and aem.asset_type_id = 11
												and is_required=1
									) as page_req_entities,
									is_fallback,
									null as is_mobile,
									a.is_amp,
									parent_tcmap_id
									from (
		select
		tcm.template_id,
		template_component_map_id,
		component_id,
		(select array_agg(entity_role_map_id order by entity_role_map_id )
											from labsaw.labsaw_asset_entity_map aem
												where aem.asset_id = tcm.template_component_map_id
												and aem.asset_type_id = 13
												and aem.is_required = 1
									) as required_entities,
										(select  array_agg(entity_role_map_id order by entity_role_map_id )
											from labsaw.labsaw_asset_entity_map aem
												where aem.asset_id = tcm.template_component_map_id
												and aem.asset_type_id = 13
												and (aem.is_required = 0 or aem.is_required is null)
									) as other_entities,
									(select  array_agg(entity_role_map_id order by entity_role_map_id )
											from labsaw.labsaw_asset_entity_map aem
												where aem.asset_id = tcm.template_component_map_id
												and aem.asset_type_id = 13
												and aem.is_required = 2
									) as exclude_entities,
									(select  array_agg(entity_role_map_id order by entity_role_map_id )
											from labsaw.labsaw_asset_entity_map aem
												where aem.asset_id = tcm.template_component_map_id
												and aem.asset_type_id = 13

									) as tagged_entities,
				(case when component_id=41 then (SELECT * from labsaw.labsaw_get_navigation_r(0, array[template_component_map_id], null))
				else '{}'
				
				 end ),
		0 as status,
		current_timestamp,
		current_timestamp,
		(meta_info->>'lg_row')::numeric as web_item_number,
		(meta_info->>'sm_row')::numeric as mob_item_number	,
		unnest(v_page_id_arr) as page_id,
		tcmap_guid	,
		fetch_from,
		(meta_info->>'fb')::numeric	 as is_fallback,	
		t.is_responsive,
		parent_tcmap_id								
		from labsaw.labsaw_template_component_map tcm
		join labsaw.labsaw_template t on t.template_id=tcm.template_id
		where tcm.template_id=p_tempate_id and tcm.is_active=1 and tcm.is_deleted=0 and tcm.is_published=1
										)tab
		left join labsaw.labsaw_page a on a.page_id=tab.page_id;

end ;
end if;

update labsaw.labsaw_template_component_data 
set is_mobile=0 
where selector in (select selector from labsaw.labsaw_template_component_data tcd
join (select a[1] as guid, row_number() over() as slno
                              			from (select regexp_matches(v_temp_html,'([0-9 a-z]{8,8}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{12,12})','g') as a
										) as b
			 
			 ) tab
on tab.guid = tcd.selector
where template_id=p_tempate_id
and parent_tcmap_id is null);

if v_mobile_html is not null then 
update labsaw.labsaw_template_component_data 
set is_mobile=1
where selector in (select selector from labsaw.labsaw_template_component_data tcd
join (select a[1] as guid, row_number() over() as slno
                              			from (select regexp_matches(v_mobile_html,'([0-9 a-z]{8,8}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{12,12})','g') as a
										) as b
			 
			 ) tab
on tab.guid = tcd.selector
where template_id=p_tempate_id
and parent_tcmap_id is null);
end if;

update labsaw.labsaw_template_component_data tc
set is_mobile=tcd.is_mobile  from labsaw.labsaw_template_component_data tcd
where tc.parent_tcmap_id is not null and tc.template_id=p_tempate_id
and tcd.template_component_map_id=tc.parent_tcmap_id;

if p_page_id is not null or p_page_id !=0 then

select alias,
(select  array_agg(entity_role_map_id order by entity_role_map_id )
											from labsaw.labsaw_asset_entity_map aem
												where aem.asset_id = p.page_id
												and aem.asset_type_id = 11
												and is_required=1
									)  into v_alias ,v_page_ent
from labsaw.labsaw_page p
where p.page_id=p_page_id and p.is_active=1 and p.is_deleted=0 ;

update labsaw.labsaw_template_component_data
set page_alias=v_alias,page_req_entity=v_page_ent
where page_id=p_page_id;

end if;

p_result:=1;

end ;
$$;


--
