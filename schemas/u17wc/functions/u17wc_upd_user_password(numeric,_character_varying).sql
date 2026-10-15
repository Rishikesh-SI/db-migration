-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_upd_user_password(numeric, character varying)
-- Type: FUNCTION

-- Name: u17wc_upd_user_password(numeric, character varying); Type: FUNCTION; Schema: u17wc; Owner: -
--

CREATE FUNCTION u17wc.u17wc_upd_user_password(p_user_id numeric, p_new_pwd character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

 
    
begin
	
    if exists (select 1 from u17wc.u17wc_user 
               where user_id = p_user_id
     			)
    then 
         update u17wc.u17wc_user set user_pwd = p_new_pwd
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
