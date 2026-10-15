-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1
-- Object: labecn_v1_get_user_name(numeric)
-- Type: FUNCTION

-- Name: labecn_v1_get_user_name(numeric); Type: FUNCTION; Schema: labecn_v1; Owner: -
--

CREATE FUNCTION labecn_v1.labecn_v1_get_user_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.user_name
	into strict p_username
	from   labecn_v1.labecn_v1_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
