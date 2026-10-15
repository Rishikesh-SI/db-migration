-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_usr_login(character varying, character varying, character varying, refcursor)
-- Type: FUNCTION

-- Name: waf_usr_login(character varying, character varying, character varying, refcursor); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_usr_login(p_client_code character varying, p_user_name character varying, p_user_pwd character varying, p_user_cur refcursor, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$

declare 

v_client_id numeric;
v_user_id numeric;
-- v_user_pwd varchar;
v_result numeric;
v_is_master numeric;
v_count numeric;
v_client varchar(2000):=' ';

v_client_code varchar(200);
v_user_name   varchar(200);
v_user_pwd   varchar(200);
v_user_client_map_id numeric;
v_schema_prefix varchar(1000);
v_data jsonb;
v_role_id numeric;
begin 

v_client_code:=upper(p_client_code);
v_user_name  :=upper(p_user_name)  ;
v_user_pwd    :=upper(p_user_pwd)   ;

select client_schema_name into v_schema_prefix
from waf_master.waf_client
where upper(client_code) = upper(v_client_code); 

execute 'select role_id from '||v_schema_prefix||'.'||v_schema_prefix||'_user_role a
		 join '||v_schema_prefix||'.'||v_schema_prefix||'_user b on a.user_id=b.user_id
		 where upper(b.user_name)= $1'
		 into v_role_id
		using v_user_name;
		
	--raise notice '% ',v_role_id;	
	--select 1/0;

if (p_client_code is not null and p_user_name is not null and p_user_pwd is not null)
then 
    begin 
        select client_id into strict v_client_id from waf_master.waf_client
        where upper(client_code)=v_client_code;
		
		
           
            begin 
              select user_id into strict v_user_id
                  from waf_master.waf_user
                  where upper(user_name)=v_user_name;
                    
					--raise notice '% ',v_user_id;
					--select 1/0;
					
                    begin
                              select user_id into strict v_user_id
                              from waf_master.waf_user
                              where upper(user_name)=v_user_name
                              and upper(user_pwd)=v_user_pwd;
                              
                              begin 
                              
                                       select user_client_map_id into strict v_user_client_map_id  
                                       from waf_master.waf_user_client_map
                                       where user_id=v_user_id
                                       and client_id=v_client_id;
                                   
                                     if v_user_client_map_id is not null 
                                     then p_result := 1;
                                     
                                     
                                     end if;
                               exception 
                               when no_data_found then 
                               p_result := -5;
                               end;
                              
                     exception 
                     when no_data_found then 
                      p_result := -3;
                      end ;     
  
          exception 
          when no_data_found then 
          p_result := -2;
         end;
         
        exception 
       when no_data_found then 
        p_result :=  -4;
    end ;
    
    
end if;

/*execute 'select row_to_json(r,true) 
from (
select 
json_agg(tab) as menu,
r.role_id,
r.role_name,
r.role_desc,
r.created_by
from (
SELECT
d.user_menu_id as menu_id,   
d.menu_name as title,
d.css_class as CSSclass,
d.redirect_url as link,	
d.menu_level,
d.menu_ord,
d.is_visible,	
coalesce(d.parent_id,0) as parent_id,    
dc.role_id,
jsonb_agg(tab) AS actions
FROM siwaf.siwaf_user_menu d
INNER JOIN '||v_schema_prefix||'.'||v_schema_prefix||'_user_role_menu_action_map2 dc 
           ON (dc.user_menu_id = d.user_menu_id ) 
		   and (dc.user_action_id is null)
    left join (select user_action_id as action_id,action_name ,
			    cm.role_menu_action_id ,cm.is_active,ma.status_flg
                ,cm.user_menu_id,ordring as order_by
					from siwaf.siwaf_menu_action ma
        INNER JOIN '||v_schema_prefix||'.'||v_schema_prefix||'_user_role_menu_action_map2  cm 
		ON  (ma.menu_action_id = cm.user_action_id ) 
		  where cm.is_active=1
			and cm.role_id=$1) tab 
		on tab.user_menu_id=dc.user_menu_id
     where dc.role_id=$1
	 and dc.is_active=1
	 and d.module_flag=2
	 group by d.user_menu_id,   
      d.menu_name,d.parent_id,dc.role_id,d.css_class,
d.redirect_url,d.menu_level,menu_ord,d.is_visible
order by d.menu_level,menu_ord 	 asc
)tab 
join '||v_schema_prefix||'.'||v_schema_prefix||'_role r on r.role_id=tab.role_id
group by 
r.role_id,
r.role_name,
r.role_desc,
r.created_by
	)r' into  v_data
	using v_role_id;*/
--raise notice '% v_role_id',v_data;
---select 1/0;

if  p_result = 1 then 
      open p_user_cur for select a.*,b.user_id,v_data as menu_json from waf_master.waf_client a
      join waf_master.waf_user_client_map b on b.client_id=a.client_id
      where b.client_id=v_client_id
      and b.user_id=v_user_id;
     
     else 
	 
     open p_user_cur for select a.*,null as user_id from waf_master.waf_client a
     where 1=2;
     
     end if;
     

  
  
  

end

$_$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
