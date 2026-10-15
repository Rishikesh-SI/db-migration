-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_update_sftp_data_status(jsonb)
-- Type: FUNCTION

-- Name: lablsg_update_sftp_data_status(jsonb); Type: FUNCTION; Schema: lablsg; Owner: -
--

CREATE FUNCTION lablsg.lablsg_update_sftp_data_status(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_json jsonb ;
 
begin

v_json := p_json;

CREATE TEMP TABLE data AS
select * from jsonb_to_recordset(v_json)
				as x("email_id" text);
				
update lablsg.lablsg_web_user
set sync_sftp_status = 1
where email_id in (select email_id from data );

p_result := 1 ;

end;

$$;


--
