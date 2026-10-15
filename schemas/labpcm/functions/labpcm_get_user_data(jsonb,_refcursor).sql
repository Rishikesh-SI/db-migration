-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_get_user_data(jsonb, refcursor)
-- Type: FUNCTION

-- Name: labpcm_get_user_data(jsonb, refcursor); Type: FUNCTION; Schema: labpcm; Owner: -
--

CREATE FUNCTION labpcm.labpcm_get_user_data(p_input_json jsonb, p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

/*
select * from labpcm.labpcm_get_user_data
(
    '{
    "opt_type": 3,
  "start_date_time": "2019-04-08 20:00:00",
  "end_date_time": "2019-04-08 23:59:59"
}',
    'a'
);
fetch all in "a";
*/

declare
	
    v_start_date_time timestamp;
    v_end_date_time timestamp;
    v_opt_type numeric;
begin
	
    select p_input_json->>'start_date_time', p_input_json->>'end_date_time',p_input_json->>'opt_type'
    into v_start_date_time, v_end_date_time,v_opt_type;
    
    
    v_start_date_time := v_start_date_time::date;
    v_end_date_time := v_end_date_time::date;
    
 if v_opt_type = 1 then
    open p_user_cursor for
    select volunteer_detail_id,username,
	data->>'dob' as date_of_birth,
	data->>'email' as email,
	data->>'gender' as gender,
	data->>'address' as address,
	data->>'profile' as profile,
	data->>'mobileno' as mobile_no,
	data->>'passport' as passport,
	data->>'inst_role' as inst_role,
	data->>'last_name' as last_name,
	data->>'first_name' as first_name,
	data->>'inst_email' as inst_email,
	data->>'pled_guilty' as pled_guilty,
	data->>'aadhaar_card' as aadhaar_card,
	data->>'aadhaar_file' as aadhaar_file,
	data->>'inst_address' as inst_address,
	data->>'drug_alchohol' as drug_alchohol,
	data->>'inst_mobileno' as inst_mobile_no,
	data->>'volunteer_exp' as volunteer_exp,
	data->>'inst_role_name' as inst_role_name,
	data->>'pled_guilty_text' as pled_guilty_text,
	data->>'volunteer_exp_to' as volunteer_exp_to,
	data->>'pled_guilty_child' as pled_guilty_child,
	data->>'drug_alchohol_text' as drug_alchohol_text,
	data->>'merchandising_size' as merchandising_size,
	data->>'profile_image_file' as profile_image_file,
	data->>'volunteer_exp_from' as volunteer_exp_from,
	data->>'pled_guilty_child_text' as pled_guilty_child_text,
	data->>'purpose_procam_volunteer' as purpose_procam_volunteer,
	data->>'volunteer_cerificate_file' as volunteer_cerificate_file	
	,created_date,updated_date
     from labpcm.labpcm_volunteer_detail
	 order by  volunteer_detail_id;

    end if;
 
 if v_opt_type=2 then
  open p_user_cursor for
select 'dhm' as client_name, template_component_content_map_id as Module_iD,tccmap_name as module_name,
created_date at time zone 'ist',updated_date,is_published
from dhm.dhm_template_component_content_map
union all
select 'tcs' as client_name, template_component_content_map_id as Module_iD,tccmap_name as module_name,
created_date at time zone 'ist',updated_date,is_published
from labtcs.labtcs_template_component_content_map
union all
select 'pcm' as client_name, template_component_content_map_id as Module_iD,tccmap_name as module_name,
created_date at time zone 'ist',updated_date,is_published
from labpcm.labpcm_template_component_content_map
union all
select 'tsk' as client_name, template_component_content_map_id as Module_iD,tccmap_name as module_name,
created_date at time zone 'ist',updated_date,is_published
from tsk.tsk_template_component_content_map
union all
select 'tmmimg_upd' as client_name, template_component_content_map_id as Module_iD,tccmap_name as module_name,
created_date at time zone 'ist',updated_date,is_published
from tmmimg_upd.tmmimg_upd_template_component_content_map;
 end if;
 
 
end;

$$;


--
