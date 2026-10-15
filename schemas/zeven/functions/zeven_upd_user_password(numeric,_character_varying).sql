-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_upd_user_password(numeric, character varying)
-- Type: FUNCTION

-- Name: zeven_upd_user_password(numeric, character varying); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_upd_user_password(p_user_id numeric, p_new_pwd character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

 
    
begin
	
    if exists (select 1 from zeven.zeven_user 
               where user_id = p_user_id
     			)
    then 
         update zeven.zeven_user set user_pwd = p_new_pwd
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
