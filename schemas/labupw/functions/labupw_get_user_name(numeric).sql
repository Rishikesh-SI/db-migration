-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupw
-- Object: labupw_get_user_name(numeric)
-- Type: FUNCTION

-- Name: labupw_get_user_name(numeric); Type: FUNCTION; Schema: labupw; Owner: -
--

CREATE FUNCTION labupw.labupw_get_user_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.user_name
	into strict p_username
	from   labupw.labupw_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
