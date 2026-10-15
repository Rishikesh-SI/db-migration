-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_upd_placed_users(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_upd_placed_users(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_upd_placed_users(p_input_json jsonb, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_candidate_name text;
v_company_name text;
v_role_name varchar(500);
i record;
v_json jsonb;

begin

select p_input_json->>'data'
into v_json;
raise notice '%',v_json;
 

for i in (select value->>'candidate_name' as candidate_name,
		   value->>'company_name' as company_name,
		     value->>'role' as role_name 
		  from jsonb_array_elements(v_json))
loop
--raise notice '%',i.email_id;

--select 1/0;
 
	   v_candidate_name:=i.candidate_name;
	   v_company_name:=i.company_name;
	   v_role_name:=i.role_name;
	 
	    
if not exists(select 1 from labbsc_dev.labbsc_dev_placed_user
			 where candidate_name=v_candidate_name
			 and company_name=v_company_name
			  and role_name=v_role_name
			 )	   then
	insert into labbsc_dev.labbsc_dev_placed_user	 
	select nextval('labbsc_dev.seq_labbsc_dev_placed_user_id'),v_candidate_name,v_role_name,
	v_company_name,current_timestamp,current_timestamp;
	
	 
	  end if;
	

end loop;
   p_out:=1;
   

end;
$$;


--
