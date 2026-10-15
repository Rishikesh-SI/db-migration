-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_upd_notification_status(numeric)
-- Type: FUNCTION

-- Name: gpn_upd_notification_status(numeric); Type: FUNCTION; Schema: gpn_v2; Owner: -
--

CREATE FUNCTION gpn_v2.gpn_upd_notification_status(p_notification_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
begin
	
     update gpn_v2.gpn_notification set status = 1, updated_date = current_timestamp at time zone 'utc'
     where notification_id = p_notification_id;
     
     p_result := 1;
     
exception
	when others then
     	p_result := -1;
end;
$$;


--
