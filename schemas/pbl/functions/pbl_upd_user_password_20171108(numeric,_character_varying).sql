-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_upd_user_password_20171108(numeric, character varying)
-- Type: FUNCTION

-- Name: pbl_upd_user_password_20171108(numeric, character varying); Type: FUNCTION; Schema: pbl; Owner: -
--

CREATE FUNCTION pbl.pbl_upd_user_password_20171108(p_user_id numeric, p_new_pwd character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

 
    
begin
	
    if exists (select 1 from pbl.pbl_user 
               where user_id = p_user_id
     			)
    then 
         update pbl.pbl_user set user_pwd = p_new_pwd
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
