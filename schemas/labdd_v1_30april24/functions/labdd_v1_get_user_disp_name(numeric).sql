-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: labdd_v1_get_user_disp_name(numeric)
-- Type: FUNCTION

-- Name: labdd_v1_get_user_disp_name(numeric); Type: FUNCTION; Schema: labdd_v1_30april24; Owner: -
--

CREATE FUNCTION labdd_v1_30april24.labdd_v1_get_user_disp_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.display_name
	into strict p_username
	from   labdd_v1.labdd_v1_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
