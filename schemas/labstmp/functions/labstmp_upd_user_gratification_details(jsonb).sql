-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_upd_user_gratification_details(jsonb)
-- Type: FUNCTION

-- Name: labstmp_upd_user_gratification_details(jsonb); Type: FUNCTION; Schema: labstmp; Owner: -
--

CREATE FUNCTION labstmp.labstmp_upd_user_gratification_details(p_user_data jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 
		declare
		/*'{
			"user_data": {
			"gift_id": 29646,
			"user_id": 57901,
			"match_id": 29646,
			"gift_name": "MCFC vs NEUFC",
			"is_exists": 1,
			"user_guid": "6486cb2d-aff0-4fd3-b338-612be1a3a393",
			"is_claimed": 0,
			"start_date": "2020-01-31T19:30:00"
						 }
			}'*/
		
		v_match_id numeric  ;
		v_user_guid character varying  ;
		v_user_id numeric;
		
		begin
		
			select p_user_data->'user_data'->>'user_guid',
				   p_user_data->'user_data'->>'match_id'
			into   v_user_guid,
				   v_match_id;
			
			select user_id into v_user_id from labstmp.labstmp_web_user
			where user_guid = v_user_guid;
			
			update labstmp.labstmp_gratification_details
			set is_claimed = 1
			where user_id = v_user_id and match_id = v_match_id;
			
			p_result := 1;
			
			exception
			when others then
      		p_result := -1;
        
		end;
		
		$$;


--
