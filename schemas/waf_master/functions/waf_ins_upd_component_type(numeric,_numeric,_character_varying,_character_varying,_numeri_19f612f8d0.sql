-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_ins_upd_component_type(numeric, numeric, character varying, character varying, numeric, character varying, character varying)
-- Type: FUNCTION

-- Name: waf_ins_upd_component_type(numeric, numeric, character varying, character varying, numeric, character varying, character varying); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_ins_upd_component_type(p_component_type_id numeric, p_component_id numeric, p_type_name character varying, p_type_display_name character varying, p_updated_by numeric, p_image_file_name character varying, p_image_path character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare 
-- v_temp_id varchar(200):=' ';
v_current_timestamp timestamp;
v_comp_typeguid varchar;
v_comp_type_id numeric;
v_ord_number numeric;

v_compguid varchar(2000);
begin 

v_current_timestamp:= current_timestamp at time zone 'utc';

select max(order_number)into v_ord_number from waf_master.waf_component_type ;
if p_component_type_id is null then 

v_comp_type_id=nextval('waf_master.seq_waf_component_type_id');
v_compguid      := uuid_generate_v4();
insert into waf_master.waf_component_type
     (
          component_type_id,
          type_name,
          type_display_name,
          image_file_name,
          image_path,
          component_id,
          created_date,
          updated_date,
          created_by,
          updated_by,
          is_active,
          is_deleted,
          is_published,
          published_date,
          component_type_guid,
          order_number,
          waf_component_type_id,
          client_id
     )

values
    (
         v_comp_type_id,
         p_type_name,
         p_type_display_name,
         p_image_file_name,
         p_image_path,
         p_component_id,
         v_current_timestamp,
         v_current_timestamp,
         p_updated_by,
         p_updated_by,
         1,
         0,
         1,
         v_current_timestamp,
         v_compguid,
         (v_ord_number+1),
         0,
        1
      );
      
      p_result:=v_comp_type_id;
      
      
      
      else 
      
      update waf_master.waf_component_type
      set 
          type_name =p_type_name,
          type_display_name=p_type_display_name,
          component_id=p_component_id,
          image_file_name=p_image_file_name,
          image_path =p_image_path,
          updated_date=v_current_timestamp,
          updated_by=p_updated_by 
      where component_type_id=p_component_type_id;

 p_result:=p_component_type_id;

end if;

-- exception 
-- when others then 
-- p_result:=-1;

end 

$$;


--
