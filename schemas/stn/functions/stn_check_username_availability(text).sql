-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_check_username_availability(text)
-- Type: FUNCTION

-- Name: stn_check_username_availability(text); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_check_username_availability(p_user_name text, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

begin
	
	if not exists(select 1 from stn.stn_user_info where upper(trim(user_name)) = upper(trim(p_user_name))) then
		p_result := 1;
	else
		p_result := 0;
	end if;
	
exception
	when others then
		p_result := -1;
	
end;

$$;


--
