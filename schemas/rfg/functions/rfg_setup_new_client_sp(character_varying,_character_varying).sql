-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_setup_new_client_sp(character varying, character varying)
-- Type: FUNCTION

-- Name: rfg_setup_new_client_sp(character varying, character varying); Type: FUNCTION; Schema: rfg; Owner: -
--

CREATE FUNCTION rfg.rfg_setup_new_client_sp(source_db_name character varying, client_db_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $_$

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
    	
        /*insert into t_data_object_script(c_data_object_script)
    	select 'create or replace function '||sname||'.'||fname||' ('||plist||') returns '||case fdt when 'refcursor' then 'setof '||fdt else fdt end||' language ''plpgsql'' cost 100.0 as $$ '||prosrc||' $$;'
		from
		(
			select sname, fname, string_agg(pmode||' '||pname||' '||pdt, ', ') plist, fdt, string_agg(pdt1, ', ') dlist, prosrc
			from
			(
				select p.specific_schema sname, 
                		substring(p.specific_name,1,(length(p.specific_name) - position('_' in reverse(p.specific_name)))) fname, 
                		p.parameter_mode pmode, p.parameter_name pname, 
                		case p.data_type when 'ARRAY' then substring(p.udt_name, 2)||'[]' else p.data_type end pdt, r.data_type fdt, pgp.prosrc, 
                		case p.parameter_mode when 'IN' then case p.data_type when 'ARRAY' then substring(p.udt_name, 2)||'[]' else p.data_type end else ' ' end pdt1
    			from   information_schema.parameters p
        		join   information_schema.routines r
        		on     r.specific_schema = p.specific_schema
        		and    r.specific_name = p.specific_name
        		join   pg_catalog.pg_proc pgp
        		on     pgp.proname = substring(p.specific_name,1,(length(p.specific_name) - position('_' in reverse(p.specific_name))))
        		and    pgp.pronamespace = (select oid from pg_catalog.pg_namespace where nspname = source_db_name)
    			where  p.specific_schema = source_db_name
    			order by fname, p.ordinal_position
			) as tab
    		group by sname, fname, fdt, prosrc
		) as tab1;*/
        
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
	--execute ''||'grant select, insert, update, delete on all tables in schema '||client_db_name||' to wafdbdev'||'';
	--execute ''||'grant select, insert, update, delete on all tables in schema '||client_db_name||' to wafwebdev'||'';
    execute ''||'grant execute on all functions in schema '||client_db_name||' to wafagent'||'';
	--execute ''||'grant execute on all functions in schema '||client_db_name||' to wafdbdev'||'';
	--execute ''||'grant execute on all functions in schema '||client_db_name||' to wafwebdev'||'';
    execute ''||'grant select, update on all sequences in schema '||client_db_name||' to wafagent'||'';
	--execute ''||'grant select, update on all sequences in schema '||client_db_name||' to wafdbdev'||'';
	--execute ''||'grant select, update on all sequences in schema '||client_db_name||' to wafwebdev'||'';
	
    
end;

$_$;


--
