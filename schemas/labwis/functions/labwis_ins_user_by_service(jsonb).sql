-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_ins_user_by_service(jsonb)
-- Type: FUNCTION

-- Name: labwis_ins_user_by_service(jsonb); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_ins_user_by_service(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare 
v_emailid             varchar(2000);
	v_resetkey            varchar(2000);
	v_json			  	  jsonb;
    kc_json               jsonb;
	v_sysdate			  timestamp;
	v_username            varchar(2000);
	v_password            varchar(2000);
	v_oldpassword         varchar(2000);
	v_is_valid            numeric := 0;
	v_user_id			  numeric := 0;
	v_user_name		  	  varchar(300);
	v_full_name		      varchar(300);
	v_display_name		  varchar(300);
	v_partner_id		  varchar(300);
	v_email_id		      varchar(300);
	v_profile_picture_url varchar(3000);
	v_is_active	          numeric;
	v_is_deleted	       numeric;
	v_is_published	       numeric;
	v_user_guid	           varchar(256);
	v_updated_by          numeric;
	v_failed_attempts     numeric;
	v_max_failed_attempts numeric := 3;
	v_unlock_date         timestamp;
	v_is_locked           numeric;
	v_opt_type            numeric := -1;
	v_status              numeric;
	v_reset_key           varchar(256);
	v_key_expiry_date     timestamp;
	v_rolejson            json;
	v_roledata            jsonb;
	v_role_id             numeric;
	v_userroleid          numeric;
	v_userroleguid        varchar(256);
	v_bio                 varchar(3000);
	v_user_exists            numeric;
	v_email_exists numeric;
	v_name text;
	v_email_id_check text;
	v_image_id numeric;
	v_image_name character varying(1000);
	v_image_path character varying(1000);
	v_role_name varchar(500);
	v_is_lb numeric;
	v_client_id numeric;
    v_unq_code character varying;
	v_ref_id numeric;
	
begin


	v_sysdate := current_timestamp at time zone 'utc';
	
	v_json := '{
  "success": "",
  "failed_attempts": "",
  "is_locked": "",
  "data": {
    "user_id": "",
    "user_name": "",
    "full_name": "",
    "display_name": "",
    "partner_id": "",
    "email_id": "",
    "profile_picture_url": "",
    "is_active": "",
    "is_deleted": "",
    "is_published": "",
    "user_guid": "",
    "reset_key": "",
	"role_name":""
  }
}';
	
	select p_json->'data'->>'user_id',
		   p_json->'data'->>'email_id',
		   p_json->'data'->>'user_name',
		   p_json->'data'->>'full_name',
		   p_json->'data'->>'full_name',
		   p_json->'data'->>'partner_id',
		   p_json->'data'->>'image_path',
		   p_json->'data'->>'updated_by',
		   p_json->'data'->>'guid',
		   p_json->'data'->>'reset_key',
		   p_json->'data'->>'password',
		   p_json->'data'->>'old_password',
		   p_json->'data'->>'opt_type',
		   p_json->'data'->>'role_id',
		   p_json->'data'->>'is_active',
		   p_json->'data'->>'bio',
		   p_json->'data'->>'image_id',
		   p_json->'data'->>'image_name',
		   p_json->'data'->>'ref_id'		   
		   
		   
	into   v_user_id,
		   v_emailid,
		   v_username,
		   v_full_name,
		   v_display_name,
		   v_partner_id,
		   v_profile_picture_url,
		   v_updated_by,
		   v_user_guid,
		   v_resetkey,
		   v_password,
		   v_oldpassword,
		   v_opt_type,
		   v_role_id,
		   v_is_active,
		   v_bio,
		   v_image_id,
		   v_image_name,
           v_ref_id;
		   
		v_json:=p_json;   
		   --raise notice'%',v_image_id;
		   --raise notice'%',v_image_name;
		     --raise notice'%',v_image_path;
             
             v_password:='6D685645366256665579677A7231563839534D344C413D3D';
	
	v_emailid:=replace(v_emailid,'"','');
	v_user_name:=replace(v_username,'"',''); 
	v_full_name:=replace(v_full_name,'"','');
	v_display_name:=replace(v_display_name,'"','');
	v_partner_id:=replace(v_partner_id,'"','');
	v_profile_picture_url:=replace(v_profile_picture_url,'"','');
	v_updated_by:=v_updated_by;
	v_status:=v_status;
	v_user_guid:=replace(v_user_guid,'"','');
	v_resetkey:=replace(v_resetkey,'"',''); 
	v_password:=replace(v_password,'"',''); 
	--v_oldpassword:=replace(v_oldpassword,'"','');  
	
	
			execute 'select nextval(''labwis.seq_labwis_user_id'')' 
              into v_user_id;
			  execute 'select nextval(''labwis.seq_labwis_user_role_id'')' 
               into v_userroleid;
					v_user_guid := uuid_generate_v4();
					v_userroleguid := uuid_generate_v4();
			
			execute 'insert into labwis.labwis_user(
					user_id, user_name, full_name, display_name, partner_id, email_id, profile_picture_url,
					created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published, 
					user_guid, user_pwd, reset_key, key_expiry, failed_attempts, unlock_date,bio,image_id,
					image_name,ref_id)
			values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,0,1,$13,$14,null, null, null, null,$15,$16,$17,$18)'
			using v_user_id, v_username,v_full_name,v_display_name	,v_partner_id	,
			v_emailid, v_profile_picture_url, v_sysdate, v_sysdate, v_updated_by, v_updated_by,1,
			v_user_guid, v_password,v_bio,v_image_id,v_image_name,v_ref_id;
			
			execute 'insert into labwis.labwis_user_role(user_role_id,user_id,role_id,created_date,
					updated_date,created_by,updated_by,is_active,is_deleted,is_published,user_role_guid)
				values($1,$2,$3,$4,$4,$5,$5,$6,0,1,$7)'
				using v_userroleid,v_user_id,v_role_id,v_sysdate,v_updated_by,1,v_userroleguid;
			

				execute ' select role_name 
				from  labwis.labwis_role 
				  where role_id =$1'
				  into v_role_name
				  using v_role_id;	
				
				v_json 	         := jsonb_set(v_json, '{data,user_id}', ('"'||v_user_id||'"')::text::jsonb, true);
			v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||v_user_guid||'"')::text::jsonb, true);
			v_json 	         := jsonb_set(v_json, '{data,role_name}', ('"'||v_role_name||'"')::text::jsonb, true);
            v_json           := jsonb_set(v_json, '{data,display_name}', ('"'||v_display_name||'"')::text::jsonb, true);
            
			
			p_result:=1;
	       p_data := v_json;

end;

$_$;


--
