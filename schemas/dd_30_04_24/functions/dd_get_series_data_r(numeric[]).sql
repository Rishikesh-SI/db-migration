-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_get_series_data_r(numeric[])
-- Type: FUNCTION

-- Name: dd_get_series_data_r(numeric[]); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_get_series_data_r(p_entity_role_map_id numeric[], OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
v_type_name varchar(200);
v_group_name  varchar(200);
v_entity_role_id numeric;
v_lang_map_id numeric;
begin

select b.entity_role_map_id  into  v_lang_map_id
  from dd.dd_entity_category a
  join dd.dd_entity_role_map b on a.entity_role_id=b.entity_role_id
  where category_name ='Language'  
  and b.entity_role_map_id in (select entity_id from unnest(p_entity_role_map_id) as entity_id )
  ;

select entity_name  into v_group_name
from dd.dd_entity_master a 
join dd.dd_entity_role_map b on a.entity_master_id=b.entity_master_id
where entity_role_map_id in (SELECT entity_role_mapid
                                   								  FROM UNNEST(p_entity_role_map_id) U(entity_role_mapid))
and  entity_name <> 'Series';

select entity_name into v_type_name
from dd.dd_entity_master a 
join dd.dd_entity_role_map b on a.entity_master_id=b.entity_master_id
where entity_role_map_id in (SELECT entity_role_mapid
                                   								  FROM UNNEST(p_entity_role_map_id) U(entity_role_mapid))
and  entity_name = 'Series';

raise notice '%',v_type_name;
raise notice '%',v_group_name;

-- select 1/0;
 if ((lower(v_group_name)='cricket') or (lower(v_group_name)='football'))
 then 
select entity_role_id  into v_entity_role_id
from dd.dd_entity_role a 
join  dd.dd_entity_type b on b.entity_type_id=a.entity_type_id
join dd.dd_entity_group c on c.entity_group_id=a.entity_group_id
where lower(b.entity_type_name)=  lower(v_type_name)
and lower(c.group_name)        =  lower(v_group_name);

 end if;

select  '{"data":'||array_to_json(array_agg(row_to_json(t)))||'}'
    
from (
select 
a.entity_master_id,
coalesce((case when v_lang_map_id=7926 then a.entity_name else elm.entity_name end ), a.entity_name) as entity_name,
coalesce((case when v_lang_map_id=7926 then a.entity_display_name else elm.entity_display_name end ), a.entity_display_name) as entity_display_name,
a.canonical_url,
source_object_id,
country,
entity_role_map_id,
image_available
from dd.dd_entity_master a 
join dd.dd_entity_role_map b on a.entity_master_id=b.entity_master_id
left join dd.dd_entity_language_map  elm 
on elm.entity_master_id = a.entity_master_id
where entity_role_id=v_entity_role_id
    and a.is_active=1
 )t 
 into p_json ;
 
 
 p_json :=jsonb_set(p_json, '{sports_name}',('"'||v_group_name||'"')::jsonb, true)::jsonb;
 
end;

$$;


--
