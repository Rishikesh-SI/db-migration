-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: labecn_get_user_name(numeric)
-- Type: FUNCTION

-- Name: labecn_get_user_name(numeric); Type: FUNCTION; Schema: labecn; Owner: -
--

CREATE FUNCTION labecn.labecn_get_user_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.user_name
	into strict p_username
	from   labecn.labecn_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
