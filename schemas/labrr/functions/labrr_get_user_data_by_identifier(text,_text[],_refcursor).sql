-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_get_user_data_by_identifier(text, text[], refcursor)
-- Type: FUNCTION

-- Name: labrr_get_user_data_by_identifier(text, text[], refcursor); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_get_user_data_by_identifier(p_identifier_type text, p_identifiers text[], p_user_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare
    v_identifier_type text;
begin
    v_identifier_type := lower(coalesce(p_identifier_type, 'user_id'));
    if p_identifiers is null or cardinality(p_identifiers) = 0 then
        open p_user_cursor for
            select null::bigint as user_id
            where  false;
        return next p_user_cursor;
        return;
    end if;
    if v_identifier_type = 'mobile_no' then
        open p_user_cursor for
        select v.*
        from       unnest(p_identifiers) as ids(val)
        join       labrr.labrr_user_data_export_v v on v.mobile_no = ids.val
        order by v.created_date desc;
    elsif v_identifier_type = 'user_guid' then
        open p_user_cursor for
        select v.*
        from       unnest(p_identifiers) as ids(val)
        join       labrr.labrr_user_data_export_v v on v.user_guid = ids.val
        order by v.created_date desc;
    else  
        open p_user_cursor for
        select v.*
        from       unnest(p_identifiers) as ids(val)
        join       labrr.labrr_user_data_export_v v on v.user_id = (ids.val)::bigint
        order by v.created_date desc;
    end if;
    return next p_user_cursor;
    return;
end;
$$;


--
