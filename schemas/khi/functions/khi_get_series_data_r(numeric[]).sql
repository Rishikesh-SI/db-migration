-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_get_series_data_r(numeric[])
-- Type: FUNCTION

-- Name: khi_get_series_data_r(numeric[]); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_get_series_data_r(p_entity_role_map_id numeric[], OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_type_name varchar(200);
v_group_name  varchar(200);
v_entity_role_id numeric;
begin


select entity_name  into v_type_name
from khi.khi_entity_master a 
join khi.khi_entity_role_map b on a.entity_master_id=b.entity_master_id
where entity_role_map_id in (SELECT entity_role_mapid
                                   								  FROM UNNEST(p_entity_role_map_id) U(entity_role_mapid))
and  entity_name <> 'Series';


select entity_name into v_group_name
from khi.khi_entity_master a 
join khi.khi_entity_role_map b on a.entity_master_id=b.entity_master_id
where entity_role_map_id in (SELECT entity_role_mapid
                                   								  FROM UNNEST(p_entity_role_map_id) U(entity_role_mapid))
and  entity_name = 'Series';


select entity_role_id into v_entity_role_id
from khi.khi_entity_role a 
join  khi.khi_entity_type b on b.entity_type_id=a.entity_type_id
join khi.khi_entity_group c on c.entity_group_id=a.entity_group_id
where lower(b.entity_type_name)=lower(v_type_name)
and lower(c.group_name)        =lower(v_group_name);


select  '{"data":'||array_to_json(array_agg(row_to_json(t)))||'}'
    
from (
select 
a.entity_master_id,
entity_name,
entity_display_name,
canonical_url,
source_object_id,
country,
entity_role_map_id,
image_available
from khi.khi_entity_master a 
join khi.khi_entity_role_map b on a.entity_master_id=b.entity_master_id
where entity_role_id=v_entity_role_id
 )t 
 into p_json ;
 
end;

$$;


--
