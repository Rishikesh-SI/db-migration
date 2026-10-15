-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_ins_upd_author_data(jsonb)
-- Type: FUNCTION

-- Name: labtri_ins_upd_author_data(jsonb); Type: FUNCTION; Schema: labtri; Owner: -
--

CREATE FUNCTION labtri.labtri_ins_upd_author_data(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	v_ref_id varchar;
	v_first_name character varying;
	v_last_name character varying;
	v_email_id character varying;
	v_user_guid character varying;
	v_additional_info jsonb;
	v_password varchar;
	v_user_name varchar;
	v_display_name varchar;
	v_user_id numeric;
	v_is_deleted numeric;
	v_is_active numeric;
	v_created_by smallint;
	v_updated_by smallint;
	v_is_published smallint;
	v_user_role_id numeric;
begin

/*
 "author_email": "",
    "author_first_name": "Editor",
    "ref_author_id": "ae404d54-d57c-470f-b9c7-5dd5125698ab",
    "author_last_name": "Sample",
    "author_password": "",
*/

select 
		   p_json->'data'->>'author_first_name',
		   p_json->'data'->>'author_email',
		   p_json->'data'->>'ref_author_id',
		   p_json->'data'->>'author_last_name',
		   p_json->'data'->>'add_info',
		   p_json->'data'->>'is_active',
		  p_json->'data'->>'is_deleted'
		   
into 
	v_first_name,
	v_email_id,
	v_ref_id,
	v_last_name,
	v_additional_info,
	v_is_active ,
	v_is_deleted;
	
	
	v_password := '68336364527A4676694E797462442B6B5A6E597461773D3D';
							v_user_name := v_first_name || ' ' || v_last_name;
							v_display_name := v_first_name ;
							
	
			if not exists (select 1 from labtri.labtri_user WHERE ref_id =v_ref_id) then
							
							
							v_user_id:=nextval('labtri.seq_labtri_user_id');
							v_user_role_id:=nextval('labtri.seq_labtri_user_role_id');
							
							insert into labtri.labtri_user(user_id,user_name,full_name,display_name,email_id,created_date,updated_date,user_guid,user_pwd,ref_id,is_active,is_deleted,created_by,updated_by,is_published)
							values(v_user_id , v_user_name , v_user_name , v_display_name , v_email_id , current_timestamp , current_timestamp,uuid_generate_v4(),v_password,v_ref_id,v_is_active,v_is_deleted,1,1,v_is_active);


							insert into labtri.labtri_user_role(user_role_id,user_id,role_id,created_date,updated_date,created_by,updated_by,is_active,is_deleted,is_published,user_role_guid)
							values(v_user_role_id , v_user_id , 41 , v_display_name , v_email_id , current_timestamp , current_timestamp,41,41,1,0,1,uuid_generate_v4());

							p_data:='{
							"data": {
							"status":"1"
							}
							}';	
						  
					elsif exists(select 1 from labtri.labtri_user WHERE ref_id =v_ref_id) then
					
					update labtri.labtri_user set full_name = v_user_name, email_id = v_email_id , display_name = v_first_name,
						 is_deleted = v_is_deleted,is_active = v_is_active , is_published = v_is_active
					where ref_id =v_ref_id;
					
				   p_data:='{
							"data": {
							"status":"1"
							}
							}';	
		 else
		 	p_data:='{
							"data": {
							"status":"0"
							}
							}';	
			   end if;

end;
$$;


--
