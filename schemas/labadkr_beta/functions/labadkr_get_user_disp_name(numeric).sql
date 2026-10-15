-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr_beta
-- Object: labadkr_get_user_disp_name(numeric)
-- Type: FUNCTION

-- Name: labadkr_get_user_disp_name(numeric); Type: FUNCTION; Schema: labadkr_beta; Owner: -
--

CREATE FUNCTION labadkr_beta.labadkr_get_user_disp_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.display_name
	into strict p_username
	from   labadkr.labadkr_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
