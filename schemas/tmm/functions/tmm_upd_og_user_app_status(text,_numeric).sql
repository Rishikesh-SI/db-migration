-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_upd_og_user_app_status(text, numeric)
-- Type: FUNCTION

-- Name: tmm_upd_og_user_app_status(text, numeric); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_upd_og_user_app_status(p_email_id text, p_app_status numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
begin

if exists(select 1 from tmm.tmm_og_user_master where upper(email_id)=upper(p_email_id) )
then
update tmm.tmm_og_user_master
set app_status=p_app_status
where upper(email_id)=upper(p_email_id);
p_result:=1;
else 
p_result:=0;
end if;

end;
$$;


--
