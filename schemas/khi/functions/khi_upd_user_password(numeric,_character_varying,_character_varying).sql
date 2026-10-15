-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_upd_user_password(numeric, character varying, character varying)
-- Type: FUNCTION

-- Name: khi_upd_user_password(numeric, character varying, character varying); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_upd_user_password(p_user_id numeric, p_resetkey character varying, p_new_pwd character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
 v_currenttimestamp timestamp;
 v_user_id numeric;
    
begin
	v_currenttimestamp := current_timestamp at time zone 'utc';
    
    if (coalesce(p_user_id,0) <> 0 ) 
    then 
        if exists (select 1 from khi.khi_user where user_id = p_user_id )
        then 
             update khi.khi_user set user_pwd = p_new_pwd
             where user_id = p_user_id ; 

            p_result := 1;
        else 
            p_result := 0;
        end if ;
    else
    	if exists(select 1 from khi.khi_forget_password 
                  where reset_key_guid = p_resetkey
                  and key_expiry_date >= v_currenttimestamp
            	  and is_active = 1 and is_deleted = 0)
        then
        	select user_id into v_user_id 
                from khi.khi_forget_password 
                where reset_key_guid = p_resetkey                  
            	and is_active = 1 and is_deleted = 0 ;
                  
                 update khi.khi_user set user_pwd = p_new_pwd
             	 where user_id = v_user_id ; 
                 
                 p_result := 1;
        else
        	p_result := -3 ;-- reset password date is expired 
        end if;
        
    end if ; 
    
  exception
	when others then
     	p_result := -1;
	
end;

 

$$;


--
