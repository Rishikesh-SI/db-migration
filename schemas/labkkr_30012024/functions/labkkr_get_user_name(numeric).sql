-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: labkkr_get_user_name(numeric)
-- Type: FUNCTION

-- Name: labkkr_get_user_name(numeric); Type: FUNCTION; Schema: labkkr_30012024; Owner: -
--

CREATE FUNCTION labkkr_30012024.labkkr_get_user_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.user_name
	into strict p_username
	from   labkkr.labkkr_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
