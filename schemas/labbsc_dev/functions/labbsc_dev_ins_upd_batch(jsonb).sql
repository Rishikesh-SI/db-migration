-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_upd_batch(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_upd_batch(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_upd_batch(p_json jsonb, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
	  /*p_json := '{
  "batch_name": "Cintu",
  "total_slots": "2",
  "batch_date": "2021-09-09",
  "slot_timing": "10.00 AM to 11.30 AM",
  "mentor_name_1": "jagatjit",
  "mentor_email_id_1": "jagatjit@gmail.com",
  "mentor_name_2": "jagatjit1",
  "mentor_email_id_2": "jagatjit1@gmail.com"
}'*/
	 v_batch_id numeric;			
	 v_batch_name text;
	 v_batch_date timestamp;
	 v_slot_timing text;
     v_mentor_name_1 text;
	 v_mentor_name_2 text;
	 v_mentor_email_id_1 text;
	 v_mentor_email_id_2 text;
     v_Slots numeric;
	 v_current_date timestamp :=  current_timestamp at time zone 'utc';
	 i record ;
	 v_position numeric;
	 
	begin
	
	
	
	
	  select p_json->>'batch_name',
	         p_json->>'batch_id',
			 p_json->>'batch_date',
			 p_json->>'slot_timing',
			 p_json->>'mentor_name_1',
			 p_json->>'mentor_email_id_1',
			 p_json->>'mentor_name_2',
			 p_json->>'mentor_email_id_2',
			 p_json->>'total_slots',
			 p_json->>'position'
	 into   v_batch_name,
	        v_batch_id,
			v_batch_date, 
            v_slot_timing,
			v_mentor_name_1,
			v_mentor_email_id_1,
			v_mentor_name_2,
			v_mentor_email_id_2,
			v_Slots,
			v_position;
			 
		if v_batch_id is null or v_batch_id = 0 then
		
		    v_batch_id := nextval('labbsc_dev.seq_labbsc_dev_batch_id');
		    
		if not exists(select 1 from labbsc_dev.labbsc_dev_batch
					 where position = v_position) then	
			
			insert into labbsc_dev.labbsc_dev_batch
			values (v_batch_id,v_batch_name,v_batch_date,v_slot_timing,
				   v_mentor_name_1,v_mentor_email_id_1,v_mentor_name_2,v_mentor_email_id_2,
					v_Slots,v_Slots,v_current_date,v_current_date,1,v_position);
					
			p_out := 1;	
		
		else
		  
		  p_out := 2;
		
		end if;
		
		else
		
			update labbsc_dev.labbsc_dev_batch
			set batch_name = coalesce(v_batch_name,batch_name),
			    batch_date = coalesce(v_batch_date,batch_date),
				batch_time   = coalesce(v_slot_timing,batch_time),
				mentor_name_1  = coalesce(v_mentor_name_1,mentor_name_1),
				mentor_name_2  = coalesce(v_mentor_name_2,mentor_name_2),
				mentor_email_id_1  = coalesce(v_mentor_email_id_1,mentor_email_id_1),
				mentor_email_id_2  = coalesce(v_mentor_email_id_2,mentor_email_id_2),
				total_slots  = coalesce(v_Slots,total_slots),
				updated_date = v_current_date,
				position = v_position
			 where batch_id = v_batch_id;
		
		     p_out := 1;
		
		end if;
			 
	/*exception when others then 
	p_out := -1 ;*/
	 
			 
	end;
$$;


--
