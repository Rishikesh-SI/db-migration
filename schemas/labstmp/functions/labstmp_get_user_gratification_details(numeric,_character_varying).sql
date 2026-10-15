-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_get_user_gratification_details(numeric, character varying)
-- Type: FUNCTION

-- Name: labstmp_get_user_gratification_details(numeric, character varying); Type: FUNCTION; Schema: labstmp; Owner: -
--

CREATE FUNCTION labstmp.labstmp_get_user_gratification_details(p_match_id numeric, p_user_guid character varying, OUT p_user_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 
		declare
		/*29646
		'b847d971-b611-40c3-b215-c6761266dafd'*/
		
		v_match_id numeric  ;
		v_user_guid character varying  ;
		v_user_id numeric;
		v_user_count numeric;
		v_gift_id numeric ;
		v_gift_name text;
		v_user_data jsonb;
		v_date timestamp;
		v_gift_type numeric;
	

		begin
		
			v_match_id := p_match_id;
			v_user_guid := p_user_guid;
			
			select current_timestamp at time zone 'utc' + '2 days'::interval into v_date ;
			v_date := v_date +'5.5 hours'::interval;
			
		--if exists(select 1 from labstmp.labstmp_gratification_gift
		-- where match_id = v_match_id and start_date::date >=v_date::date) then	
		
			select user_id into v_user_id from labstmp.labstmp_web_user
			where user_guid = v_user_guid;
			
				
			if not exists(select 1 from labstmp.labstmp_gratification_details
						 where user_id = v_user_id and match_id = v_match_id ) then
					
					select count(1) into v_user_count from labstmp.labstmp_gratification_details
					where  match_id = v_match_id;
					
					v_user_count := coalesce(v_user_count,0)+ 1;
					
					if mod(v_user_count,5) = 0 then	
					
						if not exists(select 1 from labstmp.labstmp_gratification_details
						 			 where user_id = v_user_id and gift_id <> 1 ) then
							
							with tab as( select gift_id,gift_name,gift_type
     						from labstmp.labstmp_gratification_gift
							where available_quantity >0 and is_flag=0 and match_id = v_match_id)
									 
							select gift_id,gift_type
							from tab 
							order by RANDOM() 
    						LIMIT 1
							into v_gift_id,v_gift_type;
											   
							update labstmp.labstmp_gratification_gift
							set available_quantity = available_quantity-1
							where gift_id =v_gift_id;
							
						else 
						
							select gift_id,gift_type
							into v_gift_id,v_gift_type
     						from labstmp.labstmp_gratification_gift
							where is_flag=1;
							
						end if;	
						
					else
							
							select gift_id,gift_type
							into v_gift_id,v_gift_type
     						from labstmp.labstmp_gratification_gift
							where is_flag= 1 ;
							
					end if;
					
	
					
					insert into labstmp.labstmp_gratification_details
    				values (nextval('labstmp.labstmp_gratification_detail_seq'),v_user_id,0,v_user_count,v_gift_id,1,0,0,current_timestamp,current_timestamp,v_match_id);	 
					
					select '{"user_data":'||row_to_json(row)||'}' into v_user_data
					from(select a.gift_id,case when b.gift_type=2 then split_part(b.gift_name, ' vs ',1) 
						 							else b.gift_name end as team_1,
						 							case when b.gift_type=2 then split_part(b.gift_name, ' vs ',2) 
						 							else b.gift_name end as team_2	
						 		,a.is_claimed,case when b.gift_type=2 then b.start_date
										  else null end as start_date,0 is_exists,'Mumbai' as venue_name,
						 		a.match_id,1 is_contest_open,b.gift_type
						 from labstmp.labstmp_gratification_details a
						 left join labstmp.labstmp_gratification_gift b on a.gift_id=b.gift_id
						 where a.user_id = v_user_id and a.match_id = v_match_id )row;
					

						 
			else
				
					
					select '{"user_data":'||row_to_json(row)||'}' into v_user_data
					from(select a.gift_id,case when b.gift_type=2 then split_part(b.gift_name, ' vs ',1) 
						 							else b.gift_name end as team_1,
						 							case when b.gift_type=2 then split_part(b.gift_name, ' vs ',2) 
						 							else b.gift_name end as team_2	
						 		,a.is_claimed,case when b.gift_type=2 then b.start_date
										  else null end as start_date,1 is_exists,'Mumbai' as venue_name,
						 		a.match_id, 1 is_contest_open,b.gift_type
						 from labstmp.labstmp_gratification_details a
						 left join labstmp.labstmp_gratification_gift b on a.gift_id=b.gift_id
						 where a.user_id = v_user_id and a.match_id = v_match_id  )row ;
						 
						 
					
			end if;
			
			p_user_data := v_user_data;
			
		/*else
		
			p_user_data := '{
  							"user_data": {
    									"is_contest_open": 0
  										}
							}';
			
		end if*/
		end;
		
		$$;


--
