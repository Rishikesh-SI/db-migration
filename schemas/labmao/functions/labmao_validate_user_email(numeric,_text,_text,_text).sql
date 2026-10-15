-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao
-- Object: labmao_validate_user_email(numeric, text, text, text)
-- Type: FUNCTION

-- Name: labmao_validate_user_email(numeric, text, text, text); Type: FUNCTION; Schema: labmao; Owner: -
--

CREATE FUNCTION labmao.labmao_validate_user_email(p_opt_type numeric, p_email_id text, p_mobile_no text, p_password text, OUT p_out numeric, OUT p_user_guid text, OUT p_user_name text) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
v_exists numeric;

begin

select count(1) 
from labmao.labmao_user_master
where (email_id= p_email_id or mobile_no=p_mobile_no)
and payment_status=1 and usr_password =p_password
 into v_exists ;

if v_exists>0 then
        p_out:=1;

		if p_opt_type =2 then
			select user_guid,user_name
			from labmao.labmao_user_master
			where (email_id= p_email_id or mobile_no=p_mobile_no)
			and payment_status=1
			and usr_password =p_password
			into p_user_guid,p_user_name ;
		end if;
else
		p_out:=0;
		p_user_guid:=null;
		
			if p_opt_type =2 then
				p_out:=0;
				p_user_guid:= 'Invalid User Credentials';
			end if;

end if;
/*
exception when others then
p_out:=-1;
p_user_guid:=null;*/

end;
$$;


--
