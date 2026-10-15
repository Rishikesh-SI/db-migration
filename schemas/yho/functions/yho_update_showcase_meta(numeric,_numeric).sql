-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_update_showcase_meta(numeric, numeric)
-- Type: FUNCTION

-- Name: yho_update_showcase_meta(numeric, numeric); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_update_showcase_meta(p_live_blog numeric, p_asset_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare 
-- p_live_blog numeric ;
v_asset_meta jsonb;
v_template_component_asset_map_id numeric;
v_update_cont_type numeric;
begin

select asset_meta ,template_component_asset_map_id  
into v_asset_meta,v_template_component_asset_map_id
from 
yho.yho_template_component_asset_map
where 
(asset_meta->>'asset_id')::text=p_asset_id::text
and (asset_meta->>'content_type')::text in ('1','5');
if p_live_blog=1  then 
v_update_cont_type:=5;
else 
v_update_cont_type:=1;
end if;

if (v_asset_meta is not null and v_template_component_asset_map_id is not null) then 

v_asset_meta= jsonb_set(v_asset_meta,('{content_type}'),('"'||v_update_cont_type||'"')::text::jsonb,true);

update yho.yho_template_component_asset_map
set asset_meta=v_asset_meta
where template_component_asset_map_id=v_template_component_asset_map_id;

end if;
end;

$$;


--
