-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_get_user_disp_name(numeric)
-- Type: FUNCTION

-- Name: labwis_get_user_disp_name(numeric); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_get_user_disp_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.display_name
	into strict p_username
	from   labwis.labwis_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
