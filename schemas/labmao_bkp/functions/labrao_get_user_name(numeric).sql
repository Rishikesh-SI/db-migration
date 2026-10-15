-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labrao_get_user_name(numeric)
-- Type: FUNCTION

-- Name: labrao_get_user_name(numeric); Type: FUNCTION; Schema: labmao_bkp; Owner: -
--

CREATE FUNCTION labmao_bkp.labrao_get_user_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.user_name
	into strict p_username
	from   labrao.labrao_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
