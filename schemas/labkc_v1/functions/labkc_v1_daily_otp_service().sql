-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_daily_otp_service()
-- Type: FUNCTION

-- Name: labkc_v1_daily_otp_service(); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_daily_otp_service() RETURNS void
    LANGUAGE plpgsql
    AS $$

    declare
  
    begin

        insert into labkc_v1.labkc_v1_otp_details_backup
		select * from labkc_v1.labkc_v1_otp_details;
		
		delete from labkc_v1.labkc_v1_otp_details;
                                           
	end;
    

 
$$;


--
