-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_get_user_display_name(numeric)
-- Type: FUNCTION

-- Name: labisl_v1_get_user_display_name(numeric); Type: FUNCTION; Schema: labisl_v1; Owner: -
--

CREATE FUNCTION labisl_v1.labisl_v1_get_user_display_name(p_userid numeric, OUT p_userdisplayname character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.display_name
	into strict p_userdisplayname
	from   labisl_v1.labisl_v1_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_userdisplayname := ' ';

end;

 $$;


--
