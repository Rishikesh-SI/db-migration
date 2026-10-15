-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ttmum_upd_user_password(numeric, character varying)
-- Type: FUNCTION

-- Name: ttmum_upd_user_password(numeric, character varying); Type: FUNCTION; Schema: ttmum; Owner: -
--

CREATE FUNCTION ttmum.ttmum_upd_user_password(p_user_id numeric, p_new_pwd character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

 
    
begin
	
    if exists (select 1 from ttmum.ttmum_user 
               where user_id = p_user_id
     			)
    then 
         update ttmum.ttmum_user set user_pwd = p_new_pwd
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
