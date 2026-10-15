-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: labecn_v1_get_process_data_r(jsonb)
-- Type: FUNCTION

-- Name: labecn_v1_get_process_data_r(jsonb); Type: FUNCTION; Schema: labecn_v1_bkp_29012025; Owner: -
--

CREATE FUNCTION labecn_v1_bkp_29012025.labecn_v1_get_process_data_r(p_in_json jsonb, OUT p_out_json jsonb) RETURNS jsonb
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
begin

select p_in_json->>'event_type',
	   p_in_json->'data'->>'id'
into   v_asset_type_id,
	   v_asset_id;

  
if v_asset_type_id in (1,2,4) then

select language_id ,title_alias,primary_entity_role_map_id,
secondary_entity_role_map_id ,is_published,is_trashed,web_detail_jsn,tagged_entity
into v_data_rec
from labecn_v1.labecn_v1_asset_list 
where asset_id=v_asset_id 
and asset_type_id=v_asset_type_id ;

select v_data_rec.tagged_entity into v_asset_ent;

select array(
select v_data_rec.primary_entity_role_map_id) into v_ent;
v_ent:=array_append(v_ent,v_data_rec.secondary_entity_role_map_id::int);

	select count(1) into v_count from labecn_v1.labecn_v1_asset_draft
	where asset_type_id=v_asset_type_id and asset_id=v_asset_id;
 
	if v_count > 1 then
	
		select version_number into v_version_number from labecn_v1.labecn_v1_asset_draft
		where asset_type_id=v_asset_type_id and asset_id=v_asset_id order by version_number desc
		limit 1;

		select asset_data into v_asset_data from labecn_v1.labecn_v1_asset_draft
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

elsif v_asset_type_id=16 then

select array(
select ad_position
from labecn_v1.labecn_v1_advertisement
where ad_id=v_asset_id
and is_published=1 and is_deleted=0 and is_active=1
	) into v_ent;
elsif v_asset_type_id=8 then
select req_entity into v_ent
from labecn_v1.labecn_v1_template_component_data where template_component_map_id=v_asset_id
and component_id=9;

elsif v_asset_type_id=20 then
select array(select tagged_entity from labecn_v1.labecn_v1_press_release_master where press_release_id=v_asset_id) into v_asset_ent;

end if;

if v_asset_type_id in (1,2,4) then
--raise notice 'v_asset_ent%',v_asset_ent;
select '{"list":'||jsonb_agg(row)::text||'}' into p_out_json 
from ( select * from (
 select ab.template_component_map_id,ab.template_id,
ab.component_id,ab.widget_data,ab.page_entity,ab.req_entity,ab.tagged_entity,
array_remove(uniq(sort(array_cat(req_entity,(case when fetch_from=1 then page_entity end) )::int[])::int[]),4) as entity,
string_to_array((case when (select is_master from labecn_v1.labecn_v1_template where template_id=ab.template_id)=1
then (select string_agg(c.alias||'~'||c.page_id,',') from labecn_v1.labecn_v1_template a
join labecn_v1.labecn_v1_page c on c.page_id=a.page_id
where a.parent_id in (select template_id from labecn_v1.labecn_v1_template b where b.layout_id=ab.template_id )
and a.is_active=1 and a.is_deleted=0 and a.is_published=1) 
else string_agg(ab.page_alias||'~'||ab.page_id,',' order by ab.page_id) end),',','yy' )as page_alias,

selector,
fetch_from,
is_responsive,
page_req_entity,
is_mobile,
is_amp	
from labecn_v1.labecn_v1_template_component_data  ab
group by ab.template_component_map_id,template_id,ab.component_id,
ab.widget_data,page_entity,req_entity,tagged_entity,selector,fetch_from,
	is_responsive,page_req_entity,is_mobile,is_amp	
order by ab.template_component_map_id,template_id,ab.component_id
)tab
where v_asset_ent @>(case when fetch_from=1 then 
	 uniq(sort(array_cat(req_entity,page_req_entity)::int[])) else req_entity end )
and 	component_id in (7,512,9)   	  
) row;
elseif v_asset_type_id in (20) then

select '{"list":'||jsonb_agg(row)::text||'}' into p_out_json 
from ( select * from (
 select ab.template_component_map_id,ab.template_id,
ab.component_id,ab.widget_data,ab.page_entity,ab.req_entity,ab.tagged_entity,
array_remove(uniq(sort(array_cat(req_entity,(case when fetch_from=1 then page_entity end) )::int[])::int[]),4) as entity,
string_to_array((case when (select is_master from labecn_v1.labecn_v1_template where template_id=ab.template_id)=1
then (select string_agg(c.alias||'~'||c.page_id,',') from labecn_v1.labecn_v1_template a
join labecn_v1.labecn_v1_page c on c.page_id=a.page_id
where a.parent_id in (select template_id from labecn_v1.labecn_v1_template b where b.layout_id=ab.template_id )
and a.is_active=1 and a.is_deleted=0 and a.is_published=1) 
else string_agg(ab.page_alias||'~'||ab.page_id,',' order by ab.page_id) end),',','yy' )as page_alias,

selector,
fetch_from,
is_responsive,
page_req_entity,
is_mobile,
is_amp	
from labecn_v1.labecn_v1_template_component_data  ab
group by ab.template_component_map_id,template_id,ab.component_id,
ab.widget_data,page_entity,req_entity,tagged_entity,selector,fetch_from,
	is_responsive,page_req_entity,is_mobile,is_amp	
order by ab.template_component_map_id,template_id,ab.component_id
)tab
where v_asset_ent @>entity  
and 	component_id in (432)   	  
) row
;

else

select '{"list":'||jsonb_agg(row)::text||'}' into p_out_json 
from ( select * from (
 select ab.template_component_map_id,ab.template_id,c.is_master,
ab.component_id,ab.widget_data,ab.page_entity,ab.req_entity,ab.tagged_entity,
array_remove(uniq(sort(array_cat(tagged_entity,(case when fetch_from=1 then page_entity end) )::int[])::int[]),4) as entity,
string_to_array((case when (select is_master from labecn_v1.labecn_v1_template where template_id=ab.template_id)=1
then (select string_agg(c.alias||'~'||c.page_id,',') 
from labecn_v1.labecn_v1_template a
join labecn_v1.labecn_v1_page c on c.page_id=a.page_id
where a.parent_id in (select template_id from labecn_v1.labecn_v1_template b where b.layout_id=ab.template_id )
and a.is_active=1 and a.is_deleted=0 and a.is_published=1) 
else string_agg(ab.page_alias||'~'||ab.page_id,',' order by ab.page_id) end),',','yy' )as page_alias,

ab.selector,
ab.fetch_from,
ab.is_responsive,
ab.page_req_entity,
ab.is_mobile,
ab.is_amp	
from labecn_v1.labecn_v1_template_component_data  ab
join labecn_v1.labecn_v1_template c
on c.template_id = ab.template_id
group by ab.template_component_map_id,ab.template_id,c.is_master,ab.component_id,
ab.widget_data,ab.page_entity,ab.req_entity,ab.tagged_entity,ab.selector,ab.fetch_from,
	ab.is_responsive,ab.page_req_entity,ab.is_mobile,ab.is_amp	
order by ab.template_component_map_id,template_id,ab.component_id
)tab
where (case when component_id=1 then req_entity else entity end)::int[] @> v_ent
and 	component_id in (9,1) --and (case when component_id=1 then 0 else fetch_from end)=fetch_from
--and page_id<>0	  
union all
select * from (
	  select abc.template_component_map_id,abc.template_id,ac.is_master,abc.component_id,abc.widget_data,abc.page_entity,abc.req_entity,
	  abc.tagged_entity,
	array_remove(uniq(sort(array_cat(tagged_entity,(case when fetch_from=1 then page_entity end) )::int[])::int[]),4) as entity,
	  string_to_array((case when (select b.is_master from labecn_v1.labecn_v1_template b where b.template_id=abc.template_id)=1
then (select string_agg(c.alias||'~'||c.page_id,',') 
from labecn_v1.labecn_v1_template a
join labecn_v1.labecn_v1_page c on c.page_id=a.page_id
where a.parent_id in (select template_id from labecn_v1.labecn_v1_template  where layout_id=abc.template_id )
and a.is_active=1 and a.is_deleted=0 and a.is_published=1) 
else string_agg(abc.page_alias||'~'||abc.page_id,',' order by abc.page_id) end) ,',','yy')as page_alias,

abc.selector,
abc.fetch_from,
abc.is_responsive,
abc.page_req_entity,
abc.is_mobile,
abc.is_amp	
from labecn_v1.labecn_v1_template_component_data  abc
join labecn_v1.labecn_v1_template ac	
	on ac.template_id = abc.template_id
where abc.component_id =any (case when v_asset_type_id=1 then array[4,506]
						 when v_asset_type_id=2 then array[5,508]
				   		 when v_asset_type_id =4 then array[11,507]
						 when v_asset_type_id =8 then array[9]	
						 when v_asset_type_id=20 then array[432] 
						 end)
--and page_id <>0
	group by abc.template_component_map_id,abc.template_id,ac.is_master,
	component_id,widget_data,page_entity,req_entity,tagged_entity,selector,fetch_from,
abc.is_responsive,abc.page_req_entity,abc.is_mobile	,abc.is_amp  
) b where  (case when component_id=1 then req_entity
			     when component_id=9 then req_entity else entity end)::int[] @> v_ent 	  
 
 
) row
;
end if;

if v_asset_type_id=1 then
 if  (v_data_rec.is_published=1 and v_data_rec.is_trashed=0 ) then 
 select p_articlejson into v_det_json
				 from labecn_v1.labecn_v1_get_article_detail_r(v_data_rec.title_alias) ;
 end if;				 
elsif v_asset_type_id=4 then
 if  (v_data_rec.is_published=1 and v_data_rec.is_trashed=0 ) then 
 select p_videojson into v_det_json from labecn_v1.labecn_v1_get_video_detail_r(v_data_rec.title_alias) ;
end if; 
elsif v_asset_type_id=2 then
	if  (v_data_rec.is_published=1 and v_data_rec.is_trashed=0 ) then 
select p_albumjson into v_det_json from labecn_v1.labecn_v1_get_album_detail_r(v_data_rec.title_alias)  ;
end if;
end if;

p_out_json:=jsonb_set(p_out_json,'{asset_json}',coalesce(v_det_json,'{}'),true);
p_out_json:=jsonb_set(p_out_json,'{asset_type_id}',('"'||coalesce(v_asset_type_id,'0')||'"')::text::jsonb,true);

end;
$$;


--
