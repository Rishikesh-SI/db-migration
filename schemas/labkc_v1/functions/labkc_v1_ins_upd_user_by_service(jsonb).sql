-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_ins_upd_user_by_service(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_ins_upd_user_by_service(jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_ins_upd_user_by_service(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare 
	
	v_emailid             varchar(2000);
	v_resetkey            varchar(2000);
	v_json			  	  jsonb;
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
	v_created_date		  timestamp;
	v_updated_date		  timestamp;
	v_is_active	          numeric;
	v_is_deleted	       numeric;
	v_is_published	       numeric;
	v_user_guid	           varchar(256);
	v_updated_by          numeric;
	v_created_by          numeric;
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
	v_ref_id character varying;
	--v_ref_guid character varying(1000);
	v_key_expiry numeric;
	v_social_link_json jsonb;
	v_is_show_listing numeric;
	v_is_password_changed numeric;
	p_schema character varying;
	v_prefix_schema character varying;
	v_user_code character varying;
    v_language_id numeric;
begin
	/*
    {
  "success": "",
  "failed_attempts": "",
  "is_locked": "",
  "data": {
    "user_id": null,
    "email_id": "nilesh.d.maurya@sportzinteractive.net",
    "user_name": "Nilesh",
    "full_name": "Nilesh Maurya",
    "display_name": "Nilesh",
    "partner_id": "",
    "profile_picture_url": "",
    "created_date": "2023-02-03 06:29:33.066392+00",
    "updated_date": "2023-02-03 06:29:33.066392+00",
    "created_by": 1,
    "updated_by": 1,
    "user_guid": "",
    "reset_key": "",
    "user_pwd": "",
    "is_active": 1,
    "bio": "Developer in SI",
    "image_id": null,
    "image_name": "",
    "ref_id": "KKR123456789",
    "is_deleted": 0,
    "is_published": 1,
    "key_expiry": null,
    "failed_attempts": null,
    "unlock_date": null,
    "social_link_json": null,
    "is_show_listing": null,
    "is_password_changed": null
  }
}
	*/
	v_sysdate := current_timestamp at time zone 'utc';
	v_key_expiry_date := v_sysdate + interval '15 minutes';
	
	p_schema := 'labkc_v1';
	
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
	"role_name":"",
	"ref_id" : "" ,
	"ref_guid" : ""
  }
}';

    
	
	select p_json->'data'->>'bio',
           p_json->'data'->>'user_id',
		   p_json->'data'->>'email_id',
           p_json->'data'->>'image_id',
           p_json->'data'->>'opt_type',
           p_json->'data'->>'password',
           p_json->'data'->>'user_code',
           p_json->'data'->>'full_name',
		   p_json->'data'->>'user_name',
		   p_json->'data'->>'full_name',
           p_json->'data'->>'language_id',
		   p_json->'data'->>'profile_picture_url',
		   p_json->'data'->>'is_active',          
		   p_json->'data'->>'image_name',
           p_json->'data'->>'image_path'
           
           

		   
		   
	into   v_bio,
           v_user_id,
		   v_emailid,
           v_image_id,
           v_opt_type,
           v_password,
           v_user_code,
           v_display_name,
		   v_username,
		   v_full_name,
		   v_language_id,
           v_profile_picture_url,
           v_is_active,
           v_image_name,
           v_image_path
		   ;
           
           select  p_json->>'schemaprefix' into p_schema;
		   

	
	v_emailid:=replace(v_emailid,'"','');
	v_username:=replace(v_username,'"',''); 
	v_full_name:=replace(v_full_name,'"','');
	v_display_name:=replace(v_display_name,'"','');
	v_partner_id:=replace(v_partner_id,'"','');
	v_profile_picture_url:=replace(v_profile_picture_url,'"','');
	v_updated_by:=v_updated_by;
	v_status:=v_status;
	v_user_guid:=replace(v_user_guid,'"','');
	v_resetkey:=replace(v_resetkey,'"',''); 
    v_password:=replace(v_password,'"',''); 
	--v_password:= '364C454D53385048354B7064425A56467071437677773D3D'; 
	v_role_id := coalesce(v_role_id,21);
    
    v_json :=p_json;
   
	
	SELECT SUBSTRING (p_schema FROM 4) into v_prefix_schema;

	if (lower(v_prefix_schema)='kkr_v1') THEN
	v_role_id:=61;
	elsif (lower(v_prefix_schema)='adkr') THEN
	v_role_id:=81;
	elsif (lower(v_prefix_schema)='tkr') THEN
	v_role_id:=101;
	ELSE
	v_role_id:=21;
	end if;
	
    execute 'select count(1)
	            from labkc_v1.labkc_v1_user
	            where lower(user_code)=lower($1)
				and is_active=1 
				and is_deleted=0'
	   into v_user_exists
	   using v_user_code;
       
       if (v_user_id is not null and v_user_exists = 1) then
       
       execute 'update labkc_v1.labkc_v1_user
			set user_name=$1, full_name=$2, display_name=$3, 
			partner_id=$4, email_id=$5, profile_picture_url=$6, 
			updated_date=$7, updated_by=$8, is_active=$9, is_deleted=0,bio=$10,image_id=$11,
			image_name=$12
			where user_code=$13'
			using v_username,v_full_name,v_display_name,v_partner_id,v_emailid,v_profile_picture_url,
				  v_sysdate,v_updated_by,v_is_active,v_bio,v_image_id,v_image_name,v_user_code;
			
			execute 'update labkc_v1.labkc_v1_user_role ur
			set role_id=$1,updated_date=$2, updated_by=$3,is_active=$4 
            where user_id in (select user_id from labkc_v1.labkc_v1_user where user_code=$5)'
			using v_role_id,v_sysdate,v_updated_by,v_is_active,v_user_code;	

			p_result:=1;
	        p_data := v_json;
            
       else 
       
             execute 'select nextval(''labkc_v1.seq_labkc_v1_user_id'')' 
              into v_user_id;
			  execute 'select nextval(''labkc_v1.seq_labkc_v1_user_role_id'')' 
               into v_userroleid;
					v_user_guid := uuid_generate_v4();
					v_userroleguid := uuid_generate_v4();
			
			execute 'insert into labkc_v1.labkc_v1_user(
					user_id, user_name, full_name, display_name, partner_id, email_id, profile_picture_url,
					created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published, 
					user_guid, user_pwd, reset_key, key_expiry, failed_attempts, unlock_date,bio,image_id,
					image_name,user_code)
			values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,0,1,$13,$14,null, null, null, null,$15,$16,$17,$18)'
			using v_user_id, v_username,v_full_name,v_display_name	,v_partner_id	,
			v_emailid, v_profile_picture_url, v_sysdate, v_sysdate, v_updated_by, v_updated_by,v_is_active,
			v_user_guid, v_password,v_bio,v_image_id,v_image_name,v_user_code;
			
			execute 'insert into labkc_v1.labkc_v1_user_role(user_role_id,user_id,role_id,created_date,
					updated_date,created_by,updated_by,is_active,is_deleted,is_published,user_role_guid)
				values($1,$2,$3,$4,$4,$5,$5,$6,0,1,$7)'
				using v_userroleid,v_user_id,v_role_id,v_sysdate,v_updated_by,v_is_active,v_userroleguid; 
                
                
            v_json 	         := jsonb_set(v_json, '{data,user_id}', ('"'||v_user_id||'"')::text::jsonb, true);
			v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||v_user_guid||'"')::text::jsonb, true);
			--v_json 	         := jsonb_set(v_json, '{data,role_name}', ('"'||v_role_name||'"')::text::jsonb, true);
	
	   p_result:=1;
       p_data:=v_json;
       
       end if;
	   
       
    
	--end if;
--exception when others then 
-- p_result:=-1;
end;
$_$;


--
