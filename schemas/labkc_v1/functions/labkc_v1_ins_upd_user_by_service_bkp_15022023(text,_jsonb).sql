-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_ins_upd_user_by_service_bkp_15022023(text, jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_ins_upd_user_by_service_bkp_15022023(text, jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_ins_upd_user_by_service_bkp_15022023(p_schema text, p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
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
	v_ref_id numeric;
	v_ref_guid character varying(1000);
	v_key_expiry numeric;
	v_social_link_json jsonb;
	v_is_show_listing numeric;
	v_is_password_changed numeric;
	
begin
	/*-- option type information --
	0 new user and update profile
	
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

    
	
	select p_json->'data'->>'user_id',
		   p_json->'data'->>'email_id',
		   p_json->'data'->>'user_name',
		   p_json->'data'->>'full_name',
		   p_json->'data'->>'full_name',
		   p_json->'data'->>'partner_id',
		   p_json->'data'->>'profile_picture_url',
		   p_json->'data'->>'created_date',
		   p_json->'data'->>'updated_date',
		   p_json->'data'->>'updated_by',
		   p_json->'data'->>'created_by',
		   p_json->'data'->>'user_guid',
		   p_json->'data'->>'reset_key',
		   p_json->'data'->>'user_pwd',
		   p_json->'data'->>'is_active',
		    p_json->'data'->>'bio',
		   p_json->'data'->>'image_id',
		   p_json->'data'->>'image_name',
		   p_json->'data'->>'ref_id',
		   p_json->'data'->>'is_deleted',
		   p_json->'data'->>'is_published',
		   p_json->'data'->>'key_expiry',
		   p_json->'data'->>'failed_attempts',
		   p_json->'data'->>'unlock_date',
		   p_json->'data'->>'social_link_json',
		   p_json->'data'->>'is_show_listing',
		   p_json->'data'->>'is_password_changed'
		   
		   
	into   v_user_id,
		   v_emailid,
		   v_username,
		   v_full_name,
		   v_display_name,
		   v_partner_id,
		   v_profile_picture_url,
		   v_created_date,
		   v_updated_date,
		   v_updated_by,
		   v_created_by,
		   v_user_guid,
		   v_resetkey,
		   v_password,
		   v_is_active,
		   v_bio,
		   v_image_id,
		   v_image_name,
		   v_ref_id,
		   v_is_deleted,
		   v_is_published,
		   v_key_expiry,
		   v_failed_attempts,
		   v_unlock_date,
		   v_social_link_json,
		   v_is_show_listing,
		   v_is_password_changed
		   ;
		   
		   
		   --raise notice'%',v_image_id;
		   --raise notice'%',v_image_name;
		     --raise notice'%',v_image_path;
	
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
	v_password:= '364C454D53385048354B7064425A56467071437677773D3D';  
	v_role_id := coalesce(v_role_id,21);
	
	-- select 1/0;
	
	--execute 'select coalesce(is_lb,0) 
	--from '||p_schema||'.'||p_schema||'_role
	--where role_id=$1'
	---into v_is_lb
	--using v_role_id;
	
	-- if v_opt_type = 0 then
		
		v_json:=p_json;

       execute 'select user_id,count(1)
	            from '||p_schema||'.'||p_schema||'_user
	            where ref_guid = $1
				and is_active=1 
				and is_deleted=0 
				group by 1'
	   into v_user_id,v_user_exists
	   using v_ref_guid;
	   
   --raise notice '%',v_user_id;
   
	 v_user_exists := coalesce(v_user_exists,0);
-- 	 execute 'select count(1) 
-- 	           from '||p_schema||'.'||p_schema||'_user
-- 	           where upper(email_id)=upper($1)
-- 			and is_active=1 
-- 			and is_deleted=0'
-- 	   into v_email_exists
-- 	   using v_emailid;
	
	

		if v_user_id is not null then
			

			execute 'update '||p_schema||'.'||p_schema||'_user
			set user_name=$1, full_name=$2, display_name=$3, 
			partner_id=$4, email_id=$5, profile_picture_url=$6, 
			updated_date=$7, updated_by=$8, is_active=$9, is_deleted=$14,bio=$11,image_id=$12,
			image_name=$13,is_published=$15
			where user_id=$10'
			using v_username,v_full_name,v_display_name,v_partner_id,v_emailid,v_profile_picture_url,
				  v_sysdate,v_updated_by,v_is_active,v_user_id,v_bio,v_image_id,v_image_name,v_is_deleted,v_is_published;
			
			execute 'update '||p_schema||'.'||p_schema||'_user_role
			set role_id=$1,updated_date=$2, updated_by=$3,is_active=$5
			where user_id=$4 '
			using v_role_id,v_sysdate,v_updated_by,v_user_id,v_is_active;
			
			v_json 	         := jsonb_set(v_json, '{data,user_id}', ('"'||v_user_id||'"')::text::jsonb, true);
			
			p_result:=1;
	        p_data := v_json;
		
			
		else 
		
		
			--if  ((v_user_exists=0) and (v_email_exists=0))  then 
              
			
			  execute 'select nextval('''||p_schema||'.seq_'||p_schema||'_user_id'')' 
              into v_user_id;
			  execute 'select nextval('''||p_schema||'.seq_'||p_schema||'_user_role_id'')' 
              into v_userroleid;
					v_user_guid := uuid_generate_v4();
					 v_userroleguid := uuid_generate_v4();
			
			execute 'insert into '||p_schema||'.'||p_schema||'_user(
					user_id, user_name, full_name, display_name, partner_id, email_id, profile_picture_url,
					created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published, 
					user_guid, user_pwd, reset_key, key_expiry, failed_attempts, unlock_date,bio,image_id,
					image_name,ref_id,ref_guid)
			values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,0,1,$13,$14,null, null, null, null,$15,$16,$17,$18,$19)'
			using v_user_id, v_username,v_full_name,v_display_name	,v_partner_id	,
			v_emailid, v_profile_picture_url, v_sysdate, v_sysdate, v_updated_by, v_updated_by,v_is_active,
			v_user_guid, v_password,v_bio,v_image_id,v_image_name,v_ref_id,v_ref_guid;
			
			 execute 'insert into '||p_schema||'.'||p_schema||'_user_role(user_role_id,user_id,role_id,created_date,
					updated_date,created_by,updated_by,is_active,is_deleted,is_published,user_role_guid)
				values($1,$2,$3,$4,$4,$5,$5,$6,0,1,$7)'
				using v_userroleid,v_user_id,v_role_id,v_sysdate,v_updated_by,v_is_active,v_userroleguid;

				execute ' select role_name
				from  '||p_schema||'.'||p_schema||'_role 
				  where role_id =$1'
				  into v_role_name 
				  using v_role_id;
			
			/*if v_is_lb=1 then 
			
			select client_id into v_client_id
			from waf_master.waf_client
			where client_schema_name='labstmp';
			
			
			 -- Insert into waf_master.waf_client ("client_id","client_name","client_display_name","is_master","created_date","updated_date","created_by","updated_by","is_active","is_deleted","client_end_point","client_port_number","client_database_name","client_schema_name","client_prefix","client_guid","client_code","bootstrap_version")
			 -- values (nextval('waf_master.seq_waf_client_id'),'labvt','labvt25',0,current_timestamp,current_timestamp,1,1,1,0,'192.168.100.119',5432,'siwafdevsynced','labvt','labvt',uuid_generate_v4(),'labvt01',4);

			Insert into waf_master.waf_user ("user_id","user_name","full_name","display_name","partner_id","email_id","profile_picture_url","created_date","updated_date","created_by","updated_by","is_active","is_deleted","is_published","user_guid","user_pwd","reset_key","key_expiry_date","failed_attempts","unlock_date","bio") 
			values (nextval('waf_master.seq_lb_user_id'),v_username,v_username,v_username,'1',null,null,current_timestamp,current_timestamp,1,1,1,0,1,uuid_generate_v4(),v_password,null,null,null,null,null);

			Insert into waf_master.waf_user_client_map ("user_client_map_id","user_id","client_id","created_date","updated_date","created_by","updated_by","is_active","is_deleted","is_published","published_date","ucmap_guid") 
			values (currval('waf_master.seq_lb_user_id'),currval('waf_master.seq_lb_user_id'),v_client_id,current_timestamp,current_timestamp,1,1,1,0,1,current_timestamp,uuid_generate_v4());
			
			end if;*/
			
			
			
			
			v_json 	         := jsonb_set(v_json, '{data,user_id}', ('"'||v_user_id||'"')::text::jsonb, true);
			v_json 	         := jsonb_set(v_json, '{data,guid}', ('"'||v_user_guid||'"')::text::jsonb, true);
			v_json 	         := jsonb_set(v_json, '{data,role_name}', ('"'||v_role_name||'"')::text::jsonb, true);
			
			p_result:=1;
	       p_data := v_json;
		   
		   
		   
			
		--	else 
				
				-- p_result:= 2;
		    	-- p_data  := v_json;
			
			-- end if;

			end if ;
	--end if;
--exception when others then 
-- p_result:=-1;
end;
$_$;


--
