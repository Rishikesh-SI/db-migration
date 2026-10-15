-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: labadkr_get_user_name(numeric)
-- Type: FUNCTION

-- Name: labadkr_get_user_name(numeric); Type: FUNCTION; Schema: labadkr; Owner: -
--

CREATE FUNCTION labadkr.labadkr_get_user_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.user_name
	into strict p_username
	from   labadkr.labadkr_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
