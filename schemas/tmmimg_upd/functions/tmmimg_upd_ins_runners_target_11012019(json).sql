-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_ins_runners_target_11012019(json)
-- Type: FUNCTION

-- Name: tmmimg_upd_ins_runners_target_11012019(json); Type: FUNCTION; Schema: tmmimg_upd; Owner: -
--

CREATE FUNCTION tmmimg_upd.tmmimg_upd_ins_runners_target_11012019(p_input json, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_runner_target_id numeric;
v_first_name text;
v_last_name text;
v_dob		date;
v_email_id text;
v_target_time text;
v_timing_certificate text;
v_created_date timestamp without time zone;
v_inspired_by text;
v_inspired_how text;
v_race_category text;
v_runner_name text;
v_entry_flag numeric;

begin
raise notice '%', p_input ;

select p_input->'data'->>'runner_target_id',
       p_input->'data'->>'first_name',
       p_input->'data'->>'last_name',
       p_input->'data'->>'dob',
       p_input->'data'->>'email_id',
       p_input->'data'->>'target_time',
       p_input->'data'->>'timing_certificate',
       p_input->'data'->>'inspired_by',
       p_input->'data'->>'inspired_how',
       p_input->'data'->>'race_category',
       p_input->'data'->>'runner_name',
       p_input->'data'->>'entry_flag'
  into v_runner_target_id,
       v_first_name,
       v_last_name,
       v_dob,
       v_email_id,
       v_target_time,
       v_timing_certificate,
       v_inspired_by,
       v_inspired_how,
       v_race_category,
       v_runner_name,
       v_entry_flag;
       
       
       
     if  v_runner_target_id is null then
     
       v_runner_target_id :=  nextval('tmmimg_upd.seq_tmmimg_upd_runner_target_id');
       v_created_date := current_timestamp;
       
       insert into tmmimg_upd.tmmimg_upd_runners_target(runner_target_id,first_name,last_name,dob,email_id,race_category,
                                   target_time,timing_certificate,created_date,inspired_by,inspired_how,runner_name,entry_flag)
                            values(v_runner_target_id,v_first_name,v_last_name,v_dob,v_email_id,v_race_category,
                                   v_target_time,v_timing_certificate,v_created_date,v_inspired_by,
                                   v_inspired_how,v_runner_name,v_entry_flag);
                                   
        else
         update tmmimg_upd.tmmimg_upd_runners_target
         set timing_certificate= v_timing_certificate
         where runner_target_id= v_runner_target_id;
   
      end if;                      
                               
p_result:= v_runner_target_id;

end;

$$;


--
