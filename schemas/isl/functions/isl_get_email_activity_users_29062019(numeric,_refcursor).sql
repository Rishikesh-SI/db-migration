-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_email_activity_users_29062019(numeric, refcursor)
-- Type: FUNCTION

-- Name: isl_get_email_activity_users_29062019(numeric, refcursor); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_email_activity_users_29062019(p_activity_id numeric, p_users refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	v_batch_id numeric;
begin
	select min(batch_id) into v_batch_id from isl.isl_email_activity_user_map where activity_id = p_activity_id and status = 0;
    update isl.isl_email_activity_user_map set status = 1 where activity_id = p_activity_id and batch_id = v_batch_id;
	open p_users for
    select user_name as Name,email_id as EmailId
    from isl.isl_email_activity_user_map where activity_id = p_activity_id and batch_id = v_batch_id;
    return;
end;

$$;


--
