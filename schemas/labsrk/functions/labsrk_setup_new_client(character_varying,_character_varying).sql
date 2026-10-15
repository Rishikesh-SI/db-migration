-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: labsrk_setup_new_client(character varying, character varying)
-- Type: FUNCTION

-- Name: labsrk_setup_new_client(character varying, character varying); Type: FUNCTION; Schema: labsrk; Owner: -
--

CREATE FUNCTION labsrk.labsrk_setup_new_client(source_db_name character varying, client_db_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $_$

declare
	
	v_data_object_cursor_row record;
        v_data_object_script text;
    
begin
	
    create temp table t_data_object_script
    (
        c_data_object_script text
    );
    /*
    insert into t_data_object_script(c_data_object_script)
    select 'create table '||ts||'.'||tn||' ('||cl||', '||case constn when '' then null else 'constraint '||constn||' primary key ('||constcn||')' end||' );' data_object_script
    from
    (
        select ts, tn, string_agg(cn||' '||case dt when 'character varying' then dt||'('||cml||')' else dt end||' '||case inull when 'no' then 'not null' else ' ' end, ', ') cl, constn, constcn
        from
        (
			select c.table_schema ts, c.table_name tn, c.column_name cn, c.ordinal_position cp, c.is_nullable inull, c.data_type dt, c.character_maximum_length cml, c.numeric_precision_radix npr, c.datetime_precision dp, ccu.constraint_name constn, ccu.column_name constcn
			from   information_schema.tables t
			join   information_schema.columns c
			on     c.table_catalog = t.table_catalog
			and    c.table_schema = t.table_schema
			and    c.table_name = t.table_name
        	left join information_schema.constraint_column_usage ccu
        	on     ccu.table_catalog = t.table_catalog
			and    ccu.table_schema = t.table_schema
			and    ccu.table_name = t.table_name
        	where  t.table_schema = source_db_name
			order by c.table_name, c.ordinal_position
		) as tab
    	group by ts, tn, constn, constcn
	) as tab1;
    
    for v_data_object_cursor_row in select c_data_object_script from t_data_object_script where c_data_object_script is not null
    loop
        v_data_object_script := v_data_object_cursor_row.c_data_object_script;
        v_data_object_script := replace(v_data_object_script, source_db_name, client_db_name);
        execute ''||v_data_object_script||'';
    end loop;
    
    delete from t_data_object_script;

    insert into t_data_object_script(c_data_object_script)
    select 'create sequence '||seqs||'.'||seqn||' increment '||i||' start '||sv||' minvalue '||minv||' maxvalue '||maxv||' cache 1;' data_object_script
	from
	(
		select sequence_schema seqs, sequence_name seqn, increment i, start_value sv, minimum_value minv, maximum_value maxv
    	from   information_schema.sequences
    	where  sequence_schema = source_db_name
	) as tab1;
    
    for v_data_object_cursor_row in select c_data_object_script from t_data_object_script where c_data_object_script is not null
    loop
        v_data_object_script := v_data_object_cursor_row.c_data_object_script;
        v_data_object_script := replace(v_data_object_script, source_db_name, client_db_name);
        execute ''||v_data_object_script||'';
    end loop;
    
    delete from t_data_object_script;
  
    insert into t_data_object_script(c_data_object_script)
    select indexdef
    from   pg_indexes
    where  schemaname = source_db_name
    and    indexdef not like '%UNIQUE%'
    order by tablename, indexname;
    
    for v_data_object_cursor_row in select c_data_object_script from t_data_object_script where c_data_object_script is not null
    loop
        v_data_object_script := v_data_object_cursor_row.c_data_object_script;
        v_data_object_script := replace(v_data_object_script, source_db_name, client_db_name);
        execute ''||v_data_object_script||'';
    end loop;
    
    delete from t_data_object_script;
    */
    insert into t_data_object_script(c_data_object_script)
    select 'create or replace function '||sname||'.'||fname||' ('||plist||') returns '||case fdt when 'refcursor' then 'setof '||fdt else fdt end||' language ''plpgsql'' cost 100.0 as $$ '||prosrc||' $$;'
	from
	(
		select sname, fname, string_agg(pmode||' '||pname||' '||pdt, ', ') plist, fdt, string_agg(pdt1, ', ') dlist, prosrc
		from
		(
			select p.specific_schema sname, substring(p.specific_name,1,(length(p.specific_name) - position('_' in reverse(p.specific_name)))) fname,
            	   p.parameter_mode pmode, p.parameter_name pname,
                   case p.data_type when 'ARRAY' then substring(p.udt_name, 2)||'[]' else p.data_type end pdt,
                   r.data_type fdt, pgp.prosrc,
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
	) as tab1;
    
    for v_data_object_cursor_row in select c_data_object_script from t_data_object_script where c_data_object_script is not null
    loop
        v_data_object_script := v_data_object_cursor_row.c_data_object_script;
        v_data_object_script := replace(v_data_object_script, source_db_name, client_db_name);
        execute ''||v_data_object_script||'';
    end loop;
    
    drop table t_data_object_script;
    
    execute ''||'grant select, insert, update, delete on all tables in schema '||client_db_name||' to wafagent'||'';
    execute ''||'grant execute on all functions in schema '||client_db_name||' to wafagent'||'';
    execute ''||'grant select, update on all sequences in schema '||client_db_name||' to wafagent'||'';
    	
end;

$_$;


--
