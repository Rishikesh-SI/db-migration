-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: labgmr_get_user_name(numeric)
-- Type: FUNCTION

-- Name: labgmr_get_user_name(numeric); Type: FUNCTION; Schema: labgmr; Owner: -
--

CREATE FUNCTION labgmr.labgmr_get_user_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.user_name
	into strict p_username
	from   labgmr.labgmr_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
