-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_get_user_display_name(numeric)
-- Type: FUNCTION

-- Name: labkkr_v1_get_user_display_name(numeric); Type: FUNCTION; Schema: labkkr_v1; Owner: -
--

CREATE FUNCTION labkkr_v1.labkkr_v1_get_user_display_name(p_userid numeric, OUT p_userdisplayname character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.display_name
	into strict p_userdisplayname
	from   labkkr_v1.labkkr_v1_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_userdisplayname := ' ';

end;

 $$;


--
