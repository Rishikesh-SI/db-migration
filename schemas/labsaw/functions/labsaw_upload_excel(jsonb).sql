-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_upload_excel(jsonb)
-- Type: FUNCTION

-- Name: labsaw_upload_excel(jsonb); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_upload_excel(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

	declare
	
	v_opt_type numeric;
	v_json json;
	v_data json;
	v_affliate_data_id numeric;
	v_is_approved numeric;

	begin 
	
	select p_json->>'opt_type',
		   p_json->'data'
	into   v_opt_type,
	       v_json ;
		   
	
	if v_opt_type = 1 then
	
		for v_data in select * from json_array_elements(v_json)
		loop
		
		  select v_data->>'affliate_data_id',
		  		 v_data->>'is_approved'
		  into 	v_affliate_data_id,
		        v_is_approved;
				
		update labsaw.labsaw_affliate_data
		set is_approved = v_is_approved
		where affliate_data_id = v_affliate_data_id;
		
		
		
		end loop;
	
		p_data :=  '{
	 				"status" : 1
	 				}';
	
	
	end if;
	
	
	 
   
     exception
     when others then
     p_data := '{ "status" : -1}';

	end;

	
$$;


--
