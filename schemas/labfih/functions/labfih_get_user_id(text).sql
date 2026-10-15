-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_get_user_id(text)
-- Type: FUNCTION

-- Name: labfih_get_user_id(text); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_get_user_id(p_username text, OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
 

-- select * from labfih.labfih_user limit 1
begin

select row_to_json(tab) into p_result from(
select user_id,user_name,full_name from labfih.labfih_user
where lower(user_name) = lower(p_username) or lower(full_name) = lower(p_username))tab;

end;

 
$$;


--
