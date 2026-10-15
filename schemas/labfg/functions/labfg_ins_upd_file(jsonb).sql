-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_ins_upd_file(jsonb)
-- Type: FUNCTION

-- Name: labfg_ins_upd_file(jsonb); Type: FUNCTION; Schema: labfg; Owner: -
--

CREATE FUNCTION labfg.labfg_ins_upd_file(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

	
declare
	
	   v_json             	 jsonb;
	    v_file_json json;
         
		v_file jsonb;
		v_file_id numeric;
		v_sysdate timestamp;
    --	v_assetdraftid     	labfg.labfg_asset_draft.asset_draft_id%type;
    	--v_assetdraftguid   	 varchar(50);
    	v_imageassettypeid   numeric;     
    	v_updatedby        	 numeric;      
        v_albstatus          numeric;  
        v_file_desc text;
    -- variables for image start ========
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
begin
	
     v_json := p_json;
     
     v_sysdate:=  current_timestamp at time zone 'utc';
    
    select v_json->'data'->>'items'
	 into   v_file_json;
	 
	 select json_array_length(v_file_json) into v_array_lengh ;
	
	 v_counter := 0;
	for v_file in select * from json_array_elements(v_file_json)
			loop
                      
    select  v_file->>'file_id' ,
            v_file->>'content_source_id',
            v_file->>'file_caption',
            
            v_file->>'file_desc',
            v_file->>'file_path',
            v_file->>'copyright_text',
            v_file->>'file_name',
            v_file->>'status',
          
            v_file->>'asset_type_id',
           
            v_file->>'file_title',
			v_file->>'image_ratio',
			v_file->>'image_size',
			v_file->>'image_height',
			v_file->>'image_width'
            
          
    	into  v_file_id,
              v_filecontentsourceid,
              v_filecaption,
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
			  v_image_width
            ;
     
	     if v_file_id is null then 
	      v_file_id        := nextval('labfg.seq_labfg_image_id');
          v_guid   	 := uuid_generate_v4(); 
		  
         
		 -- v_json=jsonb_set(v_json,('{data,file_info,guid}')::text[],('"'||v_guid||'"')::jsonb,true);
		v_json= jsonb_set(v_json,('{data,items,'||v_counter::text||',guid}')::text[],
                                  ('"'||coalesce(v_guid,'')||'"')::text::jsonb,true);
		v_json= jsonb_set(v_json,('{data,items,'||v_counter::text||',file_id}')::text[],
                                  ('"'||v_file_id||'"')::text::jsonb,true);
		v_counter:=v_counter+1;
		  --v_json 	       := jsonb_set(v_json, '{data,image_id}', v_file_id::text::jsonb, true);
          --v_json 	       := jsonb_set(v_json, '{data,guid}', ('"'||v_guid||'"')::text::jsonb, true);
            
            
          insert into labfg.labfg_image(
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
		 v_sysdate, 
		 v_sysdate, 
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
	else 
	
	 update labfg.labfg_image
	  set 	image_caption=v_filecaption,
	      	image_desc=v_file_desc,
		  	image_path=v_file_path,
		  	image_file_name=v_file_name,
			image_ratio=v_image_ratio,
			image_size=v_image_size,
			image_height=v_image_height,
			image_width=v_image_width
	  where image_id=v_file_id;
	  
		end if ;
		
	 end loop;
		
       p_result := 1;
     
    	if p_result = 1 then
    		
          p_data := v_json;
          
    end if;
     
 exception
	when others then 
       	  err_msg := SQLERRM;
		  p_result := -1;
		  p_data := '{"data":{"message" :"'||coalesce(err_msg, '')||'" ,"result":"'||coalesce(p_result, 0)||'"}}';

	
end;

 

$$;


--
