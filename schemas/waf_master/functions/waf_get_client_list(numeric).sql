-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_get_client_list(numeric)
-- Type: FUNCTION

-- Name: waf_get_client_list(numeric); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_get_client_list(p_client_id numeric, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

declare
v_is_master numeric;
v_client varchar(2000):= ' ';
begin

/*
select is_master into strict v_is_master 
from  waf_master.waf_client
where client_id=p_client_id;
 */
     
select is_master into v_is_master 
from  waf_master.waf_client
where client_id=p_client_id;

         
           
           if coalesce(v_is_master,0) = 0 then 
           		v_client := ' and client_id = '||p_client_id   ;
           end if;       

          if  p_client_id is null then 
          select ('{"data":['||string_agg(row_to_json(tab)::text,',')||']}')::jsonb rowjson
          from (select a.client_id,a.client_display_name client_name,a.client_display_name,a.is_master,a.created_date,a.updated_date,a.created_by,
				a.updated_by,a.is_active,a.is_deleted,a.client_end_point,a.client_port_number,a.client_database_name,a.client_schema_name,
				a.client_prefix,a.client_guid,a.client_code,a.bootstrap_version,
				a.client_json,a.domain_url
                from waf_master.waf_client a) tab into p_data ;
          else 
              
			  --raise notice '%',v_client;
			 -- select 1/0;
			 
			  execute 'select (''{"data":[''||string_agg(row_to_json(tab)::text,'','')||'']}'')::jsonb 
			  
          from ( select * from waf_master.waf_client 
                            where is_master <>1 and client_id =$1
				)tab '
               into p_data
			   using p_client_id ;
							
							 raise notice '%',p_data;
			--select 1/0;
           end if ; 
       
 /* exception     
       when others then 
       open p_client_cur for  select * from waf_master.waf_client where  1=2;
   */  
end

$_$;


--
