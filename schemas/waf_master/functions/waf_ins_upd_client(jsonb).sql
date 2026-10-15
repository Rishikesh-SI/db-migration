-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_ins_upd_client(jsonb)
-- Type: FUNCTION

-- Name: waf_ins_upd_client(jsonb); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_ins_upd_client(p_client_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
  v_client_id varchar;
  v_client_name text;
  v_client_display_name text;
  v_created_date timestamp;
  v_updated_date timestamp;
  v_client_end_point text;
  v_client_port_number numeric;
  v_client_database_name text;
  v_client_schema_name text;
  v_client_prefix text;
  v_client_guid varchar(50);
  v_clinet_code text;
  v_bootstrap_version numeric;
  v_client_json jsonb;
  v_is_master numeric;
  v_is_active numeric;
    v_is_deleted numeric;
    v_created_by numeric;
    v_updated_by numeric;
    v_client_code numeric;
    v_domain_url text;
	v_version_number numeric;
	v_client_draft_id numeric;
  begin
  --v_client_end_point :='192.168.100.119' ;
  --v_client_port_number:=5432;
  --v_client_database_name :='siwafdevsynced';
  v_bootstrap_version := 4;
  v_is_master := 0 ;
  v_created_date := current_timestamp at time zone 'utc';
  v_updated_date := current_timestamp at time zone 'utc';
  v_is_active := 1;
    v_is_deleted := 0;
    v_created_by := 1;
    v_updated_by := 1;
    
  insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'my_waf_ins_upd_client','logs',uuid_generate_v4(),p_client_json,current_timestamp,'labgg','logs');
  

 select p_client_json->>'clientid',
 p_client_json->>'ClientName',
 p_client_json->>'Title',
-- p_client_json->>'name',
 p_client_json->>'SchemaPrefix',
 p_client_json->>'ClientPrefix',
 p_client_json->>'clientcode',
 p_client_json->>'name',
 p_client_json->>'client_end_point',
 p_client_json->>'client_port_number',
 p_client_json->>'client_database_name'
 into v_client_id,
 v_client_name,  
 v_client_display_name, 
 v_client_schema_name,
 v_client_prefix,v_client_code,
 v_domain_url,
 v_client_end_point,v_client_port_number,v_client_database_name;

 v_client_json := p_client_json ;
 
 if v_client_code is null then
 
        v_client_guid:= uuid_generate_v4();
   		v_client_code := nextval('waf_master.seq_waf_client_id');
   		v_client_json := jsonb_set(v_client_json,'{clientcode}',('"'||v_client_code||'"')::text::jsonb,true);
   		v_client_json := jsonb_set(v_client_json,'{client_guid}',('"'||v_client_guid||'"')::text::jsonb,true);
      
   insert into waf_master.waf_client(client_id,
    client_name ,
    client_display_name,
    is_master,
    created_date,
    updated_date,
    created_by,
    updated_by,
    is_active,
    is_deleted,
    client_end_point,
    client_port_number,
    client_database_name,
    client_schema_name,
    client_prefix,
    client_guid,
    client_code,
    bootstrap_version,
    client_json,
    domain_url                                )
    select v_client_code,
	v_client_name,
	v_client_display_name,v_is_master,v_created_date,
    v_updated_date,v_created_by,v_updated_by,v_is_active,v_is_deleted,v_client_end_point,
    v_client_port_number,v_client_database_name,v_client_schema_name,v_client_prefix,v_client_guid,v_client_id,
    V_bootstrap_version,v_client_json,v_domain_url;
   
 else
 
 	if not exists(select 1 from waf_master.waf_client_draft
			  where client_id = v_client_code) then
	
		v_version_number:=1;
	
	elseif exists(select 1 from waf_master.waf_client_draft
			  	where client_id = v_client_code) then
				
		select max(version_number)+1 into v_version_number
		from waf_master.waf_client_draft
		where client_id = v_client_code;
	
	end if;

  v_client_draft_id := nextval('waf_master.seq_waf_client_draft_id');
  
 insert into waf_master.waf_client_draft
 values(v_client_draft_id,v_client_code,v_client_display_name,v_client_schema_name,v_client_prefix,v_bootstrap_version,v_client_json,v_domain_url,v_version_number,v_created_date,v_updated_date,1,0,uuid_generate_v4());
 
 
 
    update waf_master.waf_client
   set
   client_name=v_client_name,
   client_display_name=v_client_display_name,
    is_master=v_is_master,
    updated_date=v_updated_date,
    updated_by=v_updated_by,
    is_active=v_is_active,
    is_deleted=v_is_deleted,
   -- client_end_point=v_client_end_point,
    -- client_port_number=v_client_port_number,
   -- client_database_name=v_client_database_name,
    client_schema_name=v_client_schema_name,
    client_prefix=v_client_prefix,
    bootstrap_version=v_bootstrap_version,
    client_json= v_client_json,
    domain_url = v_domain_url
   where client_id = v_client_code
   and is_active= 1 
   and is_deleted=0;
  
     	
    end if;  
    
      p_data := v_client_json;   
          
  
  
  end
$$;


--
