-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_ins_invitation(text, text, numeric)
-- Type: FUNCTION

-- Name: stn_ins_invitation(text, text, numeric); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_ins_invitation(p_email_id text, p_mobile_no text, p_team_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
	
	v_email_id text := upper(trim(p_email_id));
	v_invitation_id numeric;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	
begin
	
	if not exists(select 1 from stn.stn_invitation where upper(trim(email_id)) = v_email_id and team_id = p_team_id) then
		
		v_invitation_id := nextval('stn.seq_stn_invitation_id');
		
		insert into stn.stn_invitation(invitaton_id,email_id,mobile_no,team_id,status,created_date,updated_date,is_active,is_deleted,
												invitation_guid)
		select v_invitation_id,v_email_id,p_mobile_no,p_team_id,0,v_current_timestamp,v_current_timestamp,1,0,uuid_generate_v4();
		
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
