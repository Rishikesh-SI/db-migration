-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_upd_user_password_20171108(numeric, character varying)
-- Type: FUNCTION

-- Name: khi_upd_user_password_20171108(numeric, character varying); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_upd_user_password_20171108(p_user_id numeric, p_new_pwd character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

 
    
begin
	
    if exists (select 1 from khi.khi_user 
               where user_id = p_user_id
     			)
    then 
         update khi.khi_user set user_pwd = p_new_pwd
         where user_id = p_user_id ; 
	
       	p_result := 1;
    else 
    	p_result := 0;
    end if ;
    
  exception
	when others then
     	p_result := -1;
	
end;

 

$$;


--
