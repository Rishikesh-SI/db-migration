-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: copy_function(character varying, character varying)
-- Type: FUNCTION

-- Name: copy_function(character varying, character varying); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.copy_function(p_schema_name character varying, p_sp_name character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_schema_name character varying;
v_sp_name character varying ;
v_sp_name_new character varying ;
v_sp_script character varying;
v_sp_alter character varying;

i record;
begin
v_schema_name := p_schema_name;
v_sp_name := p_sp_name;

for i in select * from(select distinct schema_name 
                       from information_schema.schemata
                        where schema_name not like 'pg_%' 
					and schema_name not in ('public','information_schema','labfih')
					)a
loop                       
  v_sp_name_new:= v_sp_name;
  v_sp_name_new:= replace(v_sp_name_new,v_schema_name,i.schema_name );
  
if exists(select 1 from pg_proc 
          where upper(proname) = upper(v_sp_name_new)) 
 then 
 
      SELECT 'ALTER FUNCTION ' || ns.nspname || '.' || proname 
            || '(' || oidvectortypes(proargtypes) || ')'|| 'RENAME TO '|| proname||'_'||TO_CHAR(NOW() :: DATE, 'ddmmyyyy')||'_'||
            SUBSTRING(uuid_generate_v4()::text,1,4)||';' into v_sp_alter 
     FROM pg_proc INNER JOIN pg_namespace ns ON (pg_proc.pronamespace = ns.oid)
     WHERE ns.nspname = i.schema_name and upper(proname) = upper(v_sp_name_new)
     order by proname;
     
     select pg_get_functiondef(oid) into v_sp_script
           from pg_proc
           where proname = v_sp_name;
           
       v_sp_script := replace(v_sp_script,v_schema_name,i.schema_name );
           
     execute v_sp_alter ;
     execute v_sp_script ;
     
    execute ''||'grant execute on all functions in schema '||i.schema_name||' to postgres'||'';
	execute ''||'grant execute on all functions in schema '||i.schema_name||' to PUBLIC'||'';
	execute ''||'grant execute on all functions in schema '||i.schema_name||' to wafagent'||'';

    
    p_result := 1; 

else
        
        select pg_get_functiondef(oid) into v_sp_script
           from pg_proc
           where proname = v_sp_name;
     v_sp_script := replace(v_sp_script,v_schema_name,i.schema_name );      
   
    execute v_sp_script ;
     
    execute ''||'grant execute on all functions in schema '||i.schema_name||' to postgres'||'';
	execute ''||'grant execute on all functions in schema '||i.schema_name||' to PUBLIC'||'';
	execute ''||'grant execute on all functions in schema '||i.schema_name||' to wafagent'||'';

    
    p_result := 1; 
  end if;                                   
end loop;

exception when others then
p_result := -1;

end;

$$;


--
