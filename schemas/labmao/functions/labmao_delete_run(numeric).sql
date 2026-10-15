-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_delete_run(numeric)
-- Type: FUNCTION

-- Name: labmao_delete_run(numeric); Type: FUNCTION; Schema: labmao; Owner: -
--

CREATE FUNCTION labmao.labmao_delete_run(p_run_id numeric, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_user_id numeric;
v_activity_start_time numeric;
v_distance numeric(10,4);
v_verification_flag numeric;
v_activity_date date;
begin

select user_id ,
distance ,
activity_start_time ,
 activity_date ,
 verification_flag 
 from labmao.labmao_user_activity_detail
 where run_id=p_run_id
 into v_user_id,
 v_distance,
 v_activity_start_time,
 v_activity_date,
 v_verification_flag
 ;
 
 
 insert into labmao.labmao_deleted_activity_detail
 (user_id ,
run_id ,
distance ,
activity_start_time ,
 activity_date ,
 verification_flag 
 )
 select v_user_id ,
 p_run_id ,
v_distance ,
v_activity_start_time ,
 v_activity_date ,
 v_verification_flag 
  ;
  
 if coalesce(v_verification_flag,0)=0 then
  
  update labmao.labmao_user_activity_report
  set distance=distance-v_distance
  where user_id=v_user_id;
  
  end if;
 
 
 delete from labmao.labmao_user_activity_detail
 where run_id=p_run_id;
 
 
 p_out:=1;
 

end;
$$;


--
