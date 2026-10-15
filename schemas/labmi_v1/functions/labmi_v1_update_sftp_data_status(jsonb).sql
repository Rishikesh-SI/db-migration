-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_update_sftp_data_status(jsonb)
-- Type: FUNCTION

-- Name: labmi_v1_update_sftp_data_status(jsonb); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_update_sftp_data_status(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_json jsonb ;
 
begin

v_json := p_json;

CREATE TEMP TABLE data AS
select * from jsonb_to_recordset(v_json)
				as x("email_id" text);
				
update labmi_v1.labmi_v1_web_user
set sync_data = 1
where email_id in (select email_id from data );

p_result := 1 ;

end;

$$;


--
