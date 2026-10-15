-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ins_update_entity_type(numeric, numeric, numeric, character varying, character varying, numeric, character varying, numeric)
-- Type: FUNCTION

-- Name: ins_update_entity_type(numeric, numeric, numeric, character varying, character varying, numeric, character varying, numeric); Type: FUNCTION; Schema: ppb; Owner: -
--

CREATE FUNCTION ppb.ins_update_entity_type(p_entity_type_id numeric, p_waf_entity_type_id numeric, p_client_id numeric, p_entity_type_name character varying, p_entity_type_desc character varying, p_updated_by numeric, p_entity_type_identifier character varying, p_search_priority numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$   

declare
v_current_timestamp timestamp;
v_entity_type_id numeric;
v_waf_entity_type_id numeric ;
begin
v_current_timestamp:= current_timestamp at time zone 'utc';

v_waf_entity_type_id:=p_waf_entity_type_id;

if p_entity_type_id is null then 

if exists (select 1 from ppb.ppb_entity_type
  where entity_type_name=p_entity_type_name )
  
  then 
 --  Group Name is already exists --
  p_result :=2;
  
  else 
  
  
    
    v_entity_type_id := nextval('ppb.seq_ppb_entity_type_id');

     if p_client_id=1 
     then 
     v_waf_entity_type_id := v_entity_type_id;

     end if;

INSERT
INTO ppb.ppb_entity_type
  (
    entity_type_id,
	waf_entity_type_id,
	client_id,
	entity_type_name,
	entity_type_desc,
	created_date,
	updated_date,
	created_by,
	updated_by,
	is_active,
	is_deleted,
	entity_type_identifier,
	search_priority
  )
  VALUES
  (
    v_entity_type_id,
    v_waf_entity_type_id,
    p_client_id,
    p_entity_type_name,
    p_entity_type_desc,
    v_current_timestamp,
    v_current_timestamp,
    p_updated_by,
    p_updated_by,
    1,
    0,
	p_entity_type_identifier,
	p_search_priority
  );
 
  p_result :=1;
  
 end if;

else 

   update ppb.ppb_entity_type
   set entity_type_name=COALESCE(p_entity_type_name,entity_type_name),
       entity_type_desc=COALESCE(p_entity_type_desc,entity_type_desc),
       updated_by=COALESCE(p_updated_by,updated_by)
   where entity_type_id=p_entity_type_id;

 p_result :=1;
end if ;

-- p_result := 1;

end;

   $$;


--
