-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_user_name(numeric)
-- Type: FUNCTION

-- Name: isl_get_user_name(numeric); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_user_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$     

begin
	
     select u.user_name
	into strict p_username
	from   isl.isl_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

     $$;


--
