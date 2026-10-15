-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_check_watch_party_exist_r(text)
-- Type: FUNCTION

-- Name: dd_check_watch_party_exist_r(text); Type: FUNCTION; Schema: dd_30_04_24; Owner: -
--

CREATE FUNCTION dd_30_04_24.dd_check_watch_party_exist_r(p_user_guid text, OUT p_out numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare
v_count numeric;
begin

select count(1)
from dd.dd_client_web_cust_model
where module_name='watch-party'
and client_mod_json->>'user_guid'=p_user_guid
into v_count;

if v_count >0 then
p_out:=1;
else 
p_out:=0;
end if;

end;
$$;


--
