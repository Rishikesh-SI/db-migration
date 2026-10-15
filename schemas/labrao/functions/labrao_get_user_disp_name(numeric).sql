-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrao
-- Object: labrao_get_user_disp_name(numeric)
-- Type: FUNCTION

-- Name: labrao_get_user_disp_name(numeric); Type: FUNCTION; Schema: labrao; Owner: -
--

CREATE FUNCTION labrao.labrao_get_user_disp_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.display_name
	into strict p_username
	from   labrao.labrao_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
