-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_ins_upd_volunteer(numeric, jsonb, character varying, character varying)
-- Type: FUNCTION

-- Name: labpcm_ins_upd_volunteer(numeric, jsonb, character varying, character varying); Type: FUNCTION; Schema: labpcm; Owner: -
--

CREATE FUNCTION labpcm.labpcm_ins_upd_volunteer(p_volunteer_detail_id numeric, p_json jsonb, p_username character varying, p_login_password character varying, OUT p_result numeric, OUT p_ret_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare 
v_json jsonb;
v_volunteer_guid character varying(500);
   v_currenttimestamp    timestamp;
   v_volunteer_exists numeric;
v_volunteer_detail_id numeric;
 begin

   v_currenttimestamp := current_timestamp at time zone 'utc';
  
   	if p_volunteer_detail_id is null then
 
  			select count(1) into v_volunteer_exists
   			from labpcm.labpcm_volunteer_detail
   			where lower(username)=lower(p_username);
   
   
 	if v_volunteer_exists = 0 or v_volunteer_exists is null  then
 			v_volunteer_detail_id := nextval('labpcm.seq_volunteer_detail_id');
			v_volunteer_guid := uuid_generate_v4();
 			insert into labpcm.labpcm_volunteer_detail
 			( volunteer_detail_id ,
			  data,
				username ,
				login_password,
				is_active,
				is_deleted,
				created_date,
  				volunteer_guid
 			)
 			values
		 (  v_volunteer_detail_id,
            p_json,
		    p_username ,
		    p_login_password,
 			1,
 			0,
 			 v_currenttimestamp,
 			 v_volunteer_guid
 		 );

		p_result :=1; 
		
		else
		p_result := -1; 

		end if;

 else
 	v_volunteer_detail_id :=p_volunteer_detail_id;
    
	select volunteer_guid
	 into v_volunteer_guid
	from labpcm.labpcm_volunteer_detail
	 where volunteer_detail_id =v_volunteer_detail_id;

	
 	update labpcm.labpcm_volunteer_detail
 	set     data=p_json,
			updated_date =v_currenttimestamp
	 where volunteer_detail_id =v_volunteer_detail_id;

 p_result :=1; 
end if;

if p_result =1
then
p_result:= v_volunteer_detail_id;
 select row_to_json(row) as jsonrow
		 from (select v_volunteer_detail_id as volunteer_detail_id,
			         v_volunteer_guid as volunteer_guid,
			         p_username as username) as row
					into v_json ;
else 
v_json:= null;

end if;

 p_ret_json := v_json;
/*
exception when others then
 p_result := 0;
 p_ret_json:=null;*/

   end;

$$;


--
