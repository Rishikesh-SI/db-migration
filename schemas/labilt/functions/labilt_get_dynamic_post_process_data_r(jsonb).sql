-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_get_dynamic_post_process_data_r(jsonb)
-- Type: FUNCTION

-- Name: labilt_get_dynamic_post_process_data_r(jsonb); Type: FUNCTION; Schema: labilt; Owner: -
--

CREATE FUNCTION labilt.labilt_get_dynamic_post_process_data_r(p_in_json jsonb, OUT p_out_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
/*p_in_json jsonb:= '{
  "client_id": "stmp01",
  "event_type": "1",
  "guid": "b38290d4-fdd9-4a3e-8337-95b2407a65ec",
  "data": {
    "slugurl": "lockdown-cricket-a-social-message-redis",
    "id": "135801"
   
  }
}';*/
v_ent int[];
v_merg_ent int[];
v_lan_ent int;
v_lan_entity int[];
v_comp numeric;
i record;
v_json jsonb;
v_asset_type_id numeric;
v_asset_id numeric;
v_data_rec record;
v_det_json jsonb;
v_asset_ent numeric[];
v_count numeric;
v_version_number numeric;
v_entity_array jsonb;
v_asset_data jsonb;
v_entity json;
v_component_id numeric;
v_componentid numeric;
v_title_alias character varying;
begin

select p_in_json->>'event_type',
	   p_in_json->'data'->>'id'
into   v_asset_type_id,
	   v_asset_id;

select component_id into v_component_id 
from labilt.labilt_asset_type
where asset_type_id=v_asset_type_id;
  
if v_component_id is not null then
  
if exists(select 1 from labilt.labilt_asset_type where asset_type_id=v_asset_type_id) then

select language_id ,title_alias,primary_entity_role_map_id,
secondary_entity_role_map_id ,is_published,is_trashed,web_detail_jsn,tagged_entity
into v_data_rec
from labilt.labilt_asset_list 
where asset_id=v_asset_id 
and asset_type_id=v_asset_type_id ;

select v_data_rec.tagged_entity into v_asset_ent;

select array(
select v_data_rec.primary_entity_role_map_id) into v_ent;
v_ent:=array_append(v_ent,v_data_rec.secondary_entity_role_map_id::int);

	select count(1) into v_count from labilt.labilt_asset_draft
	where asset_type_id=v_asset_type_id and asset_id=v_asset_id;
 
	if v_count > 1 then
	
		select version_number into v_version_number from labilt.labilt_asset_draft
		where asset_type_id=v_asset_type_id and asset_id=v_asset_id order by version_number desc
		limit 1;

		select asset_data into v_asset_data from labilt.labilt_asset_draft
		where asset_type_id=v_asset_type_id and asset_id=v_asset_id and version_number =v_version_number-1;

		
	 select v_asset_data->'data'->>'entitydata' into v_entity_array ;
	 
	 
	  FOR v_entity IN SELECT * FROM json_array_elements(v_entity_array::json)
	  LOOP
	  
		v_asset_ent:=array_append(v_asset_ent,(v_entity->>'entity_role_map_id')::numeric);
	  

	  END LOOP;
	  v_asset_ent:=uniq(sort(v_asset_ent::int[]))::numeric[];
 end if;

if (v_data_rec.is_published=0 and v_data_rec.is_trashed=1 ) then 
v_det_json:=jsonb_set(v_data_rec.web_detail_jsn,'{data,status}',('"'||coalesce(2,'0')||'"')::text::jsonb,false);

end if;
/*
elsif v_asset_type_id=16 then

select array(
select ad_position
from labilt.labilt_advertisement
where ad_id=v_asset_id
and is_published=1 and is_deleted=0 and is_active=1
	) into v_ent;
elsif v_asset_type_id=8 then
select req_entity into v_ent
from labilt.labilt_template_component_data where template_component_map_id=v_asset_id
and component_id=9;

elsif v_asset_type_id=20 then
select array(select tagged_entity from labilt.labilt_press_release_master where press_release_id=v_asset_id) into v_asset_ent;
*/
end if;

if exists(select 1 from labilt.labilt_asset_type where asset_type_id=v_asset_type_id) then

	select component_id into v_componentid
	from labilt.labilt_asset_type
	where asset_type_id=v_asset_type_id and is_content_type=1;

raise notice 'v_asset_ent%',v_asset_ent;

--for i in select * from

		select '{"list":'||jsonb_agg(row)::text||'}' into p_out_json 
		from ( select * from (
		 select ab.template_component_map_id,
		 ab.template_id,
		ab.component_id,
		ab.widget_data,
		ab.page_entity,
		array_remove(uniq(sort(array_cat(req_entity,(case when fetch_from=1 then page_entity end) )::int[])::int[]),4) as entity,
		string_to_array((case when (select is_master from labilt.labilt_template where template_id=ab.template_id)=1
		then (select string_agg(c.alias||'~'||c.page_id,',') from labilt.labilt_template a
		join labilt.labilt_page c on c.page_id=a.page_id
		where a.parent_id in (select template_id from labilt.labilt_template b where b.layout_id=ab.template_id )
		and a.is_active=1 and a.is_deleted=0 and a.is_published=1) 
		else string_agg(ab.page_alias||'~'||ab.page_id,',' order by ab.page_id) end),',','yy' )as page_alias,	
		selector,
		fetch_from,
		is_responsive,
		page_req_entity,
		is_mobile,
		is_amp,
		(case when web_item_number=0 then 10 else  coalesce(web_item_number,10) end ) as web_item_number,
		(case when mob_item_number=0 then 5 else  coalesce(mob_item_number,5) end ) as mob_item_number,
		(case when fetch_from=1 then 
			 uniq(sort(array_cat(req_entity,page_req_entity)::int[])) else req_entity end ) as req_ent,	 
			 other_entity,
			 exclude_entity, 	
			 ab.req_entity,
			 ab.tagged_entity
			 
		from labilt.labilt_template_component_data  ab
		group by ab.template_component_map_id,template_id,ab.component_id,
		ab.widget_data,page_entity,req_entity,tagged_entity,selector,fetch_from,
			is_responsive,page_req_entity,is_mobile,is_amp,web_item_number,mob_item_number,exclude_entity,other_entity	
		order by ab.template_component_map_id,template_id,ab.component_id
		)tab
		where v_asset_ent @>(case when fetch_from=1 then 
			 uniq(sort(array_cat(req_entity,page_req_entity)::int[])) else req_entity end )
		and component_id = v_componentid  	  
		) row;
		raise notice 'p_out_json %',p_out_json;
		
--	loop
		
--	end loop;
--raise notice 'p_out_jsonaksja %',p_out_json->'list'->>'req_entity';
/*
	if exists(select 1 from labilt.labilt_asset_type where asset_type_id=v_asset_type_id) then

 if  (v_data_rec.is_published=1 and v_data_rec.is_trashed=0 ) then 
 
	if v_componentid = 522 then
		
		select widget_data into v_det_json from labilt.labilt_template_component_data
		where template_id=p_out_json->>'temp'
		
		select p_assetjson into v_det_json from labilt.labilt_get_dynamic_asset_listing_r(1,i.mob_item_number,i.mob_item_number,i.req_entity,i.other_entity, null, null,i.exclude_entity);
		
	elsif v_componentid = 523 then
	
		select p_dynamicjson into v_det_json from labilt.labilt_get_dynamic_post_detail_r(v_data_rec.title_alias);
		
	end if;
 
end if;
*/
	select title_alias into v_title_alias from labilt.labilt_dynamic_content_type_data
	where dynamic_content_type_data_id=(p_in_json->'data'->>'id')::int
	and content_type_id=v_asset_type_id;

	select p_dynamicjson into v_det_json from labilt.labilt_get_dynamic_post_detail_r(v_title_alias);

	p_out_json:=jsonb_set(p_out_json,'{asset_json}',coalesce(v_det_json,'{}'),true);
	p_out_json:=jsonb_set(p_out_json,'{asset_type_id}',('"'||coalesce(v_asset_type_id,'0')||'"')::text::jsonb,true);

else
p_out_json:='{"data":null}';
end if;
end if;

--end if;

end;
$$;


--
