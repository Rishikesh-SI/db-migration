-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_ins_upd_training_program(jsonb)
-- Type: FUNCTION

-- Name: tmmimg_upd_ins_upd_training_program(jsonb); Type: FUNCTION; Schema: tmmimg_upd; Owner: -
--

CREATE FUNCTION tmmimg_upd.tmmimg_upd_ins_upd_training_program(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

--do
--$$

declare
/*p_json jsonb:='{
  "data": {
    "training_program_id": null,
    "name": "john ruth",
    "age": 24,
    "gender": "female",
    "dob": "1994-10-11",
    "email_id": "sdf@sdf.com",
    "phone_number": "34-3434343434",
    "promocode":null
  },
  "category_flag": "2",
  "marathonStatus": "No"
}';
p_result numeric;
p_data jsonb;
*/
v_json jsonb;
v_sysdate timestamp ;

------------------------
v_promo_code text;
v_training_program_id numeric;
v_name varchar(2000);
v_age numeric;
v_gender varchar(2000);
v_dob date;
v_best_event_date timestamp;
v_best_event_time text;
v_best_event_name text;
v_email_id varchar(2000);
v_phone_number text;
v_pdf_flag numeric;
v_pdf_path text;
v_running_group jsonb;
v_category_flag numeric;
err_msg text;
v_send_mail_flag numeric;
v_address varchar(4000);
v_pincode varchar(10);
v_occupation varchar(200);
v_designation varchar(200);
v_emergency_cont_name varchar(200);
v_emergency_contactno varchar(20) ;
v_marathonStatus text;

------------------------
--********************************PREFACE BLOCK*******************************
--  NAME: ins_upd_training_program
--
--  Purpose: training program module 
--
--  Parameters:  
--
--
--  External Output:  
--                    
--
--  Written/Modified by:   Date:           Reason:
--  R. BHATKAR             31/08/2018      CREATION
--********************************END PREFACE BLOCK***************************

---------------------------
/*

{
  "_comment1": " pdf category = 1: general ,2 : advanced",
  "_comment2": " form category = 1 : HALF 2 FULL ,2 : RUN THE HALF AT TMM 19,3 :COUCH TO 10K",
  "category_flag": "",
  "send_mail_flag":1,
  "data": {
    "training_program_id": "",
    "name": "ravi",
    "age": 25,
    "gender": "female",
    "dob": "",
    "best_event_date": "",
    "best_event_time": "",
    "best_event_name": "",
    "email_id": "",
    "phone_number": "",
    "pdf_flag": "",
    "pdf_path": "",
    "address" : "",
    "pincode" : "",
    "occupation" : "",
    "designation" : "",
    "emergency_contact_name" : "",
    "emergency_contactno" : "",
    "running_group": {
      "is_trained": "no",
      "city": "",
      "center": ""
    }
  }
}
*/

begin 
    v_json := p_json;
	v_sysdate:=  current_timestamp at time zone 'utc';

-- 1  marathon , 2 half marathon , 3 open 10 k
select v_json->'data'->>'training_program_id',
       v_json->'data'->>'name',
	   v_json->'data'->>'age',
	   v_json->'data'->>'gender',
	   v_json->'data'->>'dob',
	   v_json->'data'->>'email_id',
	   v_json->'data'->>'phone_number',
        v_json->'data'->>'city',
	   v_json->>'category_flag'
	  
	
into    v_training_program_id,
		v_name,
		v_age,
		v_gender,
		v_dob,
		v_email_id,
		v_phone_number,
          v_address,
		v_category_flag
		
		;

if v_training_program_id is null  then
               raise notice '% check',1;
			v_training_program_id :=nextval('tmmimg_upd.seq_tmmimg_upd_training_program_id');
			
			--select * from tmmimg_upd.tmmimg_upd_training_program;
			-- raise notice '% check',v_training_program_id;
			
			v_json 	       := jsonb_set(v_json, '{data,training_program_id}', v_training_program_id::text::jsonb, true);
        
		
		insert into tmmimg_upd.tmmimg_upd_training_program
		            (
					training_program_id,
					name,
					age,
					gender,
					dob,
					email_id,
					phone_number,
					category_flag,
                         address
					
					)
          values (
		         v_training_program_id,
				 v_name,
				 v_age,
				 v_gender,
				 v_dob,
				 v_email_id,
				 v_phone_number	,
				 v_category_flag,
              		 v_address
				 
		       );

if not exists (select 1 from tmmimg_upd.tmmimg_upd_user_promocode_map where upper(email_id)=upper(v_email_id) )then 
select promo_code into v_promo_code
from tmmimg_upd.tmmimg_upd_promo_code_category_wise
where category_id=v_category_flag
and is_active=1 and is_deleted=0 and is_send_user=0
order by promo_code_id limit 1;

update tmmimg_upd.tmmimg_upd_promo_code_category_wise
set is_active=0,is_deleted=1,is_send_user=1
where category_id=v_category_flag
and promo_code=v_promo_code
;

insert into tmmimg_upd.tmmimg_upd_user_promocode_map
(promo_code,email_id,is_send,created_date,updated_date)
values (v_promo_code,v_email_id,1,current_timestamp,current_timestamp);
-- raise notice '% check',v_promo_code;

-- raise notice '% check',v_category_flag;
end if;

v_send_mail_flag:=1;
 v_json 	       := jsonb_set(v_json, '{send_mail_flag}', v_send_mail_flag::text::jsonb, true);
 v_json 	       := jsonb_set(v_json, '{data,promocode}', ('"'||coalesce(v_promo_code,' ')||'"')::text::jsonb,true);

update tmmimg_upd.tmmimg_upd_training_program
set program_json=v_json
where training_program_id=v_training_program_id;

-- raise notice '% check',v_json;
/*
else 

update tmmimg_upd.tmmimg_upd_training_program
  set               name=v_name,
					age=v_age,
					gender=v_gender,
					dob=v_dob,
					best_event_date=v_best_event_date,
					best_event_time=v_best_event_time,
					best_event_name=v_best_event_name,
					email_id=v_email_id,
					phone_number=v_phone_number,
					pdf_flag=v_pdf_flag,
					pdf_path=v_pdf_path,
					running_group=v_running_group,
					category_flag=v_category_flag,
					updated_date=v_sysdate,
                    address = v_address, 
                    pincode = v_pincode, 
                    occupation = v_occupation, 
                    designation = v_designation, 
                    emergency_contact_name = v_emergency_cont_name,
                    emergency_contactno = v_emergency_contactno
where training_program_id=v_training_program_id ;

v_send_mail_flag:=2;

v_json 	       := jsonb_set(v_json, '{send_mail_flag}', v_send_mail_flag::text::jsonb, true);
*/
end if ;

p_result :=1 ;
p_data:=v_json;
 exception 
    when others then
	    --err_code := SQLSTATE;
          err_msg := SQLERRM;
		  p_result := -1;
		  p_data := '{"data":{"message" :"'||coalesce(err_msg, '')||'" ,"result":"'||coalesce(p_result, 0)||'"}}';
    

end;

 

$_$;


--
