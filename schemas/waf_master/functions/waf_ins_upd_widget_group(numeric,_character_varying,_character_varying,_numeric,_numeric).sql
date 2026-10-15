-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_ins_upd_widget_group(numeric, character varying, character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: waf_ins_upd_widget_group(numeric, character varying, character varying, numeric, numeric); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_ins_upd_widget_group(p_widget_group_id numeric, p_widget_group_name character varying, p_widget_group_desc character varying, p_updated_by numeric, p_is_published numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare 
-- v_temp_id varchar(200):=' ';
v_current_timestamp timestamp;
v_widgetguid varchar;
v_widget_group_id numeric;
begin 

v_current_timestamp:= current_timestamp at time zone 'utc';

if p_widget_group_id is null then 
  
  v_widget_group_id=nextval('waf_master.seq_waf_widget_group_id');
  v_widgetguid      := uuid_generate_v4();
  
  insert into  waf_master.waf_widget_group (
                  widget_group_id,
                  widget_group_name,
                  widget_group_desc,
                  order_number,
                  created_date,
                  updated_date,
                  created_by,
                  updated_by,
                  is_active,
                  is_deleted,
                  is_published,
                  published_date,
                  widget_group_guid
                )
   values     (
              v_widget_group_id,
              p_widget_group_name,
              p_widget_group_desc,
              1,
              v_current_timestamp,
              v_current_timestamp,
              p_updated_by,
              p_updated_by,
              1,0,
              p_is_published,
              v_current_timestamp,
              v_widgetguid
              );
              
      p_result:=v_widget_group_id;         
else 
 if not exists(select 1 from waf_master.waf_component_layout a
     join waf_master.waf_widget_group_component_map b on a.component_id=b.component_id where b.widget_group_id=p_widget_group_id )
 then 
 update waf_master.waf_widget_group
  set  widget_group_name =p_widget_group_name,
       widget_group_desc =p_widget_group_desc,
       updated_date=v_current_timestamp,
       updated_by=p_updated_by
       
       where widget_group_id=p_widget_group_id
       ;

  p_result:=p_widget_group_id;   
  else
p_result:= -2 ;
end if;
end if;

-- exception 
-- when others then 
-- p_result:=-1;

end 

$$;


--
