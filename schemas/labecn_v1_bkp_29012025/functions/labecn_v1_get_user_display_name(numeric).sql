-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1_bkp_29012025
-- Object: labecn_v1_get_user_display_name(numeric)
-- Type: FUNCTION

-- Name: labecn_v1_get_user_display_name(numeric); Type: FUNCTION; Schema: labecn_v1_bkp_29012025; Owner: -
--

CREATE FUNCTION labecn_v1_bkp_29012025.labecn_v1_get_user_display_name(p_userid numeric, OUT p_userdisplayname character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.display_name
	into strict p_userdisplayname
	from   labecn_v1.labecn_v1_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_userdisplayname := ' ';

end;

 $$;


--
