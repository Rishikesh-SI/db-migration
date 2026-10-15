-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_accept_invitation(numeric, numeric)
-- Type: FUNCTION

-- Name: stn_accept_invitation(numeric, numeric); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_accept_invitation(p_user_id numeric, p_team_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

begin
	
	if p_user_id is not null and p_team_id is not null then
		
		update stn.stn_invitation i
		set status = 1
		from stn.stn_user_info ui
		where ui.email_id = i.email_id
		and ui.mobile_no = i.mobile_no
		and ui.user_id = p_user_id
		and i.team_id = p_team_id;
		
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
