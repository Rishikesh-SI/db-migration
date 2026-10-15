-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_get_user_display_name(numeric)
-- Type: FUNCTION

-- Name: hsl_get_user_display_name(numeric); Type: FUNCTION; Schema: hsl; Owner: -
--

CREATE FUNCTION hsl.hsl_get_user_display_name(p_userid numeric, OUT p_userdisplayname character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.display_name
	into strict p_userdisplayname
	from   hsl.hsl_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_userdisplayname := ' ';

end;

 $$;


--
