-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_get_client_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: waf_get_client_detail(numeric, numeric); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_get_client_detail(p_client_id numeric, verno numeric, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
v_is_master numeric;
v_client varchar(2000):= ' ';
v_version_no varchar(2000):= ' ';
max_version numeric;
begin

insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'try_log_tri_waf','logs',uuid_generate_v4(),p_data,current_timestamp,'siwaf','logs');

raise notice 'client_id%',p_client_id;
  
select is_master into v_is_master 
from  waf_master.waf_client
where client_id=p_client_id;

 raise notice '2. client%',p_client_id;
select max(version_number) into max_version
from waf_master.waf_client_draft
where client_id=p_client_id ;

           if verno is null then
                verno= max_version;
           end if; 
           
           if coalesce(v_is_master,0) = 0 then 
           		v_client := ' and b.client_id = '||p_client_id   ;
           end if;       

  		  if max_version is not null then

          if  p_client_id is not null then  
               
                v_version_no :='and a.version_number='||verno;
                execute 'select a.client_json from waf_master.waf_client_draft a
                            JOIN waf_master.waf_client b on a.client_id=b.client_id 
                            where b.is_master <>1'||v_client || v_version_no
                            into p_data;
                
           end if ; 
		   
           else 
		   
		   execute 'select b.client_json from waf_master.waf_client b
                            where b.is_master <>1'||v_client
                            into p_data;

   		   end if;

           p_data :=jsonb_set(p_data,'{max_version_number}',
                                        ('"'||coalesce(max_version,0)||'"')::text::jsonb,true);
                
           p_data :=jsonb_set(p_data,'{current_version_number}',
                                        ('"'||coalesce(verno,0)||'"')::text::jsonb,true);
       
 /* exception     
       when others then 
       open p_client_cur for  select * from waf_master.waf_client where  1=2;
   */  
end

$$;


--
