-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_web_filter_r(numeric[])
-- Type: FUNCTION

-- Name: labbsc_dev_get_web_filter_r(numeric[]); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_web_filter_r(p_entity_role_map_id numeric[], OUT p_filter_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_ent_count numeric;
v_json jsonb ='{"data":{}}';
v_month jsonb;
v_year_json jsonb;
v_entity_role_map_id numeric[];
v_role_map_id numeric[];
v_count numeric;
v_media_type_json jsonb;
begin
 select count(distinct entity_id)
     into   v_ent_count
     from   unnest(p_entity_role_map_id)entity_id;
select array(
select
b.entity_role_map_id
from labbsc_dev.labbsc_dev_entity_master a
join labbsc_dev.labbsc_dev_entity_role_map b
on a.entity_master_id=b.entity_master_id
join (select * from unnest(p_entity_role_map_id) U(entity_role_map_id) ) as c
on  c.entity_role_map_id=b.entity_role_map_id
-- join labbsc_dev.labbsc_dev_asset_entity_map c on c.entity_role_map_id=b.entity_role_map_id
where entity_role_id in (30,31)
	)into v_entity_role_map_id ;

select p_entity_role_map_id::int[] - v_entity_role_map_id ::int[] into v_role_map_id;

select count(distinct entity_id)
     into   v_count
     from   unnest(v_role_map_id)entity_id;

select jsonb_agg(tab) from
(
select
distinct a.entity_name,
b.entity_role_map_id
from labbsc_dev.labbsc_dev_entity_master a
join labbsc_dev.labbsc_dev_entity_role_map b
on a.entity_master_id=b.entity_master_id
join labbsc_dev.labbsc_dev_asset_entity_map c on c.entity_role_map_id=b.entity_role_map_id
where entity_role_id=30
/*and  exists (select 1 from   labbsc_dev.labbsc_dev_asset_entity_map eam
														 where  eam.asset_id= c.asset_id
														 and    eam.asset_type_id = c.asset_type_id
														 and    eam.entity_role_map_id in
														  (select any_entity_role_mapid
														  from unnest(v_role_map_id) u(any_entity_role_mapid))
														  having count(1) =v_count
														 )*/
order by 1
)tab into v_year_json;

v_json:= jsonb_set(v_json,'{data,year}', coalesce(v_year_json::jsonb,'[]'), true);

select jsonb_agg(tab) from (
select distinct initcap(entity_name) as entity_name,a.entity_role_map_id,
	case when entity_name='jan' then 1
	              when entity_name='feb' then 2
				  when entity_name='mar' then 3
				  when entity_name='apr' then 4
				  when entity_name='may' then 5
				  when entity_name='jun' then 6
				  when entity_name='jul' then 7
				  when entity_name='aug' then 8
				  when entity_name='sep' then 9
				  when entity_name='oct' then 10
				  when entity_name='nov' then 11
				  when entity_name='dec' then 12
				   end as no
from labbsc_dev.labbsc_dev_entity_role_map a
join labbsc_dev.labbsc_dev_asset_entity_map c on c.entity_role_map_id=a.entity_role_map_id
join labbsc_dev.labbsc_dev_entity_master b on a.entity_master_id=b.entity_master_id
where entity_role_id=31
/*and    exists (select 1 from   labbsc_dev.labbsc_dev_asset_entity_map eam
														 where  eam.asset_id= c.asset_id
														 and    eam.asset_type_id = c.asset_type_id
														 and    eam.entity_role_map_id in
														  (select any_entity_role_mapid
														  from unnest(p_entity_role_map_id) u(any_entity_role_mapid))
														  having count(1) =v_ent_count
														 )
				-- group by entity_name,a.entity_role_map_id*/
	order by no
				)tab into v_month;
v_json:= jsonb_set(v_json,'{data,month}', coalesce(v_month::jsonb,'[]'), true);

if p_entity_role_map_id @> '{261}' then 
select jsonb_agg(tab) from
(
select
 a.entity_name,
b.entity_role_map_id
from labbsc_dev.labbsc_dev_entity_master a
join labbsc_dev.labbsc_dev_entity_role_map b
on a.entity_master_id=b.entity_master_id
--join labbsc_dev.labbsc_dev_asset_entity_map c on c.entity_role_map_id=b.entity_role_map_id
where entity_role_id=53
order by 1
)tab into v_media_type_json
;
end if;

v_json:= jsonb_set(v_json,'{data,Media_Type}', coalesce(v_media_type_json::jsonb,'[]'), true);
p_filter_json:=	v_json;
end;	
 $$;


--
