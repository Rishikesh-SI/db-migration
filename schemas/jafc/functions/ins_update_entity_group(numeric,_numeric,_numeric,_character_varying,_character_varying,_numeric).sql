-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ins_update_entity_group(numeric, numeric, numeric, character varying, character varying, numeric)
-- Type: FUNCTION

-- Name: ins_update_entity_group(numeric, numeric, numeric, character varying, character varying, numeric); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.ins_update_entity_group(p_entity_group_id numeric, p_waf_entity_group_id numeric, p_client_id numeric, p_group_name character varying, p_group_desc character varying, p_updated_by numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_current_timestamp timestamp;
v_entity_group_id numeric;
v_waf_entity_group_id numeric ;
begin
v_current_timestamp:= current_timestamp at time zone 'utc';

v_waf_entity_group_id:=p_waf_entity_group_id;

if p_entity_group_id is null then 

if exists (select 1 from jafc.jafc_entity_group
  where group_name=p_group_name )
  
  then 
 --  group name is already exists --
  p_result :=2;
  
  else 
  
  
    
v_entity_group_id := nextval('jafc.seq_jafc_entity_group_id');

     if p_client_id=1 
     then 
     v_waf_entity_group_id := v_entity_group_id;

     end if;

insert
into jafc.jafc_entity_group
  (
    entity_group_id,
    waf_entity_group_id,
    client_id,
    group_name,
    group_desc,
    created_date,
    update_date,
    created_by,
    updated_by,
    is_active,
    is_deleted
  )
  values
  (
    v_entity_group_id,
    v_waf_entity_group_id,
    p_client_id,
    p_group_name,
    p_group_desc,
    v_current_timestamp,
    v_current_timestamp,
    p_updated_by,
    p_updated_by,
    1,
    0
  );
 
  p_result :=1;
  
 end if;

else 

   update jafc.jafc_entity_group
   set group_name=coalesce(p_group_name,group_name),
       group_desc=coalesce(p_group_desc,group_desc),
       updated_by=coalesce(p_updated_by,updated_by)
   where entity_group_id=p_entity_group_id;

 p_result :=1;
end if ;

-- p_result := 1;

end;

$$;


--
