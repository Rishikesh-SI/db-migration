-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_ins_upd_file(jsonb)
-- Type: FUNCTION

-- Name: labbr_ins_upd_file(jsonb); Type: FUNCTION; Schema: labbr; Owner: -
--

CREATE FUNCTION labbr.labbr_ins_upd_file(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

	
declare
	
	   v_json             	 jsonb;
	    v_file_json json;
         
		v_file jsonb;
		v_file_id numeric;
		v_sysdate timestamp;
  	 v_image_size text;
	 v_guid varchar;
	 
	 v_file_name  varchar;
              v_filesize  varchar;
              v_user_guid  varchar;
			  v_file_path  varchar;
			  v_content_type  NUMERIC;
begin
	
     
     v_sysdate:=  current_timestamp at time zone 'utc';
    
                      
    select  p_json->'data'->>'file_name' ,
            p_json->'data'->>'filesize',
            p_json->'data'->>'user_guid',
            
            p_json->'data'->>'filepath',
           p_json->'data'->>'content_type'
          
          
    	into  v_file_name,
              v_filesize,
              v_user_guid,
			  v_file_path,
			  v_content_type;
			  

	     if v_file_id is null then 
	      v_file_id        := nextval('labbr.seq_labbr_image_id');
          v_guid   	 := uuid_generate_v4(); 
		  

		 -- v_json=jsonb_set(v_json,('{data,file_info,guid}')::text[],('"'||v_guid||'"')::jsonb,true);
            
          insert into labbr.labbr_image(
          image_id, 
		  content_source_id, 
          image_path, 
          image_file_name, 
		  published_version_number,
		  created_date, 
		  updated_date, 
          created_by, 
		  updated_by, 
		  is_active, 
		  is_deleted, 
		  is_published, 
		  image_size,
			  image_guid,
			  user_guid
          ) 
          values 
          (v_file_id, 
		  v_content_type,
		 v_file_path, 
		 v_file_name, 
		 1, 
		 v_sysdate, 
		 v_sysdate, 
           1,
		1, 
		1, 
		0, 
		1, 
	   v_image_size,
		   v_guid,
	   v_user_guid
          );   
	else 
	
	 update labbr.labbr_image
	  set 	image_path=v_file_path,
		  	image_file_name=v_file_name,
			image_size=v_image_size
	  where image_id=v_file_id;
	  
		end if ;
		
		
       p_result := 1;
                           			  raise notice 'p_result %',p_result;

    	if p_result = 1 then
    		
          p_data := p_json;
  
    end if;
     
 exception
	when others then 
		  p_result := -1;
		  p_data := '{"data":{"message" :"'||coalesce(p_result, 0)||'"}}';

	
end;

 

$$;


--
