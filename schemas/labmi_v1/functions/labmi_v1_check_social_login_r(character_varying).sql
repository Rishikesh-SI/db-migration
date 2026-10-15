-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_check_social_login_r(character varying)
-- Type: FUNCTION

-- Name: labmi_v1_check_social_login_r(character varying); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_check_social_login_r(p_user_guid character varying, OUT p_output numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare

     v_versionnumber numeric;
   

begin
    p_output:=1;

    if  exists(select 1 from labmi_v1.labmi_v1_web_user
	where user_guid=p_user_guid and client_id=5) then
   	p_output:=0;
	end if;

 
exception

  when others then
p_output := -1;
end;

$$;


--
