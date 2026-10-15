-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_ins_runners_data(jsonb)
-- Type: FUNCTION

-- Name: labtcs_ins_runners_data(jsonb); Type: FUNCTION; Schema: labtcs; Owner: -
--

CREATE FUNCTION labtcs.labtcs_ins_runners_data(p_input_json jsonb, OUT p_data numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_user_guid character varying;
v_user_id numeric;
i json[];
a json;
begin

	select p_input_json->>'data' into i;

 FOR a IN SELECT * FROM jsonb_array_elements(i)
  LOOP

/*
	select user_guid,user_id 
	into v_user_guid,v_user_id
	from labtcs.labtcs_user_master
	where bib_no=i.bibNumber; */
	
	insert into labtcs.labtcs_user_race_challange
	values(v_user_guid,v_user_id,null,a.distanceCovered);

  END LOOP;

p_data:=1;

end;
$$;


--
