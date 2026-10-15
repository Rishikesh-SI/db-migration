-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrlp
-- Object: labrlp_get_user_disp_name(numeric)
-- Type: FUNCTION

-- Name: labrlp_get_user_disp_name(numeric); Type: FUNCTION; Schema: labrlp; Owner: -
--

CREATE FUNCTION labrlp.labrlp_get_user_disp_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.display_name
	into strict p_username
	from   labrlp.labrlp_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
