-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_transfer_widget_library(jsonb, numeric)
-- Type: FUNCTION

-- Name: waf_transfer_widget_library(jsonb, numeric); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_transfer_widget_library(p_json jsonb, p_client_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$

--do
--$$
declare

i record;
v_count numeric;
v_ref_number text;
v_array jsonb;
j record;
v_client_id numeric;
v_component_layout_id numeric;
v_date TIMESTAMP;
v_ref_numer CHARACTER VARYING(1000);
v_layout_desc CHARACTER VARYING(1000);
v_layout_name CHARACTER VARYING(1000);
v_component_id numeric;
v_is_responsive numeric;
v_image_file_name CHARACTER VARYING(2000);
v_image_path CHARACTER VARYING(2000);
v_component_type_id numeric;
v_layout_display_name CHARACTER VARYING(1000);
v_mobile_image_file_name CHARACTER VARYING(2000);
v_mobile_image_path CHARACTER VARYING(2000);
v_order_number numeric;
v_order_number_1 numeric;

v_cnt numeric;
v_wid_id numeric;

-----child
v_child_ref_number text;
v_child_array jsonb;
v_child_comp_id numeric;
------------------------
v_child_img_path text;
v_child_layout_desc text;
v_child_layout_name text;
v_child_is_responsive numeric;
v_child_image_file_name text;
v_child_component_type_id numeric;
v_child_mob_img_path text;
v_child_lay_disp_name text;
v_child_mob_img_file_name text;
v_child_widget_group_id numeric;
v_child_component_layout_id numeric;
begin

v_date := CURRENT_TIMESTAMP at time zone 'utc';

--  v_client_id := 12;
/*
SELECT * from waf_master.waf_get_component_layout_details(
v_client_id
) into p_json;
*/
/*p_json :='';
*/
-- raise notice '% ',p_json;

for i in 
select b->>'ref_number' as ref_number, 
b->>'component_id' as component_id,
b
from(
select b from jsonb_array_elements(p_json->'widgets') b)as a 

loop
 -- raise notice '% % %',i.ref_number,i.component_id,i.b;
begin 
  
select component_layout_id ,ref_number 
into strict v_component_layout_id ,v_ref_number
from waf_master.waf_component_layout
where ref_number=i.ref_number 
and component_id::text=i.component_id
limit 1;
 
   raise notice '% % %',v_component_layout_id,v_ref_number,i.component_id;
   
   
begin 
 	select component_layout_id into strict v_component_layout_id
 	from waf_master.waf_client_component_layout_map
 	where component_layout_id=v_component_layout_id 
	and client_id=p_client_id  limit 1;

 exception when NO_DATA_FOUND then 

insert into waf_master.waf_client_component_layout_map (client_component_layout_map_id,client_id,component_layout_id,created_date,updated_date,
created_by,updated_by,is_active,is_deleted,is_published,published_date,cclmap_guid)
values(nextval('waf_master.seq_waf_client_component_layout_map_id'),p_client_id,v_component_layout_id::numeric,v_date,v_date,1,1,1,0,1,v_date,uuid_generate_v4());
                            
-- raise  notice '% ', 'Client Mapping Done';

 end ;

   
 -- raise notice '%',v_array ;
exception when NO_DATA_FOUND  then 
 -- insert new wighet layout in component layout table --
select i.b->>'ref_number',
  i.b->>'layout_desc',
  i.b->>'layout_name',
  i.b->>'component_id',
  i.b->>'is_responsive',
  i.b->>'image_file_name',
  i.b->>'image_path',
  i.b->>'component_type_id',
  i.b->>'layout_display_name',
  i.b->>'mobile_image_file_name',
  i.b->>'mobile_image_path',
  i.b->>'widget_group_id'
into  v_ref_numer,
 v_layout_desc,
 v_layout_name,
 v_component_id,
 v_is_responsive,
 v_image_file_name,
 v_image_path,
 v_component_type_id,
 v_layout_display_name,
 v_mobile_image_file_name,
 v_mobile_image_path,
 v_wid_id; 
 
                v_component_layout_id := nextval('waf_master.seq_waf_component_layout_id');
                select max(order_number) into v_order_number 
                from waf_master.waf_component_layout;
                v_order_number := v_order_number+1;
   	--raise notice '% new wighet % component id',v_ref_numer ,v_component_id;
                insert into waf_master.waf_component_layout(component_layout_id,ref_number,layout_name,layout_display_name,layout_desc,component_type_id,
           component_id,image_file_name,image_path,created_date,updated_date,created_by,updated_by,
is_active,is_deleted,is_published,published_date,component_layout_guid,order_number,
is_responsive,waf_component_layout_id,client_id,parent_id,mobile_image_file_name,mobile_image_path,widget_group_id)
 values(v_component_layout_id,v_ref_numer,v_layout_name,v_layout_display_name,v_layout_desc,v_component_type_id,
v_component_id,v_image_file_name,v_image_path,v_date,v_date,1,1,1,0,1,v_date,uuid_generate_v4(),
v_order_number,v_is_responsive,1,0,null,v_mobile_image_file_name,v_mobile_image_path,v_wid_id);
             
insert into waf_master.waf_client_component_layout_map (client_component_layout_map_id,client_id,component_layout_id,created_date,updated_date,
created_by,updated_by,is_active,is_deleted,is_published,published_date,cclmap_guid)
    values(nextval('waf_master.seq_waf_client_component_layout_map_id'),p_client_id,
  v_component_layout_id,v_date,v_date,1,1,1,0,1,v_date,uuid_generate_v4());	

end ;
-- chaild menu insertion start

select i.b->'sub_menu'
where i.b->'sub_menu' !='[null]' into v_array;
select  jsonb_array_length(v_array::jsonb)
into v_count;
-- raise notice '% child sub menu % cnt ,% component_layout id',v_array,v_count,v_component_layout_id;
if v_count >0 then 
 
 
  for v_child_array in select * from (select DISTINCT * from jsonb_array_elements(v_array::jsonb))b
   loop 
     
--  raise notice '% upeddate  % component ',v_child_array ,v_component_layout_id;
select 	v_child_array->>'ref_number',
       	v_child_array->>'component_id',
        v_child_array->>'image_path',
       	v_child_array->>'layout_desc',
       	v_child_array->>'layout_name',
       	v_child_array->>'is_responsive',
       	v_child_array->>'image_file_name',
  		v_child_array->>'component_type_id',
  		v_child_array->>'mobile_image_path',
  		v_child_array->>'layout_display_name',
  		v_child_array->>'mobile_image_file_name',
  		v_child_array->>'widget_group_id'
into   	v_child_ref_number,
      	v_child_comp_id,
  		v_child_img_path,
  		v_child_layout_desc,
  		v_child_layout_name,
  		v_child_is_responsive,
  		v_child_image_file_name,
  		v_child_component_type_id,
  		v_child_mob_img_path,
  		v_child_lay_disp_name,
  		v_child_mob_img_file_name,
  		v_child_widget_group_id;
		
-- raise notice '% update ,% comp ,%' ,v_child_ref_number,v_child_comp_id,v_component_layout_id;
    begin 
select distinct component_layout_id 
into strict v_child_component_layout_id 
from waf_master.waf_component_layout
    where ref_number =v_child_ref_number 
and component_id=v_child_comp_id limit 1;

 insert into waf_master.waf_component_layout_dependency_map(component_layout_dependency_map_id,component_layout_id,child_component_layout_id,
 order_number,created_date,updated_date,created_by,updated_by,is_active,is_deleted,
 is_published,published_date,cldmap_guid,meta_info,child_comp,child_position,child_responsive)
values(	nextval('waf_master.seq_waf_component_layout_dependency_map_id'),v_component_layout_id,v_child_component_layout_id,1,
  v_date,v_date,1,1,1,0,1,v_date,uuid_generate_v4(),null,v_child_comp_id,'NA',null); 

-- raise notice '% ',v_component_layout_id;
exception when no_data_found then 
 
  -- insert int child and layout and client mapping table --
           v_child_component_layout_id := nextval('waf_master.seq_waf_component_layout_id');
                select max(order_number) into v_order_number 
                from waf_master.waf_component_layout;
                v_order_number := v_order_number+1;
  insert into waf_master.waf_component_layout(component_layout_id,ref_number,layout_name,layout_display_name,layout_desc,component_type_id,
           component_id,image_file_name,image_path,created_date,updated_date,created_by,updated_by,
is_active,is_deleted,is_published,published_date,component_layout_guid,order_number,
is_responsive,waf_component_layout_id,client_id,parent_id,mobile_image_file_name,mobile_image_path,widget_group_id)
values(v_child_component_layout_id,v_child_ref_number,v_child_layout_name,v_child_layout_name,v_child_layout_desc,v_child_component_type_id,
v_child_comp_id,v_child_image_file_name,v_child_img_path,v_date,v_date,1,1,1,0,1,v_date,uuid_generate_v4(),
v_order_number,v_child_is_responsive,1,0,null,v_child_mob_img_file_name,v_child_mob_img_path,v_child_widget_group_id);
   -- select * from waf_master.waf_component_layout_dependency_map;
  
  insert into waf_master.waf_component_layout_dependency_map(component_layout_dependency_map_id,component_layout_id,child_component_layout_id,
 order_number,created_date,updated_date,created_by,updated_by,is_active,is_deleted,
 is_published,published_date,cldmap_guid,meta_info,child_comp,child_position,child_responsive)
values(	nextval('waf_master.seq_waf_component_layout_dependency_map_id'),v_component_layout_id,v_child_component_layout_id,1,
  v_date,v_date,1,1,1,0,1,v_date,uuid_generate_v4(),null,v_child_comp_id,'NA',null); 
  
end ;  
   end loop;
end if ;

end loop;

p_result := 1;

end;

$_$;


--
