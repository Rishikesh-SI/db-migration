-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_ins_user_batch(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_ins_user_batch(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_ins_user_batch(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
	
	  /*p_json := '{
  "batch_id": 1,
  "user_guid": "2"
  }'*/
	 v_batch_id numeric;			
	 v_user_guid character varying(500);
	 v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	 v_count numeric;
	 
	begin
	
	  select p_json ->>'batch_id',
			 p_json ->>'user_guid'

	 into   v_batch_id,
			v_user_guid ;
			
	select available_slots from labbsc_dev.labbsc_dev_batch	
	where batch_id = v_batch_id
	into v_count;
	
	 if v_count > 0  then
			
			if not exists(select 1 from labbsc_dev.labbsc_dev_user_batch_map
						 where batch_id = v_batch_id and user_guid = v_user_guid) then


					insert into labbsc_dev.labbsc_dev_user_batch_map(user_batch_map_id,batch_id,
																	user_guid,created_date)
					values(nextval('labbsc_dev.seq_labbsc_dev_user_batch_map_id'),v_batch_id,v_user_guid,v_current_timestamp);
					
					update labbsc_dev.labbsc_dev_batch
					set available_slots = available_slots - 1
					where batch_id = v_batch_id ;

					p_result := 1;


			else

			   p_result := 2;

			end if;	
			
		else

			   p_result := 3;
			
		end if;
		
		
	exception when others then 
	
	p_result := -1 ;
	 
			 
	end;
$$;


--
