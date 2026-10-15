-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_get_user_disp_name(numeric)
-- Type: FUNCTION

-- Name: labos_get_user_disp_name(numeric); Type: FUNCTION; Schema: labos; Owner: -
--

CREATE FUNCTION labos.labos_get_user_disp_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.display_name
	into strict p_username
	from   labos.labos_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
