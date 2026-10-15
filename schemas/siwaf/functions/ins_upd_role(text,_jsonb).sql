-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_upd_role(text, jsonb)
-- Type: FUNCTION

-- Name: _ins_upd_role(text, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_upd_role(p_schema text, p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
--do
--$$
declare
/*p_data jsonb;
p_result numeric;
p_schema text :='lb_dev';
p_json jsonb:='';
*/
-----------------
v_role_name text;
v_role_desc text;
v_is_active numeric;
v_role_id numeric;
v_created_by numeric;
v_sysdate timestamp := current_timestamp at time zone 'utc';
v_menu jsonb;
v_menu_json json;
v_menu_id numeric;
v_sub_menu jsonb;
v_sub_menu_json jsonb;
v_menu_action jsonb;
v_sub_menu_id numeric;
v_menu_action_json jsonb; 
v_action_id numeric;
v_is_active_action numeric;
v_role_guid text;
err_msg text;
v_error_check text;
v_role_menu_action_id numeric;
v_menu_extst numeric;
v_menu_extst_1 numeric;
v_is_lb numeric;
begin

		select  p_json->'data'->>'role_name',
        		p_json->'data'->>'role_desc',
   				p_json->'data'->>'is_active',
				p_json->'data'->>'role_id',
				p_json->'data'->>'created_by',
				p_json->'data'->>'is_lb',
				p_json->'data'->'menu'
		into    v_role_name,
				v_role_desc,
				v_is_active,
				v_role_id,
				v_created_by,
				 v_is_lb,
				v_menu
				;

if v_role_id is null then 

			--v_role_id:=nextval('lb_dev.seq_lb_dev_role_id');
			execute 'select nextval('''||p_schema||'.seq_'||p_schema||'_role_id'')'
			into v_role_id
			using p_schema;
            v_role_guid:=uuid_generate_v4();
			
			p_json := jsonb_set(p_json, '{data,role_id}', v_role_id::text::jsonb, true);
		--raise notice'% testtt',p_json;    
---select 1/0;		
	
	
	

execute 'insert into '||p_schema||'.'||p_schema||'_role
select $2,$3,$4,$5,$6,$6,$7,$7,$8,0,1,$9,$10,0,$11'
using p_schema,v_role_id,v_role_name,v_role_name,v_role_desc,v_sysdate,
v_created_by,v_is_active,v_role_guid,p_json::jsonb,v_is_lb;

for v_menu_json in select * from jsonb_array_elements(v_menu)	
loop
 	select  	v_menu_json->'actions',
         		v_menu_json->'menu_id',
        		v_menu_json->'is_active'
 	into    	v_menu_action,
        	 	v_menu_id,
 				v_is_active ;
  -- v_role_menu_action_id:= nextval('lb_dev.seq_lb_dev_user_role_menu_action_map');
  
  execute 'select nextval('''||p_schema||'.seq_'||p_schema||'_user_role_menu_action_map'')'
	into v_role_menu_action_id
	using p_schema;
execute 'insert into '||$1||'.'||$1||'_user_role_menu_action_map2
select $2,$3,$4,null,$5,$6'
using p_schema,v_role_menu_action_id,v_role_id,v_menu_id,v_is_active,v_sysdate;

   /*for v_sub_menu_json in select * from jsonb_array_elements(v_sub_menu)	
   loop
     select  v_sub_menu_json->'actions',
             v_sub_menu_json->'sub_menu_id'
     into    v_menu_action,
             v_sub_menu_id;*/
      for v_menu_action_json in select * from jsonb_array_elements(v_menu_action)	
      loop
		select  v_menu_action_json->'action_id',
       			v_menu_action_json->'is_active'
		into  	v_action_id ,
      			v_is_active_action;
 			-- raise notice '% action',	v_action_id;
 			-- raise notice '%',	v_sub_menu_id;	
			-- v_role_menu_action_id:= nextval('lb_dev.seq_lb_dev_user_role_menu_action_map');
			 execute 'select nextval('''||p_schema||'.seq_'||p_schema||'_user_role_menu_action_map'')'
			into v_role_menu_action_id
			using p_schema;
			
			execute 'insert into '||$1||'.'||$1||'_user_role_menu_action_map2
			select $2,$3,$4,$5,$6,$7'
			using p_schema,v_role_menu_action_id,v_role_id,v_menu_id,v_action_id,v_is_active_action,v_sysdate;

   --   raise notice '% is active',	v_is_active_action;
      end loop;
          -- raise notice '%',	v_menu_action;
    -- end loop;
 --raise notice '%',	v_sub_menu;
 --raise notice '%',	v_menu_id;
end loop;

else 

 execute  'update '||p_schema||'.'||p_schema||'_role
  set	role_name=$2,
  		role_display_name=$3,
		role_desc=$4,
		updated_date=$5,
		role_json=$6,
		is_active=$8,
		is_lb=$9
  where role_id=$7'
  using p_schema,v_role_name,v_role_name,v_role_desc,v_sysdate,p_json,v_role_id ,v_is_active,v_is_lb;
  
  for v_menu_json in select * from jsonb_array_elements(v_menu)	
	loop
 	select  v_menu_json->'actions',
         	v_menu_json->'menu_id',
         	v_menu_json->'is_active'
 	into    v_menu_action,
         	v_menu_id,
         	v_is_active ;
begin

  -- raise notice '% v_role_menu_action_id',v_role_menu_action_id;
    execute 'select count(1) from '||p_schema||'.'||p_schema||'_user_role_menu_action_map2
	where user_menu_id=$2 and role_id =$3
	and user_action_id is null '
	into v_menu_extst 
	 using p_schema,v_menu_id,v_role_id;
 
 if v_menu_extst >0 then 
    
   execute 'update '||p_schema||'.'||p_schema||'_user_role_menu_action_map2
   set is_active=$2
   where user_menu_id=$3
   and user_action_id is null 
   and role_id=$4'
   using p_schema,v_is_active,v_menu_id,v_role_id;
     
else 

 execute 'select nextval('''||p_schema||'.seq_'||p_schema||'_user_role_menu_action_map'')'
	into v_role_menu_action_id
	using p_schema;
execute 'insert into '||$1||'.'||$1||'_user_role_menu_action_map2
select $2,$3,$4,null,$5,$6'
using p_schema,v_role_menu_action_id,v_role_id,v_menu_id,v_is_active,v_sysdate;

end if;
-- raise notice '% new insert %',v_menu_id,v_role_id;
end ;

for v_menu_action_json in select * from jsonb_array_elements(v_menu_action)	
      loop
      select v_menu_action_json->'action_id',
             v_menu_action_json->'is_active'
      into   v_action_id ,
             v_is_active_action;
      begin 
	 
	 execute 'select count(1) from '||p_schema||'.'||p_schema||'_user_role_menu_action_map2
	where user_menu_id=$2 and role_id =$3
	and user_action_id =$4 '
	into v_menu_extst_1 
	 using p_schema,v_menu_id,v_role_id,v_action_id;
	 if v_menu_extst_1>0 then
	  
	    execute  'update '||p_schema||'.'||p_schema||'_user_role_menu_action_map2
         set is_active=$2
         where user_menu_id=$3
	     and  user_action_id is not null
	     and user_action_id=$4
	     and role_id=$5'
		using p_schema,v_is_active,v_menu_id,v_action_id,v_role_id;
		
	else 
	
			execute 'select nextval('''||p_schema||'.seq_'||p_schema||'_user_role_menu_action_map'')'
			into v_role_menu_action_id
			using p_schema;
			
			execute 'insert into '||$1||'.'||$1||'_user_role_menu_action_map2
			select $2,$3,$4,$5,$6,$7'
			using p_schema,v_role_menu_action_id,v_role_id,v_menu_id,v_action_id,v_is_active_action,v_sysdate;

	
	end if;
  end;
  
end loop;

end loop;

  

end if ;

 --raise notice '%',v_menu_id;
 -- raise notice '%',v_menu;

 -- select * from lb_dev.lb_dev_user_role_menu_action_map1;
p_result:=1;
p_data :=p_json;
 /*
exception when others then 

 get stacked diagnostics 
 v_error_check =pg_exception_context;
          err_msg := SQLERRM;
		  raise notice '%',err_msg;
		  --select 1/0;
		  if err_msg='INSERT has more expressions than target columns'
		  then 
		  execute 'alter table '||p_schema||'.'||p_schema||'_role
		  add column is_lb numeric';
		  
		  end if;
 p_result := -1;
 p_data := '{"Error_message" :"'||coalesce(err_msg||'-'||v_error_check, '')||'"}';	
 */
end;
$_$;


--
