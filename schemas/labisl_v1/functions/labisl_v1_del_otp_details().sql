-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_del_otp_details()
-- Type: FUNCTION

-- Name: labisl_v1_del_otp_details(); Type: FUNCTION; Schema: labisl_v1; Owner: -
--

CREATE FUNCTION labisl_v1.labisl_v1_del_otp_details(OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_created_date timestamp;
v_mobile_no character varying[];
begin	
	
	select current_timestamp into v_created_date;
	
	raise notice 'v_created_date %',v_created_date::date;
	
	select array_agg(mobile_no) into v_mobile_no from labisl_v1.labisl_v1_otp_details
	where created_date < v_created_date and is_used=1;
	
	raise notice 'v_mobile_no %',v_mobile_no;
	
	insert into labisl_v1.labisl_v1_bkp_otp_details
	select * from labisl_v1.labisl_v1_otp_details
	where mobile_no in (select mobile_no from unnest(v_mobile_no)) and created_date < v_created_date - '0 hours'::interval;
	
	/*
	delete from labisl_v1.labisl_v1_otp_details
	where mobile_no in (select mobile_no from unnest(v_mobile_no))  and created_date < v_created_date - '0 hours'::interval;
	*/
end;
$$;


--
