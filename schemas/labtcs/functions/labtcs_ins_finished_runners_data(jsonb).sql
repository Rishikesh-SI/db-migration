-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_ins_finished_runners_data(jsonb)
-- Type: FUNCTION

-- Name: labtcs_ins_finished_runners_data(jsonb); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_ins_finished_runners_data(p_input_json jsonb, OUT p_output_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_user_guid character varying;
v_user_id numeric;
i jsonb[];
v_input_array jsonb;
v_data jsonb;
v_distanceCovered numeric;
v_bib_no numeric;
--v_race_type numeric;
	   v_firstName character varying;
	   v_lastName character varying;
	   v_activeTimeinSec character varying;
	   v_elapsedTimeinSec character varying;
	   v_finishStatus character varying;
	   v_avgPace character varying;
v_race_type character varying;
begin

select p_input_json->>'data' into v_input_array;
for v_data in select * from jsonb_array_elements(v_input_array)
      loop
        select  v_data->>'distanceCovered',
				v_data->>'bibNumber',
				v_data->>'firstName',
				v_data->>'lastName',
				v_data->>'activeTimeinSec',
				v_data->>'elapsedTimeinSec',
				v_data->>'finishStatus',
				v_data->>'avgPace'
      -- v_data->>'youtube_url'
	   into
	   v_distanceCovered,
	   v_bib_no,
	   v_firstName,
	   v_lastName,
	   v_activeTimeinSec,
	   v_elapsedTimeinSec,
	   v_finishStatus,
	   v_avgPace;
	  -- v_youtube_url;
    begin

	select user_guid,user_id,race_type
	into v_user_guid,v_user_id,v_race_type
	from labtcs.labtcs_user_master
	where bib_no=v_bib_no; 
	
	raise notice 'v_bib_no - %',v_bib_no;
	
	if exists (select 1 from labtcs.labtcs_user_race_challange
			  where bib_no=v_bib_no) then

	raise notice 'updated %',v_data;
	

	update labtcs.labtcs_user_race_challange
	set user_guid=v_user_guid,
	user_id=v_user_id,
	distance_class=v_distanceCovered,
	bib_no=v_bib_no,
	data_json=v_data,
	first_name=v_firstName,
	last_name=v_lastName,
	activetimeinsec=v_activeTimeinSec,
	elapsedtimeinsec=v_elapsedTimeinSec,
	finishstatus=v_finishStatus,
	avgpace=v_avgPace
	where bib_no=v_bib_no;
	
	p_output_json:='{
	"message":"Inserted Succesfully",
	"status":"1"
	}';

	

	else if not exists (select 1 from labtcs.labtcs_user_race_challange
			  where bib_no=v_bib_no) then

	insert into labtcs.labtcs_user_race_challange(user_guid,user_id,distance_class,bib_no,data_json,first_name,last_name,activetimeinsec,elapsedtimeinsec,finishstatus,avgpace,race_type,created_date)
	values(v_user_guid,v_user_id,v_distanceCovered,v_bib_no,v_data,v_firstName,v_lastName,v_activeTimeinSec,v_elapsedTimeinSec,v_finishStatus,v_avgPace,v_race_type,current_timestamp);
	
	p_output_json:='{
	"message":"Inserted Succesfully",
	"status":"1"
	}';
	
	
	else 
	
	p_output_json:='{
	"message":"Something went wrong",
	"status":"0"
	}';
	
	end if;
	end if;
end;
  END LOOP;


end;
$$;


--
