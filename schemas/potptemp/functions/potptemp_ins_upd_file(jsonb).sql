-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: potptemp
-- Object: potptemp_ins_upd_file(jsonb)
-- Type: FUNCTION

-- Name: potptemp_ins_upd_file(jsonb); Type: FUNCTION; Schema: potptemp; Owner: -
--

CREATE FUNCTION potptemp.potptemp_ins_upd_file(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	   v_json             	 jsonb;
	    v_file_json json;
         
		v_file jsonb;
		v_file_id numeric;
		v_sysdate timestamp;
    --	v_assetdraftid     	potptemp.potptemp_asset_draft.asset_draft_id%type;
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
      v_filesize numeric;
	 v_counter numeric:=0;
begin
	
     v_json := p_json;
     
     v_sysdate:=  current_timestamp at time zone 'utc';
    
   -- select v_json->'data'->>'items'
--	 into   v_file_json;
	 
   select  v_json->'data'->>'file_id' ,
            v_json->'data'->>'content_type',
            v_json->'data'->>'file_caption',
            
            v_json->'data'->>'file_desc',
            v_json->'data'->>'filepath',
            v_json->'data'->>'copyright_text',
            v_json->'data'->>'file_name',
            v_json->'data'->>'status',
          
            v_json->'data'->>'asset_type_id',
           
            v_json->'data'->>'file_title',
			v_json->'data'->>'filesize'
            
          
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
			  v_filesize
            ;
     
	     if v_file_id is null then 
	      v_file_id        := nextval('potptemp.seq_potptemp_image_id');
          v_guid   	 := uuid_generate_v4(); 
		  
         
		 -- v_json=jsonb_set(v_json,('{data,file_info,guid}')::text[],('"'||v_guid||'"')::jsonb,true);
		v_json= jsonb_set(v_json,('{data,items,'||v_counter::text||',guid}')::text[],
                                  ('"'||coalesce(v_guid,'')||'"')::text::jsonb,true);
		v_json= jsonb_set(v_json,('{data,items,'||v_counter::text||',file_id}')::text[],
                                  ('"'||v_file_id||'"')::text::jsonb,true);
		v_counter:=v_counter+1;
		  --v_json 	       := jsonb_set(v_json, '{data,image_id}', v_file_id::text::jsonb, true);
          --v_json 	       := jsonb_set(v_json, '{data,guid}', ('"'||v_guid||'"')::text::jsonb, true);
            
            
          insert into potptemp.potptemp_image(
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
			image_size
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
		v_filesize
          );   
	else 
	
	 update potptemp.potptemp_image
	  set image_caption=v_filecaption,
	      image_desc=v_file_desc,
		  image_path=v_file_path,
		  image_file_name=v_file_name,
		  image_size=v_filesize
	  where image_id=v_file_id;
	  
		end if ;
				
       p_result := 1;
     
    	if p_result = 1 then
    		
          p_data := v_json;
          
    end if;
     
 exception
	
	when others then
		p_result := -1
		 ;
	
end;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
