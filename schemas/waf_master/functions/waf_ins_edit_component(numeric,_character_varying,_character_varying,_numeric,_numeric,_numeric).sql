-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_ins_edit_component(numeric, character varying, character varying, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: waf_ins_edit_component(numeric, character varying, character varying, numeric, numeric, numeric); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_ins_edit_component(p_component_id numeric, p_title character varying, p_component_desc character varying, p_updated_by numeric, p_is_listing numeric, p_widget_group_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare 
-- v_temp_id varchar(200):=' ';
v_current_timestamp timestamp;
v_compguid varchar;
v_comp_id numeric;
begin 

v_current_timestamp:= current_timestamp at time zone 'utc';

if p_component_id is null then 
v_comp_id= nextval('waf_master.seq_waf_component_id');
v_compguid      := uuid_generate_v4();
insert into waf_master.waf_component
(
component_id,
title,
component_desc,
published_version_number,
created_date,
updated_date,
created_by,
updated_by,
is_active,
is_deleted,
is_published,
component_guid,
-- composition,
is_listing
)
values (
    v_comp_id,
    p_title,
    p_component_desc,
    1,
    v_current_timestamp,
    v_current_timestamp,
    p_updated_by,
    p_updated_by,
    1,0,1,v_compguid,p_is_listing);
    
    
    -- select * from waf_master.waf_widget_group_component_map 
  insert into waf_master.waf_widget_group_component_map
	(
    widget_group_component_map_id,
    widget_group_id,
    component_id ,
    order_number ,
    created_date ,
    updated_date ,
    created_by ,
    updated_by,
    is_active,
    is_deleted,
    is_published ,
    published_date,
    wgcmap_guid
	)
    values
    (nextval('waf_master.seq_waf_widget_group_component_map_id'),
     p_widget_group_id,
     v_comp_id,
     1,
     v_current_timestamp,
     v_current_timestamp,
     p_updated_by,
     p_updated_by,
     1,
     0,
     1,
     v_current_timestamp,
     uuid_generate_v4()
     ) ;
     
    p_result:=v_comp_id;
    
    
else 
if not exists(select 1 from waf_master.waf_component_layout where component_id=p_component_id )
then 
update waf_master.waf_component
set title=p_title,
    component_desc=p_component_desc,
    updated_by=p_updated_by,
    updated_date=v_current_timestamp,
    is_listing=p_is_listing
where component_id=p_component_id;

p_result:=p_component_id;
 else 
 p_result:=-2;
end if;

end if;
exception 
 when others then 
  p_result:=-1;

end 

$$;


--
