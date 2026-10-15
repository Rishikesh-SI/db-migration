-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_upd_notification(numeric)
-- Type: FUNCTION

-- Name: gpn_upd_notification(numeric); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_upd_notification(p_notification_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
begin
	
	update gpnv2.gpn_notification
	set status = 1
	where notification_id = p_notification_id;
	
	p_result := 1;
	
exception
	when others then
		p_result := -1;
end;
$$;


--
