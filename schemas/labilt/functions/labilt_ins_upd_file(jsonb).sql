-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_ins_upd_file(jsonb)
-- Type: FUNCTION

-- Name: labilt_ins_upd_file(jsonb); Type: FUNCTION; Schema: labilt; Owner: -
--

CREATE FUNCTION labilt.labilt_ins_upd_file(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
	
declare	
	    v_json jsonb;
	    v_file_json json;
		v_file jsonb;
		v_file_id numeric;
		 v_sysTimeStamp timestamp;
    	v_imageassettypeid   numeric;     
    	v_updatedby        	 numeric;      
        v_albstatus          numeric;  
        v_file_desc text;
    	v_filecaption varchar(2000);
		v_file_path    varchar(2000);
		v_filecontentsourceid  numeric;
		v_copyright_text varchar(2000);
        v_file_name     varchar(2000);
        v_status numeric;
		v_asset_type_id numeric;
		v_guid varchar(2000);
		v_array_index numeric ;
		v_array_lengh numeric;
		 v_counter numeric:=0;
		 err_msg text;
		 v_image_ratio  text;
		 v_image_size text;
		 v_image_height text;
		 v_image_width text;
		 v_module text;
		 v_student_id text;
		 v_datajson jsonb;
		 v_user_guid text;
		 v_school_name text;
		 v_custom_id numeric;
		 v_student_full_name text;
begin
	
     v_json := p_json;     
     v_sysTimeStamp:=  current_timestamp at time zone 'utc';    
                      
    select  p_json ->'data'->>'file_id' ,
            p_json ->'data'->>'content_source_id',
            p_json ->'data'->>'file_caption',
            p_json ->'data'->>'school_name',
			p_json ->'data'->>'student_full_name',
            p_json ->'data'->>'file_desc',
            p_json ->'data'->>'filepath',
            p_json ->'data'->>'copyright_text',
            p_json ->'data'->>'file_name',
            p_json ->'data'->>'status',
            p_json ->'data'->>'asset_type_id',
            p_json ->'data'->>'file_title',
			p_json ->'data'->>'image_ratio',
			p_json ->'data'->>'filesize',
			p_json ->'data'->>'image_height',
			p_json ->'data'->>'image_width',
			p_json ->'data'->>'module',
			p_json ->'data'->>'student_id',
			p_json ->'data'
           
          
    	into  v_file_id,
              v_filecontentsourceid,
              v_filecaption,
			  v_school_name,
			  v_student_full_name,
              v_file_desc,
			  v_file_path,
			  v_copyright_text,
			  v_file_name ,
			  v_status,
			  v_asset_type_id,
			  v_guid,
			  v_image_ratio,
			  v_image_size,
			  v_image_height,
			  v_image_width,
			  v_module,
			  v_student_id,
			  v_datajson;
     	
	    v_custom_id       := nextval('labilt.seq_labilt_custom_id');
		v_user_guid       := nextval('labilt.seq_labilt_user_guid');
	
		INSERT INTO labilt.labilt_custom_web_json
	            (custom_id,
	             student_id,
	             school_name,
	             created_date,
	             updated_date,
	             user_guid,
	             module_name,
	             datajson)
	      VALUES      
		  		( v_custom_id,
	              v_student_id,
	              v_school_name,
	              v_sysTimeStamp,
	              v_sysTimeStamp,
	              v_user_guid,
	              v_module,
	              v_datajson ); 
		
		v_file_id   := nextval('labilt.seq_labilt_image_id');
	    v_guid   	 := uuid_generate_v4(); 
		        
	   insert into labilt.labilt_image(
	          image_id, 
			  content_source_id, 
			  image_caption, 	
			  image_meta, 
			  image_desc, 
	          image_path, 
	          copyright_text, image_file_name, published_version_number, created_date, updated_date, 
	          created_by, updated_by, is_active, is_deleted, is_published, 
			  image_guid,
			  show_copyright,
			  content_source_link,
			  title_alias,
			  asset_type_id,
			  image_ratio,
			  image_size,
			  image_height,
			  image_width
	          ) 
	          values 
	          (v_file_id, 
			  v_filecontentsourceid,
			  v_filecaption, 
			  null, 
			 v_file_desc, 
			 v_file_path, 
	         v_copyright_text, 
			 v_file_name, 
			 1, 
			 v_sysTimeStamp, 
			 v_sysTimeStamp, 
	        1,
			1, 
			1, 
			0, 
			v_status, 
			v_guid,
			null,
			null, 
			v_file_name,
			v_asset_type_id,
			v_image_ratio,
			v_image_size,
			v_image_height,
			v_image_width
	          );   
		
	       p_data := p_json;

	   
end;
 

$$;


--
