-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_upd_user_password(numeric, character varying)
-- Type: FUNCTION

-- Name: abp_upd_user_password(numeric, character varying); Type: FUNCTION; Schema: abpp; Owner: -
--

CREATE FUNCTION abpp.abp_upd_user_password(p_user_id numeric, p_new_pwd character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

 
    
begin
	
    if exists (select 1 from abp.abp_user 
               where user_id = p_user_id
     			)
    then 
         update abp.abp_user set user_pwd = p_new_pwd
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
