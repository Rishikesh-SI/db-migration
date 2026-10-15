-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_check_user_guid_and_mobilenum_exist_r(character varying, character varying)
-- Type: FUNCTION

-- Name: labisl_v1_check_user_guid_and_mobilenum_exist_r(character varying, character varying); Type: FUNCTION; Schema: labisl_v1; Owner: -
--

CREATE FUNCTION labisl_v1.labisl_v1_check_user_guid_and_mobilenum_exist_r(p_user_guid character varying, p_mobile_no character varying, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	v_mobile_no character varying(1000) := p_mobile_no;
	v_user_guid character varying(1000) := p_user_guid;
	v_status numeric;
	v_msg text;

begin
	
		 
		 -- raise notice '% ,% ',v_mobile_no,v_email_id;
		 
	if exists(select 1 from labisl_v1.labisl_v1_web_user where user_guid = v_user_guid and mobile_no = v_mobile_no) then
			
			v_status := 1;
			v_msg	:=	'User Exists With Given User_Guid and Mobile_no';
			
	else 
	
			v_status := 0;
			v_msg	:= 'User Doesn''t Exists With Given User_Guid and Mobile_no';
	
	end if;
		
	
	p_data := '{
				"status": "'|| coalesce(v_status::varchar,'')||'",
				 "message": "'|| coalesce(v_msg,'')||'"
  			}';

    
	

end;
$$;


--
