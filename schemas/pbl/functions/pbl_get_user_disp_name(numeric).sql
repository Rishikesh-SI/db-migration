-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_get_user_disp_name(numeric)
-- Type: FUNCTION

-- Name: pbl_get_user_disp_name(numeric); Type: FUNCTION; Schema: pbl; Owner: -
--

CREATE FUNCTION pbl.pbl_get_user_disp_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$  

begin
	
     select u.display_name
	into strict p_username
	from   pbl.pbl_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

  $$;


--
