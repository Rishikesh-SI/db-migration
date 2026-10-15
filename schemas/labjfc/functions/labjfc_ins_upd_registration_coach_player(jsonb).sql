-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: labjfc_ins_upd_registration_coach_player(jsonb)
-- Type: FUNCTION

-- Name: labjfc_ins_upd_registration_coach_player(jsonb); Type: FUNCTION; Schema: labjfc; Owner: -
--

CREATE FUNCTION labjfc.labjfc_ins_upd_registration_coach_player(p_regjson jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare 
     v_json jsonb ; 
     v_sysdate timestamp;
     v_registration_form_id numeric;
     v_labjfc_gr_pin character varying(100) ;
     v_name character varying(300)  ;
     v_dob timestamp ;
     v_certificate_no character varying(100) ;
     v_passport_aadhar_no character varying(100) ;
     v_age_group character varying(100) ;
     v_blood_group character varying(20) ;
     v_player_school character varying ;
     v_coach_employed character varying(500) ;
     v_is_child_insured numeric;
     v_mother_name character varying(300) ;
     v_mother_contactno character varying(20) ;
     v_father_name character varying(300) ;
     v_father_contactno character varying(20) ;
     v_address character varying(4000) ;
     v_emailid character varying(500) ;
     v_medical_history text ;
     v_registration_date timestamp without time zone;
     v_registration_type character varying(20) ;
     v_image_path character varying(4000) ;
     v_parent_sign character varying(4000) ;
     v_grassroots_mgr_sign character varying(4000) ;
     v_indemnity_clause text;
 
begin 

	v_json := p_regjson;
	v_sysdate:=  current_timestamp at time zone 'utc';
    
    select  v_json->'data'->>'labjfc_gr_pin', 
    		v_json->'data'->>'name', 
            v_json->'data'->>'date_of_birth',
	  		v_json->'data'->>'certificate_no' ,
	  		v_json->'data'->>'passport_aadhar_no',
	  		v_json->'data'->>'age_group',
          	v_json->'data'->>'blood_group',
	  		v_json->'data'->>'player_school' ,
	  		v_json->'data'->>'coach_employed' ,
	  		v_json->'data'->>'is_child_insured',
	  		v_json->'data'->>'mother_name'  ,
	  		v_json->'data'->>'mother_contact_no',
	  		v_json->'data'->>'father_name' ,
	  		v_json->'data'->>'father_contact_no',
            v_json->'data'->>'address',
	  		v_json->'data'->>'email_id',
            v_json->'data'->>'medical_history',
            v_json->'data'->>'registration_date',
	 		v_json->'data'->>'registration_type',
	  		v_json->'data'->>'image_path',
            v_json->'data'->>'parent_signature' ,
            v_json->'data'->>'grassroots_manager_signature' ,
	  		v_json->'data'->>'indemnity_clause'
    	  into 
            v_labjfc_gr_pin,
            v_name,
            v_dob,
            v_certificate_no,
            v_passport_aadhar_no,
            v_age_group,
            v_blood_group,
            v_player_school,
            v_coach_employed,
            v_is_child_insured,
            v_mother_name,
            v_mother_contactno,
            v_father_name,
            v_father_contactno,
            v_address,
            v_emailid,
            v_medical_history,
            v_registration_date,
            v_registration_type,
            v_image_path,
            v_parent_sign,
            v_grassroots_mgr_sign,
            v_indemnity_clause;
           
        if  lower(v_registration_type) = 'player' then 
        	
            v_registration_form_id := nextval('labjfc.seq_labjfc_registration_form_id') ;
            
        	insert into labjfc.labjfc_registration_form
			(registration_form_id, labjfc_gr_pin, name, date_of_birth, certificate_no, passport_aadhar_no, age_group,
    		 blood_group, player_school, is_child_insured, mother_name, mother_contact_no, father_name, father_contact_no, 
             address, email_id, medical_history, registration_date, registration_type, image_path, parent_signature,
             grassroots_manager_signature, indemnity_clause, created_date, updated_date, is_active, is_deleted )
             select v_registration_form_id, v_labjfc_gr_pin, v_name, v_dob, v_certificate_no, v_passport_aadhar_no, v_age_group,
             		v_blood_group, v_player_school, v_is_child_insured, v_mother_name, v_mother_contactno, v_father_name, v_father_contactno,
                    v_address, v_emailid, v_medical_history, v_registration_date, v_registration_type, v_image_path, v_parent_sign,  
                    v_grassroots_mgr_sign, v_indemnity_clause, v_sysdate, v_sysdate, 1, 0 ;
             
        else
        	 v_registration_form_id := nextval('labjfc.seq_labjfc_registration_form_id') ;
             
            insert into labjfc.labjfc_registration_form
			(registration_form_id, labjfc_gr_pin, name, date_of_birth, certificate_no, passport_aadhar_no, age_group,
    		 blood_group, coach_employed, mother_name, mother_contact_no, father_name, father_contact_no, 
             address, email_id, medical_history, registration_date, registration_type, image_path, 
             grassroots_manager_signature, indemnity_clause, created_date, updated_date, is_active, is_deleted )
             select v_registration_form_id, v_labjfc_gr_pin, v_name, v_dob, v_certificate_no, v_passport_aadhar_no, v_age_group,
             		v_blood_group, v_coach_employed, v_mother_name, v_mother_contactno, v_father_name, v_father_contactno,
                    v_address, v_emailid, v_medical_history, v_registration_date, v_registration_type, v_image_path,   
                    v_grassroots_mgr_sign, v_indemnity_clause, v_sysdate, v_sysdate, 1, 0 ;
                
        end if ; 
            
            p_result := 1 ; 
  /*          
  exception 
  when others then 
  		p_result := -1 ; 
  */
end ;

$$;


--
