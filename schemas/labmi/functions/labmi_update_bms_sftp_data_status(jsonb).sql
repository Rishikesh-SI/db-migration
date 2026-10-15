-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_update_bms_sftp_data_status(jsonb)
-- Type: FUNCTION

-- Name: labmi_update_bms_sftp_data_status(jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_update_bms_sftp_data_status(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_json jsonb ;
 
begin

v_json := p_json;

CREATE TEMP TABLE data AS
select * from jsonb_to_recordset(v_json)
				as x("bookingid" text);

update labmi.labmi_bms_booking 
set is_used = 1
where bkg_id in (select bookingid from data);

p_result := 1 ;

end;

$$;


--
