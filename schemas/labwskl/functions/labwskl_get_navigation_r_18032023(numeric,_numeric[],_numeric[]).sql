-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwskl
-- Object: labwskl_get_navigation_r_18032023(numeric, numeric[], numeric[])
-- Type: FUNCTION

-- Name: labwskl_get_navigation_r_18032023(numeric, numeric[], numeric[]); Type: FUNCTION; Schema: labwskl; Owner: -
--

CREATE FUNCTION labwskl.labwskl_get_navigation_r_18032023(p_parent_id numeric, p_template_comp_map_id numeric[], p_entity numeric[], OUT p_menu_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
/*
SELECT * from labwskl.labwskl_get_navigation_r(
	null,-- <p_parent_id numeric>, 
	array[2],-- <p_template_comp_map_id numeric[]>, 
	'4',-- <p_entity character varying>, 
	'a',-- <p_menu_cur refcursor>, 
	'b',-- <p_navigation_cur refcursor>, 
	'c'-- <p_page_ent_cur refcursor>
);
fetch all in "a";
*/
declare
	
	v_entity_array numeric[];
	v_template_id numeric;
	v_template_component_map_id numeric;
	v_fetch_from numeric;
	v_menu_id numeric;
	v_tcm_entity_arr numeric[];
	v_menu_entity_arr numeric[];
	v_parent_id numeric := p_parent_id;
	v_series_array numeric[];
	
begin
	
	v_entity_array := p_entity ;--string_to_array(p_entity,',')::numeric[];
	
	--raise notice 'v_entity_array : %',v_entity_array;
	
	select template_id
	into v_template_id
	from labwskl.labwskl_template_component_map
	where template_component_map_id = p_template_comp_map_id[1];
	
---	raise notice 'v_template_id : %',v_template_id;
	--select 1/0;
	
 	if v_template_id is not null then
		
		select template_component_map_id, template_id, fetch_from, menu_id, 
		(case when fetch_from=1 then uniq(sort(array_cat(tcm_entity_arr::int[],v_entity_array::int[])::int[])::int[]) else  tcm_entity_arr end)
		as tcm_entity_arr, menu_entity_arr
		from (select a.template_component_map_id, a.template_id, a.fetch_from, c.menu_id,
			 		(select array(select distinct entity_role_map_id
							    from labwskl.labwskl_asset_entity_map b
							    where b.asset_id = a.template_component_map_id
							    and b.asset_type_id = 13
							    order by 1)) as tcm_entity_arr,
					(select array(select distinct d.entity_role_map_id
							    from labwskl.labwskl_asset_entity_map d
							    where d.asset_id = c.menu_id
							    and d.asset_type_id = 22
						 	    order by 1)) as menu_entity_arr
			 from labwskl.labwskl_template_component_map a
			 join labwskl.labwskl_template t
			 on a.template_id = t.template_id
			 left join labwskl.labwskl_page_template_component_menu_map c
			 on c.template_component_map_id = a.template_component_map_id
			 and c.is_active = 1
			 and c.is_deleted = 0
			 and c.is_published=1
			 where a.template_id = v_template_id
			 and a.template_component_map_id =any(p_template_comp_map_id)
			 and a.is_active = 1
			 and a.is_deleted = 0
			 and t.is_active = 1
			 and t.is_deleted = 0
			)a
		where menu_id is not null
		and menu_entity_arr = (case when fetch_from=1 then uniq(sort(array_cat(tcm_entity_arr::int[],v_entity_array::int[])::int[])::int[])
			 else menu_entity_arr end)
		into v_template_component_map_id, v_template_id, v_fetch_from, v_menu_id, v_tcm_entity_arr, v_menu_entity_arr;
		
		--raise notice 'v_template_component_map_id : %',v_template_component_map_id;
		--raise notice 'v_template_id : %',v_template_id;
		--raise notice 'v_fetch_from : %',v_fetch_from;
		--raise notice 'v_menu_id : %',v_menu_id;
		--raise notice 'v_tcm_entity_arr : %',v_tcm_entity_arr;
		--raise notice 'v_menu_entity_arr : %',v_menu_entity_arr;
		
		 -- select 1/0;
	       
	      
		if not v_menu_entity_arr <@ v_tcm_entity_arr then
			v_menu_id := 0;
		   -- raise notice 'v_menu_entity_arr : %','test';
			--select 1/0;
		else
			if v_fetch_from <> 2 then
				if not v_menu_entity_arr <@ v_entity_array then
					v_menu_id := 0;
				end if;
			end if;
		end if;
		
		  --raise notice 'v_fetch_from : % %',v_fetch_from,v_menu_id;
		 --- select 1/0;
		
		 select array(select b.entity_role_map_id from labwskl.labwskl_entity_role_map a
	     join (select * from unnest(v_entity_array) as u(entity_role_map_id)) as b 
	     on a.entity_role_map_id=b.entity_role_map_id
	     where entity_role_id in (28,31)) into v_series_array;
		 
		 -- raise notice 'sereis : %',v_menu_id;
		
		--select 1/0;
	select ('{"menu_list":'||to_jsonb(tab_data )::text||'}')::jsonb into p_menu_json
	from (
select ab.menu_id,ab.menu_name,ab.menu_type,template_component_map_id,ab.required_entities
		as menu_required_entities,ab.is_deleted, 
		jsonb_agg(row_1 order by row_1.order_number) as Menu from (
select * ,
(select json_agg(row) from (select p.alias,a.*,b.template_component_map_id
							from labwskl.labwskl_menu_page_map a
		join labwskl.labwskl_page_template_component_menu_map b
		on b.menu_id = tab.menu_id
		and b.template_component_map_id=tab.template_component_map_id
		join labwskl.labwskl_page p
		on a.page_id = p.page_id					
		where a.parent_page_id=tab.page_id
		and b.is_active = 1
		and b.is_deleted = 0
		and b.is_published = 1
		and a.is_active = 1
		and a.is_deleted = 0
		and p.is_active = 1
		and p.is_deleted = 0
		order by a.page_level, a.order_number )row) as sub_menu
from 
(select  a.*, 
		p.alias, 
		b.template_component_map_id
		from labwskl.labwskl_menu_page_map a
		join labwskl.labwskl_page_template_component_menu_map b
		on b.menu_id = a.menu_id
		and b.template_component_map_id =any(p_template_comp_map_id)
		join labwskl.labwskl_page p
		on a.page_id = p.page_id
		where a.menu_id = v_menu_id
		and b.is_active = 1
		and b.is_deleted = 0
		and b.is_published = 1
		and a.is_active = 1
		and a.is_deleted = 0
		and p.is_active = 1
		and p.is_deleted = 0
 		and parent_page_id=0
		order by a.page_level, a.order_number 
	  )tab
	  
	) row_1
	join labwskl.labwskl_menu ab on row_1.menu_id=ab.menu_id
	group by ab.menu_id,ab.menu_name,ab.menu_type,template_component_map_id,ab.required_entities,ab.is_deleted
	)tab_data;
	
		---raise notice '%',p_menu_json;
		--select 1/0;
		
		
		-- select 1/0;
		
	/*	open p_menu_cur for
		select *
		from labwskl.labwskl_menu
		where menu_id = v_menu_id
		and is_active = 1
		and is_deleted = 0
		and is_published = 1;
    		
		open p_navigation_cur for
		/*select a.*, p.alias, b.template_component_map_id, 1 as data_count
		from labwskl.labwskl_menu_page_map a
		join labwskl.labwskl_page_template_component_menu_map b
		on b.menu_id = a.menu_id
		and b.template_component_map_id =any(p_template_comp_map_id)
		join labwskl.labwskl_page p
		on a.page_id = p.page_id
		where a.menu_id = v_menu_id
		and b.is_active = 1
		and b.is_deleted = 0
		and a.is_active = 1
		and a.is_deleted = 0
		and p.is_active = 1
		and p.is_deleted = 0
		order by a.page_level, a.order_number;
		*/
		
 select * from (select *, 
(case when cnt is null then 1 else
(case when cnt >= asset_count::numeric then 1 else 0 end) end) as menu_display from (
select * , 
array_length(entity_role_map_id,1),
(case when array_length(entity_role_map_id,1) >1 then
(case when  entity_role_map_id is not null then  (select count(1) from labwskl.labwskl_asset_list
where tagged_entity && array_cat(v_series_array::int[]::int[],entity_role_map_id::int[]) 
and is_published=1) else null end )
else   
(case when  entity_role_map_id is not null then  (select count(1) from labwskl.labwskl_asset_list
where tagged_entity @> array_cat(v_series_array::int[]::int[],entity_role_map_id::int[]) 
and is_published=1) else null end)
end  )as cnt

from (
      select 
	    -- array_length(p.meta_info::jsonb,1) as array_length,
	   case when v_series_array !='{}' then string_to_array(labwskl.get_element_list_fromjson_array(p.meta_info::jsonb->'series','entity_role_map_id'),',') 
	else null end as entity_role_map_id,
		 case when v_series_array !='{}'  then array_to_string(string_to_array(labwskl.get_element_list_fromjson_array(p.meta_info::jsonb->'series','asset_count'),','),',')
	else null end  as asset_count	,
	     a.*, 
		p.alias, 
		b.template_component_map_id, 
		p.meta_info
		from labwskl.labwskl_menu_page_map a
		join labwskl.labwskl_page_template_component_menu_map b
		on b.menu_id = a.menu_id
		and b.template_component_map_id =any(array[p_template_comp_map_id])
		join labwskl.labwskl_page p
		on a.page_id = p.page_id
		where a.menu_id = v_menu_id
		and b.is_active = 1
		and b.is_deleted = 0
		and b.is_published = 1
		and a.is_active = 1
		and a.is_deleted = 0
		and p.is_active = 1
		and p.is_deleted = 0
		order by a.page_level, a.order_number 
	    -- limit 1
		) tab
		)tab2 
		)tab3
		where menu_display <>0;

		open p_page_ent_cur for
     	select *, labwskl.labwskl_get_entity_known_as(entity_role_map_id) known_as
		from labwskl.labwskl_asset_entity_map
		where asset_type_id = 11
		and asset_id = v_parent_id;
		
	else
		
		open p_menu_cur for
		select * from labwskl.labwskl_menu where 1 = 0;
    		
		open p_navigation_cur for
		select a.*, null as alias, null as template_component_map_id
		from labwskl.labwskl_menu_page_map a
		where 1 = 0;
		
		open p_page_ent_cur for
		select a.*, null as known_as
		from labwskl.labwskl_asset_entity_map a
		where 1 = 0;
	*/	
 	end if;
	
 	
end;
$$;


--
