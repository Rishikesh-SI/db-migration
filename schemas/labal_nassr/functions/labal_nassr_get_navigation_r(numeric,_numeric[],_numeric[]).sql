-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: labal_nassr_get_navigation_r(numeric, numeric[], numeric[])
-- Type: FUNCTION

-- Name: labal_nassr_get_navigation_r(numeric, numeric[], numeric[]); Type: FUNCTION; Schema: labal_nassr; Owner: -
--

CREATE FUNCTION labal_nassr.labal_nassr_get_navigation_r(p_parent_id numeric, p_template_comp_map_id numeric[], p_entity numeric[], OUT p_menu_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
/*
SELECT * from labal_nassr.labal_nassr_get_navigation_r(
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
	i jsonb;
	v_menu_page_map_id_arr jsonb;
	v_sub_menu jsonb;
	v_menu_page_map_id numeric;
	v_page_id numeric;
	v_menu_page_map_id_arr1 jsonb;
	v_menu_page_map_id1 numeric;
	p_page_id1 numeric;
	v_submenu_array jsonb;
	v_msubmenu jsonb;
	p_menu_page_map_id numeric[];
	p_parent_page_id numeric;
	v_parent_id_arr numeric[];
	p numeric;
	v_sub_menu_t jsonb;
	v_page_id_a numeric;
	v_parent_id_a numeric;
	h jsonb;
	g jsonb;
	a numeric;
	p_pageid_array numeric[];
	v_menu_array text:= '[';
	p_submenu_json jsonb;
	--v_menu_page_map_id numeric;
begin
	
	v_entity_array := p_entity ;--string_to_array(p_entity,',')::numeric[];
	
	--raise notice 'v_entity_array : %',v_entity_array;
	
	select template_id
	into v_template_id
	from labal_nassr.labal_nassr_template_component_map
	where template_component_map_id = p_template_comp_map_id[1];
	
---	raise notice 'v_template_id : %',v_template_id;
	--select 1/0;
	
 	if v_template_id is not null then
		
		select template_component_map_id, template_id, fetch_from, menu_id, 
		(case when fetch_from=1 then uniq(sort(array_cat(tcm_entity_arr::int[],v_entity_array::int[])::int[])::int[]) else  tcm_entity_arr end)
		as tcm_entity_arr, menu_entity_arr
		from (select a.template_component_map_id, a.template_id, a.fetch_from, c.menu_id,
			 		(select array(select distinct entity_role_map_id
							    from labal_nassr.labal_nassr_asset_entity_map b
							    where b.asset_id = a.template_component_map_id
							    and b.asset_type_id = 13
							    order by 1)) as tcm_entity_arr,
					(select array(select distinct d.entity_role_map_id
							    from labal_nassr.labal_nassr_asset_entity_map d
							    where d.asset_id = c.menu_id
							    and d.asset_type_id = 22
						 	    order by 1)) as menu_entity_arr
			 from labal_nassr.labal_nassr_template_component_map a
			 join labal_nassr.labal_nassr_template t
			 on a.template_id = t.template_id
			 left join labal_nassr.labal_nassr_page_template_component_menu_map c
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
		raise notice 'v_menu_id : %',v_menu_id;
		--raise notice 'v_tcm_entity_arr : %',v_tcm_entity_arr;
		--raise notice 'v_menu_entity_arr : %',v_menu_entity_arr;
		
		 -- select 1/0;
  end if;	       
	      
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
		
		 select array(select b.entity_role_map_id from labal_nassr.labal_nassr_entity_role_map a
	     join (select * from unnest(v_entity_array) as u(entity_role_map_id)) as b 
	     on a.entity_role_map_id=b.entity_role_map_id
	     where entity_role_id in (28,31)) into v_series_array;
		 
		  
	
	select jsonb_agg(r) from 
	(select a.menu_page_map_id,a.page_id
	from labal_nassr.labal_nassr_menu_page_map a
	join labal_nassr.labal_nassr_page_template_component_menu_map b
	on b.menu_id = a.menu_id
	and b.template_component_map_id = any(p_template_comp_map_id) 
	where parent_page_id=0
	and a.menu_id=v_menu_id
	and a.is_active=1 and a.is_deleted=0
	and b.is_active=1 and b.is_deleted=0
	)r
	into v_menu_page_map_id_arr;
	
	--raise notice 'v_menu_page_map_id_arr %',v_menu_page_map_id_arr;
	----for those who dont have sub menu
	for i in select * from jsonb_array_elements(v_menu_page_map_id_arr)
	loop
	
		select i->>'menu_page_map_id',
			   i->>'page_id'
		into v_menu_page_map_id,
			 v_page_id;
				
				select row_to_json(row) from(
				select  a.*, 
				p.alias, 
				b.template_component_map_id
				from labal_nassr.labal_nassr_menu_page_map a
				join labal_nassr.labal_nassr_page_template_component_menu_map b
				on b.menu_id = a.menu_id
				and b.template_component_map_id = any(p_template_comp_map_id)
				join labal_nassr.labal_nassr_page p
				on a.page_id = p.page_id
				where a.menu_id = v_menu_id
				and a.menu_page_map_id=v_menu_page_map_id
				and b.is_active = 1
				and b.is_deleted = 0
				and b.is_published = 1
				and a.is_active = 1
				and a.is_deleted = 0
				and p.is_active = 1
				and p.is_deleted = 0
				and parent_page_id=0
				order by a.page_level, a.order_number)row
				into v_msubmenu;

	--raise notice 'v_msubmenu %',v_msubmenu;

			select v_msubmenu->>'page_id'
				into v_page_id;
				

				if (select count(1) from labal_nassr.labal_nassr_menu_page_map where parent_page_id=v_page_id) > 0 then
				
					raise notice 'p_template_comp_map_idasdasa %',p_template_comp_map_id;
					
					select * from labal_nassr.labal_nassr_get_sub_menu(v_page_id,p_template_comp_map_id) into p_submenu_json;
					
					v_msubmenu:=jsonb_set(v_msubmenu,'{sub_menu}',p_submenu_json,true);

				end if;
			

			v_menu_array := v_menu_array||v_msubmenu||',';
			

			
			end loop;	
						v_menu_array := v_menu_array||']';

				select REPLACE(v_menu_array, ',]', ']' ) into p_menu_json;
			

	-------------------------------------------------------------------------
	select ('{"menu_list":'||to_jsonb(tab_data )::text||'}')::jsonb into p_menu_json
	from (
	select ab.menu_id,ab.menu_name,ab.menu_type,template_component_map_id,ab.required_entities
		as menu_required_entities,ab.is_deleted,p_menu_json as menu 
		from labal_nassr.labal_nassr_menu ab 
        join labal_nassr.labal_nassr_page_template_component_menu_map b
		on b.menu_id = ab.menu_id	
		group by ab.menu_id,ab.menu_name,ab.menu_type,template_component_map_id,ab.required_entities,ab.is_deleted)tab_data;
				
	
	
 	
end;
$$;


--
