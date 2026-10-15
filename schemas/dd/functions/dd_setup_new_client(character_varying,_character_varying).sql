-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_setup_new_client(character varying, character varying)
-- Type: FUNCTION

-- Name: dd_setup_new_client(character varying, character varying); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_setup_new_client(source_db_name character varying, client_db_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$

declare
	
	v_data_object_cursor_row record;
    v_data_object_script text;
    v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
    
begin
	
    create temp table t_data_object_script
    (
        c_data_object_script text
    );
    
 
    
    begin
    	
        
        
        insert into t_data_object_script(c_data_object_script)
        select pg_get_functiondef(p.oid) as func_def
        from   (select oid, *
                from   pg_proc p
                where  not p.proisagg) p
		join   pg_namespace n
        on     n.oid = p.pronamespace
        where  n.nspname = source_db_name;
    	
    	for v_data_object_cursor_row in select c_data_object_script from t_data_object_script where c_data_object_script is not null
    	loop
        	v_data_object_script := v_data_object_cursor_row.c_data_object_script;
        	v_data_object_script := replace(v_data_object_script, source_db_name, client_db_name);
			v_data_object_script := replace(v_data_object_script, upper(source_db_name), client_db_name);
        	execute ''||v_data_object_script||'';
    	end loop;
        
	end;
    
    drop table t_data_object_script;
    
    execute ''||'grant select, insert, update, delete on all tables in schema '||client_db_name||' to wafagent'||'';
	execute ''||'grant select, insert, update, delete on all tables in schema '||client_db_name||' to wafdbdev'||'';
	execute ''||'grant select, insert, update, delete on all tables in schema '||client_db_name||' to wafwebdev'||'';
    execute ''||'grant execute on all functions in schema '||client_db_name||' to wafagent'||'';
	execute ''||'grant execute on all functions in schema '||client_db_name||' to wafdbdev'||'';
	execute ''||'grant execute on all functions in schema '||client_db_name||' to wafwebdev'||'';
    execute ''||'grant select, update on all sequences in schema '||client_db_name||' to wafagent'||'';
	execute ''||'grant select, update on all sequences in schema '||client_db_name||' to wafdbdev'||'';
	execute ''||'grant select, update on all sequences in schema '||client_db_name||' to wafwebdev'||'';
	
    
	
end;

$$;


--
