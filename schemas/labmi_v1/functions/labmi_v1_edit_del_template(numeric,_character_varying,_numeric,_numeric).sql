-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_edit_del_template(numeric, character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: labmi_v1_edit_del_template(numeric, character varying, numeric, numeric); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_edit_del_template(p_temp_id numeric, p_temp_name character varying, p_flag numeric, p_updated_by numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
 

  

declare
v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
begin

insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'labmi_v1_edit_del_template','temp_id:'||p_temp_id::text ||', '||p_temp_name || ',' || p_flag::text ,uuid_generate_v4(),'{}',current_timestamp,'labtri','updated_by'||p_updated_by::text);

if p_temp_id is not null
then 
if p_flag =0 then 

update labmi_v1.labmi_v1_template 
set template_name=p_temp_name,
updated_by =p_updated_by,
updated_date=v_currenttimestamp
where template_id=p_temp_id;

end if;

if p_flag =1 then 
update labmi_v1.labmi_v1_template 
set is_deleted=1,
updated_by =p_updated_by,
updated_date=v_currenttimestamp
where template_id=p_temp_id;

end if ;

end if;

p_result:=p_temp_id;

exception
	
     when others then
    	 p_result := -1;
	

end

  

 
$$;


--
