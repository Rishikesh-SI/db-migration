-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_process_template_component_map_data(numeric, numeric)
-- Type: FUNCTION

-- Name: labgrl_process_template_component_map_data(numeric, numeric); Type: FUNCTION; Schema: labgrl; Owner: -
--

CREATE FUNCTION labgrl.labgrl_process_template_component_map_data(p_tempate_id numeric, p_page_id numeric, OUT p_result numeric) RETURNS numeric
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
v_template_json int[];
i int;
v_template_array int[];
v_required_entities_jsn numeric[];
begin
  select array_agg(page_id)
  into v_page_id_arr
  from labgrl.labgrl_template
  where parent_id=p_tempate_id and page_id !=0 and is_active=1 and is_deleted=0 and is_published=1
  group by is_master,template_html,mobile_html;
 
  select template_html,mobile_html ,is_master,is_deleted
 into v_temp_html,v_mobile_html,v_is_master,v_is_deleted
  from labgrl.labgrl_template
  where template_id=p_tempate_id
  ;
 

 
 raise notice 'v_required_entities_jsn %',v_required_entities_jsn;

 
 if v_is_master = 1 then

select array (select template_id from labgrl.labgrl_template
   where layout_id = p_tempate_id
 and is_master = 0
 order by template_id asc)
into v_template_array;

foreach i in array v_template_array    --v_template_json
loop

select * from labgrl.labgrl_process_template_component_map_data(i,null)
into p_result;

end loop;
 end if;

 if v_is_master =1 then
 v_page_id_arr=array[-1];
 end if;
   --raise notice '% % % %',v_temp_html,v_mobile_html,v_is_master,v_page_id_arr;
--select 1/0;

 if (v_page_id_arr is not null or v_is_master =1) then
-- select 1/0;
  begin
 
     select 1  into strict v_exist  
from labgrl.labgrl_template_component_data
where template_id=p_tempate_id limit 1;

--select 1/0;

if v_is_deleted=1 then
--select 1/0;
  delete from  labgrl.labgrl_template_component_data
  where template_id=p_tempate_id;
 
else
 

 
  delete from  labgrl.labgrl_template_component_data
  where template_id=p_tempate_id;
 
-- raise notice '% v_page_id_arr',v_page_id_arr;
 
  --select 1/0;
  -- select * from labgrl.labgrl_template_component_data;
 
  insert into labgrl.labgrl_template_component_data
select  template_id,
   template_component_map_id,
       component_id,
tab.required_entities,
other_entities,
exclude_entities,
tagged_entities,
(case when component_id=7 then (select p_assetjson
  from labgrl.labgrl_get_asset_listing_r(1, web_item_number,web_item_number,
    tab.required_entities, other_entities, null, null,
  exclude_entities ))
    when component_id=1 then
 (SELECT p_ad_json from labgrl.labgrl_get_ad_r(null, 1,tab.required_entities, 1))
when component_id=9 then
          coalesce((SELECT p_showcase_json from labgrl.labgrl_get_showcase_det_r('labgrl',template_component_map_id, tab.required_entities, tab.other_entities, null, 1, coalesce(web_item_number,10), 10, is_fallback)),'[]')
when component_id = 522 then
(select p_assetjson from labgrl.labgrl_get_dynamic_asset_listing_r(1,web_item_number,web_item_number,tab.required_entities, other_entities, null, null,exclude_entities,522))

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
from labgrl.labgrl_asset_entity_map aem
where aem.asset_id = tab.page_id
and aem.asset_type_id = 11

) as page_tagged_entities,
a.alias ,
tcmap_guid,
is_responsive as is_responsive,
fetch_from,
(select  array_agg(entity_role_map_id order by entity_role_map_id )
from labgrl.labgrl_asset_entity_map aem
where aem.asset_id = tab.page_id
and aem.asset_type_id = 11
and is_required=1
) as page_req_entities,
is_fallback,
null as is_mobile,
a.is_amp,
parent_tcmap_id
from (select *,
 (case when fetch_from=1 then
uniq(sort(array_cat(tab_1.required_entities_1,page_req_entities_1)::int[])) else tab_1.required_entities_1 end ) as required_entities
 from
(select
tcm.template_id,
template_component_map_id,
component_id,
(select array_agg(entity_role_map_id order by entity_role_map_id )
from labgrl.labgrl_asset_entity_map aem
where aem.asset_id = tcm.template_component_map_id
and aem.asset_type_id = 13
and aem.is_required = 1
) as required_entities_1,
(select  array_agg(entity_role_map_id order by entity_role_map_id )
from labgrl.labgrl_asset_entity_map aem
where aem.asset_id = tcm.template_component_map_id
and aem.asset_type_id = 13
and (aem.is_required = 0 or aem.is_required is null)
) as other_entities,
(select  array_agg(entity_role_map_id order by entity_role_map_id )
from labgrl.labgrl_asset_entity_map aem
where aem.asset_id = tcm.template_component_map_id
and aem.asset_type_id = 13
and aem.is_required = 2
) as exclude_entities,

(case when fetch_from=1 THEN

(select  uniq(sort(array_cat(array_agg(aem.entity_role_map_id order by aem.entity_role_map_id ),(select array_agg(am.entity_role_map_id order by am.entity_role_map_id )
from labgrl.labgrl_asset_entity_map am
where am.asset_id in (select * from unnest(v_page_id_arr))
and am.asset_type_id = 11
and am.is_required=1)
)::int[]))
from labgrl.labgrl_asset_entity_map aem
where aem.asset_id = tcm.template_component_map_id
and aem.asset_type_id = 13

)  
else
(select  array_agg(entity_role_map_id order by entity_role_map_id )
from labgrl.labgrl_asset_entity_map aem
where aem.asset_id = tcm.template_component_map_id
and aem.asset_type_id = 13

) end) as tagged_entities  ,
'{}'::jsonb as data,
(select  array_agg(entity_role_map_id order by entity_role_map_id )
from labgrl.labgrl_asset_entity_map aem
where aem.asset_id in (select * from unnest(v_page_id_arr))
and aem.asset_type_id = 11
and is_required=1
) as page_req_entities_1,
0 as status,
current_timestamp,
current_timestamp,
(meta_info->>'lg_row')::numeric as web_item_number,
(meta_info->>'sm_row')::numeric as mob_item_number ,
unnest(v_page_id_arr) as page_id,
tcmap_guid ,
fetch_from,
(meta_info->>'fb')::numeric as is_fallback ,
t.is_responsive ,
parent_tcmap_id
from labgrl.labgrl_template_component_map tcm join
labgrl.labgrl_template t on t.template_id=tcm.template_id
where tcm.template_id=p_tempate_id and tcm.is_active=1 and tcm.is_deleted=0 and tcm.is_published=1
)tab_1)tab
left join labgrl.labgrl_page a on a.page_id=tab.page_id;


end if;

 exception when no_data_found then

-- select 1/0;
insert into labgrl.labgrl_template_component_data

select  template_id,
   template_component_map_id,
       component_id,
tab.required_entities,
tab.other_entities,
tab.exclude_entities,
tab.tagged_entities,
(case when component_id=7 then (select p_assetjson
  from labgrl.labgrl_get_asset_listing_r(1, web_item_number,web_item_number,
    tab.required_entities, tab.other_entities, null, null,
  tab.exclude_entities ))
    when component_id=1 then
 (SELECT p_ad_json from labgrl.labgrl_get_ad_r(null, 1,tab.required_entities, 1))
when component_id=9 then
          coalesce((SELECT p_showcase_json from labgrl.labgrl_get_showcase_det_r('labgrl',template_component_map_id, tab.required_entities, tab.other_entities, null, 1, coalesce(web_item_number,10), 10, is_fallback)),'[]')
       else '{}'

end ),
status,
current_timestamp,
current_timestamp,
web_item_number,
mob_item_number,
tab.page_id
,(select  array_agg(entity_role_map_id order by entity_role_map_id )
from labgrl.labgrl_asset_entity_map aem
where aem.asset_id = tab.page_id
and aem.asset_type_id = 11

) as page_tagged_entities,
a.alias,
tcmap_guid,
is_responsive as is_responsive,
fetch_from,
(select  array_agg(entity_role_map_id order by entity_role_map_id )
from labgrl.labgrl_asset_entity_map aem
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
from labgrl.labgrl_asset_entity_map aem
where aem.asset_id = tcm.template_component_map_id
and aem.asset_type_id = 13
and aem.is_required = 1
) as required_entities,
(select  array_agg(entity_role_map_id order by entity_role_map_id )
from labgrl.labgrl_asset_entity_map aem
where aem.asset_id = tcm.template_component_map_id
and aem.asset_type_id = 13
and (aem.is_required = 0 or aem.is_required is null)
) as other_entities,
(select  array_agg(entity_role_map_id order by entity_role_map_id )
from labgrl.labgrl_asset_entity_map aem
where aem.asset_id = tcm.template_component_map_id
and aem.asset_type_id = 13
and aem.is_required = 2
) as exclude_entities,

(case when fetch_from=1 THEN

(select  uniq(sort(array_cat(array_agg(entity_role_map_id order by entity_role_map_id ),v_required_entities_jsn)::int[]))
from labgrl.labgrl_asset_entity_map aem
where aem.asset_id = tcm.template_component_map_id
and aem.asset_type_id = 13

)  
else
(select  array_agg(entity_role_map_id order by entity_role_map_id )
from labgrl.labgrl_asset_entity_map aem
where aem.asset_id = tcm.template_component_map_id
and aem.asset_type_id = 13

) end) as tagged_entities ,
'{}'::jsonb as data,
0 as status,
current_timestamp,
current_timestamp,
(meta_info->>'lg_row')::numeric as web_item_number,
(meta_info->>'sm_row')::numeric as mob_item_number ,
unnest(v_page_id_arr) as page_id,
tcmap_guid ,
fetch_from,
(meta_info->>'fb')::numeric as is_fallback,
t.is_responsive,
parent_tcmap_id
from labgrl.labgrl_template_component_map tcm
join labgrl.labgrl_template t on t.template_id=tcm.template_id
where tcm.template_id=p_tempate_id and tcm.is_active=1 and tcm.is_deleted=0 and tcm.is_published=1
)tab
left join labgrl.labgrl_page a on a.page_id=tab.page_id;

end ;
end if;

update labgrl.labgrl_template_component_data
set is_mobile=0
where selector in (select selector from labgrl.labgrl_template_component_data tcd
join (select a[1] as guid, row_number() over() as slno
                              from (select regexp_matches(v_temp_html,'([0-9 a-z]{8,8}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{12,12})','g') as a
) as b

) tab
on tab.guid = tcd.selector
where template_id=p_tempate_id
and parent_tcmap_id is null);

if v_mobile_html is not null then
update labgrl.labgrl_template_component_data
set is_mobile=1
where selector in (select selector from labgrl.labgrl_template_component_data tcd
join (select a[1] as guid, row_number() over() as slno
                              from (select regexp_matches(v_mobile_html,'([0-9 a-z]{8,8}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{4,4}-[0-9 a-z]{12,12})','g') as a
) as b

) tab
on tab.guid = tcd.selector
where template_id=p_tempate_id
and parent_tcmap_id is null);
end if;

update labgrl.labgrl_template_component_data tc
set is_mobile=tcd.is_mobile  from labgrl.labgrl_template_component_data tcd
where tc.parent_tcmap_id is not null and tc.template_id=p_tempate_id
and tcd.template_component_map_id=tc.parent_tcmap_id;

if p_page_id is not null or p_page_id !=0 then

select alias,
(select  array_agg(entity_role_map_id order by entity_role_map_id )
from labgrl.labgrl_asset_entity_map aem
where aem.asset_id = p.page_id
and aem.asset_type_id = 11
and is_required=1
)  into v_alias ,v_page_ent
from labgrl.labgrl_page p
where p.page_id=p_page_id and p.is_active=1 and p.is_deleted=0 ;

update labgrl.labgrl_template_component_data
set page_alias=v_alias,page_req_entity=v_page_ent
where page_id=p_page_id;

end if;

p_result:=1;

end ;
$$;


--
