-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_upd_university_student(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_upd_university_student(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_upd_university_student(p_input_json jsonb, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_email_id text;
v_university_name text;
v_module_name varchar(500);
i record;
v_json jsonb;
v_university_code text;
 
begin

select p_input_json->>'data'
into v_json;
raise notice '%',v_json;
 

for i in (select value->>'email_id' as email_id,
		   value->>'university_name' as university_name,
		  value->>'university_code' as university_code,
		  value->>'module_name' as module_name 
		  from jsonb_array_elements(v_json))
loop
--raise notice '%',i.email_id;

--select 1/0;
 
	   v_email_id:=i.email_id;
	   v_university_name:=i.university_name;
	   v_module_name:=i.module_name;
	   v_university_code:=i.university_code;
	    
if not exists(select 1 from labbsc_dev.labbsc_dev_university_student
			 where email_id=v_email_id)	   then
	insert into labbsc_dev.labbsc_dev_university_student	 
	select nextval('labbsc_dev.seq_labbsc_dev_university_student_id'),v_email_id,v_university_name,
	upper(v_module_name),current_timestamp,current_timestamp,v_university_code;
	
	else 
	update labbsc_dev.labbsc_dev_university_student
	set university_name=v_university_name,
	university_code=v_university_code,
	updated_date=current_timestamp
	where email_id=v_email_id;
	  end if;
	

end loop;
   p_out:=1;
   

end;
$$;


--
