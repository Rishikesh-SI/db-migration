-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_setup_new_client(character varying, character varying)
-- Type: FUNCTION

-- Name: khi_setup_new_client(character varying, character varying); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_setup_new_client(source_db_name character varying, client_db_name character varying) RETURNS void
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
    	
        insert into t_data_object_script(c_data_object_script)
    	select 'create table '||ts||'.'||tn||' ('||cl||', '||case conkhi when '' then null else 'constraint '||conkhi||' primary key ('||constcn||')' end||' );' data_object_script
    	from
    	(
        	select ts, tn, string_agg(cn||' '||case dt when 'character varying' then dt||'('||cml||')' else dt end||' '||case inull when 'no' then 'not null' else ' ' end, ', ') cl, conkhi, constcn
        	from
        	(
				select lower(c.table_schema) ts, c.table_name tn, c.column_name cn, c.ordinal_position cp, c.is_nullable inull, c.data_type dt, c.character_maximum_length cml, c.numeric_precision_radix npr, c.datetime_precision dp, ccu.constraint_name conkhi, ccu.column_name constcn
				from   information_schema.tables t
				join   information_schema.columns c
				on     c.table_catalog = t.table_catalog
				and    c.table_schema = t.table_schema
				and    c.table_name = t.table_name
        		left join information_schema.constraint_column_usage ccu
        		on     ccu.table_catalog = t.table_catalog
				and    lower(ccu.table_schema) = lower(t.table_schema)
				and    ccu.table_name = t.table_name
        		where  lower(t.table_schema) = source_db_name
                -- ---------
                and c.table_name not in ('wp_term_relationships')
                --  ----------------- 
				order by c.table_name, c.ordinal_position
			) as tab
    		group by ts, tn, conkhi, constcn
		) as tab1;
    	
    	for v_data_object_cursor_row in select c_data_object_script from t_data_object_script where c_data_object_script is not null
    	loop
        	v_data_object_script := lower(v_data_object_cursor_row.c_data_object_script);
        	v_data_object_script := replace(lower(v_data_object_script), source_db_name, client_db_name);
        	execute ''||v_data_object_script||'';
    	end loop;
    	
    	delete from t_data_object_script;
        
	end;
    
    begin
    	
        insert into t_data_object_script(c_data_object_script)
    	select 'create sequence '||seqs||'.'||seqn||' increment '||i||' start '||sv||' minvalue '||minv||' maxvalue '||maxv||' cache 20;' data_object_script
		from
		(
			select lower(sequence_schema) seqs, sequence_name seqn, increment i, 1 sv, 1 minv, maximum_value maxv
    		from   information_schema.sequences
    		where  lower(sequence_schema) = source_db_name
		) as tab1;
    	
    	for v_data_object_cursor_row in select c_data_object_script from t_data_object_script where c_data_object_script is not null
    	loop
        	v_data_object_script := v_data_object_cursor_row.c_data_object_script;
        	v_data_object_script := replace(v_data_object_script, source_db_name, client_db_name);
        	execute ''||v_data_object_script||'';
    	end loop;
    	
    	delete from t_data_object_script;
        
    end;
    
    begin
    	
        insert into t_data_object_script(c_data_object_script)
    	select indexdef
    	from   pg_indexes
    	where  lower(schemaname) = source_db_name
    	and    indexdef not like '%UNIQUE%'
        -- ---------
          and tablename not in ('wp_term_relationships')
        --  -----------------
    	order by tablename, indexname;
    	
    	for v_data_object_cursor_row in select c_data_object_script from t_data_object_script where c_data_object_script is not null
    	loop
        	v_data_object_script := v_data_object_cursor_row.c_data_object_script;
        	v_data_object_script := replace(v_data_object_script, source_db_name, client_db_name);
        	execute ''||v_data_object_script||'';
    	end loop;
    	
    	delete from t_data_object_script;
        
    end;
   
   /*
    begin
    	
        /*
        insert into t_data_object_script(c_data_object_script)
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
		) as tab1;
        */
      
   
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
        	v_data_object_script := lower(v_data_object_cursor_row.c_data_object_script);
        	v_data_object_script := replace(lower(v_data_object_script), source_db_name, client_db_name);
        	execute ''||v_data_object_script||'';
    	end loop;
        
	end;
  
    drop table t_data_object_script;
   */
   
    execute ''||'grant select, insert, update, delete on all tables in schema '||client_db_name||' to wafagent'||'';
	execute ''||'grant select, insert, update, delete on all tables in schema '||client_db_name||' to wafdbdev'||'';
	execute ''||'grant select, insert, update, delete on all tables in schema '||client_db_name||' to wafwebdev'||'';
    execute ''||'grant execute on all functions in schema '||client_db_name||' to wafagent'||'';
	execute ''||'grant execute on all functions in schema '||client_db_name||' to wafdbdev'||'';
	execute ''||'grant execute on all functions in schema '||client_db_name||' to wafwebdev'||'';
    execute ''||'grant select, update on all sequences in schema '||client_db_name||' to wafagent'||'';
	execute ''||'grant select, update on all sequences in schema '||client_db_name||' to wafdbdev'||'';
	execute ''||'grant select, update on all sequences in schema '||client_db_name||' to wafwebdev'||'';
	
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_role 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_role_id''), role_name, role_display_name, role_desc, '''||
                    v_currenttimestamp||''', '''||v_currenttimestamp||''', 1, 1, 1, 0, 1, uuid_generate_v4() 
					from waf_master.waf_role'||'';
	
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_user 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_user_id''), ''khi'', ''khi'', ''khi'', 0, ''khi@khi.in'', 
                    ''http://khi.in/'', '''||v_currenttimestamp||''', '''||v_currenttimestamp||''', 1, 1, 1, 0, 1, uuid_generate_v4(), 
                    ''45537343653232554145595446476D72326B316655773D3D'', null, null, 0, null, null'||'';

	execute ''||'insert into '||client_db_name||'.'||client_db_name||'_user_role 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_user_role_id''), 
                    currval('''||client_db_name||'.seq_'||client_db_name||'_user_id''), 4, '''||v_currenttimestamp||''', '''||v_currenttimestamp||''', 
                    1, 1, 1, 0, 1, uuid_generate_v4()'||'';
    
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_entity_group 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_entity_group_id''), 0, 1, ''khi'', ''khi'', '''||v_currenttimestamp
                    ||''', '''||v_currenttimestamp||''', 1, 1, 1, 0'||'';
    
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_entity_type 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_entity_type_id''), 0, 1, ''Categories'', ''Categories'', 
                    '''||v_currenttimestamp||''', '''||v_currenttimestamp||''', 1, 1, 1, 0, ''Categories'', 0'||'';
	
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_entity_role 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_entity_role_id''), 
                    currval('''||client_db_name||'.seq_'||client_db_name||'_entity_type_id''), 
                    currval('''||client_db_name||'.seq_'||client_db_name||'_entity_group_id''), '''||v_currenttimestamp||''', '''||v_currenttimestamp
                    ||''', 1, 1, 1, 0'||'';
	
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_entity_category 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_entity_category_id''), 
                    currval('''||client_db_name||'.seq_'||client_db_name||'_entity_role_id''), ''Category Type'', ''Category Type'', 
                    '''||v_currenttimestamp||''', '''||v_currenttimestamp||''', 1, 1, 1, 0, 1, '''||v_currenttimestamp||''', uuid_generate_v4()'||'';
    
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_entity_master 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_entity_master_id''), 0, 1, ''News'', ''News'', ''/News'', 1, 
                    '''||v_currenttimestamp||''', '''||v_currenttimestamp||''', 1, 1, 1, 0, null, null, null, ''News'', null, null, null, 
                    uuid_generate_v4(), ''News'', ''News'''||'';
	
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_entity_role_map 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_entity_role_map_id''), 
                    currval('''||client_db_name||'.seq_'||client_db_name||'_entity_role_id''), 
                    currval('''||client_db_name||'.seq_'||client_db_name||'_entity_master_id''), 1, 1, null, '''||v_currenttimestamp||''', '''||
                    v_currenttimestamp||''', 0'||'';
    
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_entity_master 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_entity_master_id''), 0, 1, ''Photos'', ''Photos'', ''/Photos'', 1, 
                    '''||v_currenttimestamp||''', '''||v_currenttimestamp||''', 1, 1, 1, 0, null, null, null, ''Photos'', null, null, null, 
                    uuid_generate_v4(), ''Photos'', ''Photos'''||'';
	
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_entity_role_map 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_entity_role_map_id''), 
                    currval('''||client_db_name||'.seq_'||client_db_name||'_entity_role_id''), 
                    currval('''||client_db_name||'.seq_'||client_db_name||'_entity_master_id''), 1, 1, null, '''||v_currenttimestamp||''', '''||
                    v_currenttimestamp||''', 0'||'';
    
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_entity_master 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_entity_master_id''), 0, 1, ''Videos'', ''Videos'', ''/Videos'', 1, 
                    '''||v_currenttimestamp||''', '''||v_currenttimestamp||''', 1, 1, 1, 0, null, null, null, ''Videos'', null, null, null, 
                    uuid_generate_v4(), ''Videos'', ''Videos'''||'';
	
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_entity_role_map 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_entity_role_map_id''), 
                    currval('''||client_db_name||'.seq_'||client_db_name||'_entity_role_id''), 
                    currval('''||client_db_name||'.seq_'||client_db_name||'_entity_master_id''), 1, 1, null, '''||v_currenttimestamp||''', '''||
                    v_currenttimestamp||''', 0'||'';
    
	execute ''||'insert into '||client_db_name||'.'||client_db_name||'_entity_type 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_entity_type_id''), 0, 1, ''Language'', ''Language'', 
                    '''||v_currenttimestamp||''', '''||v_currenttimestamp||''', 1, 1, 1, 0, ''Language'', 0'||'';
	
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_entity_role 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_entity_role_id''), 
                    currval('''||client_db_name||'.seq_'||client_db_name||'_entity_type_id''), 
                    currval('''||client_db_name||'.seq_'||client_db_name||'_entity_group_id''), '''||v_currenttimestamp||''', '''||v_currenttimestamp
                    ||''', 1, 1, 1, 0'||'';
	
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_entity_category 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_entity_category_id''), 
                    currval('''||client_db_name||'.seq_'||client_db_name||'_entity_role_id''), ''Language'', ''Language'', 
                    '''||v_currenttimestamp||''', '''||v_currenttimestamp||''', 1, 1, 1, 0, 1, '''||v_currenttimestamp||''', uuid_generate_v4()'||'';
    
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_entity_master 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_entity_master_id''), 0, 1, ''English'', ''English'', null, 1, 
                    '''||v_currenttimestamp||''', '''||v_currenttimestamp||''', 1, 1, 1, 0, null, null, null, ''English'', null, null, null, 
                    uuid_generate_v4(), ''English'', ''English'''||'';
	
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_entity_role_map 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_entity_role_map_id''), 
                    currval('''||client_db_name||'.seq_'||client_db_name||'_entity_role_id''), 
                    currval('''||client_db_name||'.seq_'||client_db_name||'_entity_master_id''), 1, 1, null, '''||v_currenttimestamp||''', '''||
                    v_currenttimestamp||''', 0'||'';
	
end;

$_$;


--
