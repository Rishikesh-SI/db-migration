-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: labjdtest_get_user_disp_name(numeric)
-- Type: FUNCTION

-- Name: labjdtest_get_user_disp_name(numeric); Type: FUNCTION; Schema: labjdtest; Owner: -
--

CREATE FUNCTION labjdtest.labjdtest_get_user_disp_name(p_userid numeric, OUT p_username character varying) RETURNS character varying
    LANGUAGE plpgsql
    AS $$ 

begin
	
     select u.display_name
	into strict p_username
	from   labJDTEST.labJDTEST_user u
	where  user_id = p_userid;
	
exception
	when no_data_found then
     	p_username := ' ';

end;

 $$;


--
