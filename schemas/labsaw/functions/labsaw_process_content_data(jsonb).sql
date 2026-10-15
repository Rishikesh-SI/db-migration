-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_process_content_data(jsonb)
-- Type: FUNCTION

-- Name: labsaw_process_content_data(jsonb); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_process_content_data(p_in_json jsonb, OUT p_result numeric) RETURNS numeric
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
v_asset_ent numeric[];
v_version_number numeric;
v_count numeric;
v_entity_array jsonb;
v_asset_data jsonb;

begin

select p_in_json->>'event_type',
	   p_in_json->'data'->>'id'
into   v_asset_type_id,
	   v_asset_id;
	   
if v_asset_type_id in (1,2,4) then

select language_id ,title_alias,primary_entity_role_map_id,
secondary_entity_role_map_id ,is_published,is_trashed,web_detail_jsn,tagged_entity
into v_data_rec
from labsaw.labsaw_asset_list 
where asset_id=v_asset_id 
and asset_type_id=v_asset_type_id ;

select array(
select v_data_rec.primary_entity_role_map_id) into v_ent;
v_ent:=array_append(v_ent,v_data_rec.secondary_entity_role_map_id::int);

select v_data_rec.tagged_entity into v_asset_ent;

--/*

select count(*) as v_count from labsaw.labsaw_asset_draft
where asset_type_id=v_asset_id and asset_id=v_asset_type_id;

if v_count > 1 then
	select version_number as v_version_number from labsaw.labsaw_asset_draft
	where asset_type_id=v_asset_id and asset_id=v_asset_type_id order by version_number desc
	limit 1;

	select asset_data as v_asset_data from labsaw.labsaw_asset_draft
	where asset_type_id=v_asset_id and asset_id=v_asset_type_id and version_number =v_version_number-1;

  select v_asset_data->'data'->'entitydata' into v_entity_array ;
  FOR i IN SELECT * FROM jsonb_array_elements(v_entity_array)
  LOOP

  if not exists (SELECT (i->>'entity_role_map_id')::int = ANY (v_ent)) then
  	v_ent:=array_append(v_ent,(i->>'entity_role_map_id')::int);
  end if;

  END LOOP;
 end if; 

--*/

elsif v_asset_type_id=16 then

select array(
select ad_position
from labsaw.labsaw_advertisement
where ad_id=v_asset_id
and is_published=1 and is_deleted=0 and is_active=1
	) into v_ent;
--	raise notice '%',v_ent;
--select 1/0;	
elsif v_asset_type_id=8 then
select req_entity into v_ent
from labsaw.labsaw_template_component_data where template_component_map_id=v_asset_id
and component_id=9;

end if;

--raise notice '%',v_ent;
--select 1/0;

if v_asset_type_id in (1,2,4) then
 raise notice 'v_asset_ent =%',v_asset_ent;

for i in 
	
     select 
	 template_id, 
	 template_component_map_id,
	 component_id,
	(case when fetch_from=1 then 
	 uniq(sort(array_cat(req_entity,page_req_entity)::int[])) else req_entity end ) as req_ent,	 
	 other_entity,
	 exclude_entity, 	
	 tagged_entity,page_alias,req_entity,
     array_remove(uniq(sort(array_cat(tagged_entity,page_entity)::int[])::int[]),4) as entity,
	(case when web_item_number=0 then 10 else  coalesce(web_item_number,10) end ) as web_item_number,
	(case when mob_item_number=0 then 5 else  coalesce(mob_item_number,5) end ) as mob_item_number,
	is_fallback	 
    from labsaw.labsaw_template_component_data
    where component_id =any (case when v_asset_type_id in (1,2,4) then array[7,9]
						        when v_asset_type_id=16 then array[1] 
						   		when v_asset_type_id=8 then array[9] end )
	and template_component_map_id=(case when v_asset_type_id=8 then v_asset_id
	                                else template_component_map_id end) 							
    --and tagged_entity @> v_ent::numeric[]
	 and v_asset_ent @>req_entity
	 
	
	 
loop

raise notice 'template_component_map_id =%',i.template_component_map_id;
raise notice 'template_component_map_id =%',i.req_ent;

if i.component_id=7 then 
 select p_assetjson into v_json 
 from labsaw.labsaw_get_asset_listing_r(1, i.web_item_number,i.web_item_number, 
								   						   i.req_ent, i.other_entity, null, null, 
														   i.exclude_entity );

elsif i.component_id=1 then 
--select 1/0;
 SELECT p_ad_json into v_json
				   from labsaw.labsaw_get_ad_r(null, 1,i.req_entity, 1);

raise notice '%',v_json;
--select 1/0;
elsif i.component_id=9 then

SELECT p_showcase_json into v_json
 from siwaf._get_showcase_det_r('labsaw',i.template_component_map_id, i.req_ent, null, null, 1, coalesce(i.web_item_number,10), 10, i.is_fallback)		
;
end if;

update labsaw.labsaw_template_component_data
set widget_data=coalesce(v_json,'{}'),
    status=1
where template_component_map_id=i.template_component_map_id and template_id=i.template_id;

if i.template_component_map_id=14602 then
raise notice 'v_json =%',v_json;
end if;

end loop;
else
for i in 
	
     select 
	 template_id, 
	 template_component_map_id,
	 component_id,
	(case when fetch_from=1 then 
	 uniq(sort(array_cat(req_entity,page_req_entity)::int[])) else req_entity end ) as req_ent,	 
	 other_entity,
	 exclude_entity, 	
	 tagged_entity,page_alias,req_entity,
     array_remove(uniq(sort(array_cat(tagged_entity,page_entity)::int[])::int[]),4) as entity,
	(case when web_item_number=0 then 10 else  coalesce(web_item_number,10) end ) as web_item_number,
	(case when mob_item_number=0 then 5 else  coalesce(mob_item_number,5) end ) as mob_item_number,
	is_fallback	 
    from labsaw.labsaw_template_component_data
    where component_id =any (case when v_asset_type_id in (1,2,4) then array[7,9]
						        when v_asset_type_id=16 then array[1] 
						   		when v_asset_type_id=8 then array[9] end )
	and template_component_map_id=(case when v_asset_type_id=8 then v_asset_id
	                                else template_component_map_id end) 							
    and tagged_entity @> v_ent::numeric[]
	 --and v_asset_ent @>req_entity
	 
loop

if i.component_id=7 then 
 select p_assetjson into v_json 
 from labsaw.labsaw_get_asset_listing_r(1, i.web_item_number,i.web_item_number, 
								   						   i.req_ent, i.other_entity, null, null, 
														   i.exclude_entity );

elsif i.component_id=1 then 
--select 1/0;
 SELECT p_ad_json into v_json
				   from labsaw.labsaw_get_ad_r(null, 1,i.req_entity, 1);

raise notice '%',v_json;
--select 1/0;
elsif i.component_id=9 then

SELECT p_showcase_json into v_json
 from siwaf._get_showcase_det_r('labsaw',i.template_component_map_id, i.req_ent, null, null, 1, coalesce(i.web_item_number,10), 10, i.is_fallback)		
;
end if;

update labsaw.labsaw_template_component_data
set widget_data=coalesce(v_json,'{}'),
    status=1
where template_component_map_id=i.template_component_map_id and template_id=i.template_id;

end loop;

end if;

p_result:=1;

/*exception when others 
then p_result=-1;
*/
end;
$$;


--
