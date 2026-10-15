-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: cli_stp_v1_get_user_display_name(numeric)
-- Type: FUNCTION

-- Name: cli_stp_v1_get_user_display_name(numeric); Type: FUNCTION; Schema: cli_stp_v1; Owner: -
--

CREATE FUNCTION cli_stp_v1.cli_stp_v1_get_user_display_name(p_userid numeric, OUT p_userdisplayname character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.display_name
	into strict p_userdisplayname
	from   cli_stp_v1.cli_stp_v1_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_userdisplayname := ' ';

end;

 $$;


--
