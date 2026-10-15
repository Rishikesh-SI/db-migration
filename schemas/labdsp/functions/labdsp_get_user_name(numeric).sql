-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_get_user_name(numeric)
-- Type: FUNCTION

-- Name: labdsp_get_user_name(numeric); Type: FUNCTION; Schema: labdsp; Owner: -
--

CREATE FUNCTION labdsp.labdsp_get_user_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.user_name
	into strict p_username
	from   labdsp.labdsp_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
