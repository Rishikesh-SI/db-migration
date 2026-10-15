-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_ins_ambassador_program(jsonb)
-- Type: FUNCTION

-- Name: hsl_ins_ambassador_program(jsonb); Type: FUNCTION; Schema: hsl; Owner: -
--

CREATE FUNCTION hsl.hsl_ins_ambassador_program(p_regjson jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare 
     v_json jsonb ; 
     v_sysdate timestamp;
     v_ambassador_data_id numeric;    
     v_first_name character varying(300)  ;
     v_last_name character varying(300)  ;
     v_dob timestamp ;     
     v_contact_no character varying(20) ;
     v_gender character varying(10) ;
     v_created_by numeric;
     v_facebook_link character varying(1000) ;
     v_institute_name character varying(1000) ;
     v_address character varying(4000) ;
     v_email_id character varying(1000) ;
    
     
begin 

	v_json := p_regjson;
	v_sysdate:=  current_timestamp at time zone 'utc';
    
    select  v_json->'data'->>'first_name',
    		v_json->'data'->>'last_name', 
            v_json->'data'->>'date_of_birth',
            v_json->'data'->>'address',
	  		v_json->'data'->>'contact_no' ,
	  		v_json->'data'->>'gender',
	  		v_json->'data'->>'created_by',
          	v_json->'data'->>'facebook_link',
            v_json->'data'->>'email_id',
	  		v_json->'data'->>'institute_name' 
	  	 		
    	  into 
           v_first_name,
           v_last_name,
           v_dob,
           v_address,
           v_contact_no,
           v_gender,
           v_created_by,
           v_facebook_link,
           v_email_id,
           v_institute_name          
            ;
			
	 v_ambassador_data_id := nextval('hsl.seq_hsl_ambassador_data_id') ;
     
     raise notice 'facebook : %' , v_facebook_link;
     raise notice 'inst : %' ,v_institute_name ;
     
           
     insert into hsl.hsl_ambassador_data
     ( ambassador_data_id, first_name, last_name, date_of_birth, address, contact_no, gender,
       institute_name, facebook_link, ambassador_json, created_date, updated_date, created_by, updated_by,
       email_id
      )
      select v_ambassador_data_id, v_first_name, v_last_name, v_dob, v_address, v_contact_no, v_gender,
             v_institute_name, v_facebook_link, v_json, v_sysdate, v_sysdate, v_created_by, v_created_by, 
             v_email_id;
           
  
     
     p_result := 1 ; 
        
  exception 
  when others then 
  		p_result := -1 ; 
  
end ;

$$;


--
