-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: labkc_v1_get_user_disp_name(numeric)
-- Type: FUNCTION

-- Name: labkc_v1_get_user_disp_name(numeric); Type: FUNCTION; Schema: labkc_v1_bkp; Owner: -
--

CREATE FUNCTION labkc_v1_bkp.labkc_v1_get_user_disp_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.display_name
	into strict p_username
	from   labkc_v1.labkc_v1_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
