-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_get_client_detail_bkp(numeric)
-- Type: FUNCTION

-- Name: waf_get_client_detail_bkp(numeric); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_get_client_detail_bkp(p_client_id numeric, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
v_is_master numeric;
v_client varchar(2000):= ' ';
begin

     
select is_master into v_is_master 
from  waf_master.waf_client
where client_id=p_client_id;

         
           
           if coalesce(v_is_master,0) = 0 then 
           		v_client := ' and client_id = '||p_client_id   ;
           end if;       

          if  p_client_id is not null then 
          		
				
        
                execute 'select client_json from waf_master.waf_client 
                            where is_master <>1 '||v_client
                            into p_data;
           end if ; 
       
 /* exception     
       when others then 
       open p_client_cur for  select * from waf_master.waf_client where  1=2;
   */  
end

$$;


--
