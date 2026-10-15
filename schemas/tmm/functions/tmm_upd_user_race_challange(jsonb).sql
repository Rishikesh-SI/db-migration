-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_upd_user_race_challange(jsonb)
-- Type: FUNCTION

-- Name: tmm_upd_user_race_challange(jsonb); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_upd_user_race_challange(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
/*
SELECT * from  tmm.tmm_ins_upd_user_race_challange(
	'{
  "user_guid": "4b40a91d-e089-4501-8a37-6cec99ba10ce",
  "email_id": "hgaHGHJas",
  "hash_email_id": "gsHGJHghs",
  "user_id": "124",
  "distance_class": "hjGJHGajha",
  "actual_distance_in_meters": "10",
  "actual_elapsed_time_in_seconds": "1000",
  "average_pace_minutes_per_mile": "200",
  "average_pace_minutes_per_km": "200"
}'
)
*/
--select * from tmm.tmm_user_race_challange
declare
	v_email_id text;
	v_user_guid text;
	v_hash_email_id text;
	v_user_id numeric;
	v_distance_class	text;
	v_actual_distance_in_meters	numeric;
	v_actual_elapsed_time_in_seconds	numeric;
	v_average_pace_minutes_per_mile	numeric;
	v_average_pace_minutes_per_km	numeric;
	v_item jsonb;
	v_date_of_birth text;
	v_race_type text;
	v_qualifying_trip_activity_id text;
	v_date_completed text;
	v_approximate_distance_completed text;
	v_avg_pace_min_per_miles text;
	v_cadence_steps_per_min text;
	v_time_spent_paused_in_seconds  text;
begin
FOR v_item IN SELECT * FROM jsonb_array_elements(p_json)
   LOOP
	select v_item->>'email_id', v_item->>'user_guid',v_item->>'HashedEmails',v_item->>'user_id',
		   v_item->>'distance_class',v_item->>'actual_distance_in_meters',v_item->>'Elapsed_time_in_seconds',
			v_item->>'Pace_minutes_per_mile',v_item->>'Pace_minutes_per_km',v_item->>'dob',v_item->>'Race_type',
			v_item->>'Qualifying_Trip_Activity_ID', v_item->>'Date_completed',
			v_item->>'Approximate_Distance_Completed',
			v_item->>'Cadence_steps_per_min',v_item->>'Time_Spent_Paused_in_seconds'  
    into v_email_id, v_user_guid,v_hash_email_id,v_user_id,v_distance_class,v_actual_distance_in_meters,
	     v_actual_elapsed_time_in_seconds,v_average_pace_minutes_per_mile,v_average_pace_minutes_per_km,
		 v_date_of_birth,v_race_type,v_qualifying_trip_activity_id,v_date_completed,
		 v_approximate_distance_completed,
         v_cadence_steps_per_min,v_time_spent_paused_in_seconds;
		 
		 /*raise notice 'v_hash_email_id:%',v_hash_email_id;
		 raise notice 'v_user_id:%',v_user_id;
		 raise notice 'v_actual_distance_in_meters:%',v_actual_distance_in_meters;
		 raise notice 'v_actual_elapsed_time_in_seconds:%',v_actual_elapsed_time_in_seconds;
		 raise notice 'v_average_pace_minutes_per_mile:%',v_average_pace_minutes_per_mile;
		 raise notice 'v_average_pace_minutes_per_km:%',v_average_pace_minutes_per_km;
		 raise notice 'v_date_of_birth:%',v_date_of_birth;
		 raise notice 'v_race_type:%',v_race_type;
		 raise notice 'v_qualifying_trip_activity_id:%',v_qualifying_trip_activity_id;
		 raise notice 'v_date_completed:%',v_date_completed;
		 raise notice 'v_approximate_distance_completed:%',v_approximate_distance_completed;
		 raise notice 'v_cadence_steps_per_min:%',v_cadence_steps_per_min;
		 raise notice 'v_time_spent_paused_in_seconds:%',v_time_spent_paused_in_seconds;
		 
		 select 1/0;*/
		 
		 
		 
						   
						   
           if exists (select 1 from tmm.tmm_user_race_challange where hash_email_address = v_hash_email_id)
		   then 
		   /*raise notice 'v_hash_email_id:%',v_hash_email_id;
		   select 1/0;*/
    	        update tmm.tmm_user_race_challange
						set average_pace_minutes_per_km = v_average_pace_minutes_per_km,
						actual_distance_in_meters = v_actual_distance_in_meters,
						actual_elapsed_time_in_seconds = v_actual_elapsed_time_in_seconds,
						average_pace_minutes_per_mile = v_average_pace_minutes_per_mile,
						race_type = v_race_type,
						qualifying_trip_activity_id = v_qualifying_trip_activity_id,
						date_completed = v_date_completed,
						approximate_distance_completed = v_approximate_distance_completed,
						avg_pace_min_per_miles = v_average_pace_minutes_per_mile,
						cadence_steps_per_min = v_cadence_steps_per_min,
						time_spent_paused_in_seconds = v_time_spent_paused_in_seconds
						where hash_email_address = v_hash_email_id;
                p_result := 2;
           end if;
               --end if;
			   end loop;
			   
               
 end;
$$;


--
