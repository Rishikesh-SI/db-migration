-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_get_component_layout_details(numeric)
-- Type: FUNCTION

-- Name: waf_get_component_layout_details(numeric); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_get_component_layout_details(p_client_id numeric, OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare 
v_client_id numeric;
begin

v_client_id := p_client_id;

with my_data as 
	(select component_layout_id,client_id,null Parent_id  
	 from waf_master.waf_client_component_layout_map
	 where waf_client_component_layout_map.client_id = v_client_id 
	 and component_layout_id not in (select component_layout_id 
									 from waf_master.waf_component_layout_dependency_map)
	union all 
	 select  child_component_layout_id, v_client_id client_id ,component_layout_id  
	 from waf_master.waf_component_layout_dependency_map
	 where component_layout_id in(select waf_client_component_layout_map.component_layout_id 
								  from waf_master.waf_client_component_layout_map
								  where waf_client_component_layout_map.client_id = v_client_id)
	union all
	 select  component_layout_id, v_client_id client_id ,null  
	 from waf_master.waf_component_layout_dependency_map
	 where component_layout_id in(select waf_client_component_layout_map.component_layout_id 
								  from waf_master.waf_client_component_layout_map 
								  where waf_client_component_layout_map.client_id = v_client_id))

select '{"widgets":['||string_agg(row_to_json(r,true)::text,',')||']}' into p_result 
from (SELECT tab.component_layout_id,cl.ref_number,cl.layout_name,cl.layout_display_name,cl.layout_desc,
	         cl.component_type_id,cl.component_id,cl.image_file_name,cl.image_path,cl.is_responsive,
	         cl.mobile_image_file_name,cl.mobile_image_path,cl.widget_group_id,jsonb_agg(row) AS sub_menu
	  FROM (select component_layout_id,null Parent_id  
			from waf_master.waf_client_component_layout_map
            where waf_client_component_layout_map.client_id = v_client_id 
            and component_layout_id not in (select component_layout_id 
											from waf_master.waf_component_layout_dependency_map)
  			union all 
			select  child_component_layout_id,component_layout_id  
			from waf_master.waf_component_layout_dependency_map
			where component_layout_id in(select waf_client_component_layout_map.component_layout_id 
										 from waf_master.waf_client_component_layout_map
										 where waf_client_component_layout_map.client_id = v_client_id)
			union all
			select  component_layout_id,null  from waf_master.waf_component_layout_dependency_map
			where component_layout_id in(select waf_client_component_layout_map.component_layout_id 
										 from waf_master.waf_client_component_layout_map
										 where waf_client_component_layout_map.client_id = v_client_id))tab 
	  join waf_master.waf_component_layout cl on cl.component_layout_id=tab.component_layout_id 
	  and  (tab.Parent_id is null)
left join (select distinct tab.component_layout_id,cl.ref_number,tab.Parent_id,cl.component_id,mobile_image_file_name,mobile_image_path,widget_group_id,
image_path,image_file_name,component_type_id ,layout_name,widget_group_id		
		   from my_data tab
		   join  waf_master.waf_component_layout cl on cl.component_layout_id=tab.component_layout_id 
		   and  (tab.Parent_id is not  null)) as row 
	  on row.Parent_id=tab.component_layout_id
	  group by tab.component_layout_id,cl.ref_number,cl.layout_name,cl.layout_display_name,cl.layout_desc,
	  cl.component_type_id,cl.component_id,cl.image_file_name,cl.image_path,cl.is_responsive,
	  cl.mobile_image_file_name,cl.mobile_image_path,cl.widget_group_id)r;	
	
end;

$$;


--
