-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_setup_new_client(character varying, character varying)
-- Type: FUNCTION

-- Name: stn_setup_new_client(character varying, character varying); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_setup_new_client(source_db_name character varying, client_db_name character varying) RETURNS void
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
    	select 'create table '||ts||'.'||tn||' ('||cl||', '||case stn when '' then null else 'constraint '||stn||' primary key ('
				||constcn||')' end||' );' data_object_script
    	from
    	(
        	select ts, tn, string_agg(cn||' '||case dt when 'character varying' then dt||'('||cml||')' else dt end||' '
									||case inull when 'no' then 'not null' else ' ' end, ', ') cl, stn, constcn
        	from
        	(
				select c.table_schema ts, c.table_name tn, c.column_name cn, c.ordinal_position cp, c.is_nullable inull, c.data_type dt, 
						c.character_maximum_length cml, c.numeric_precision_radix npr, c.datetime_precision dp, ccu.constraint_name stn, 
						ccu.column_name constcn
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
    		group by ts, tn, stn, constcn
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
    	select 'create sequence '||seqs||'.'||seqn||' increment 1 start 1 minvalue 1 maxvalue 9223372036854775807 cache 1;' data_object_script
		from
		(
			select sequence_schema seqs, sequence_name seqn, increment i, 1 sv, 1 minv, maximum_value maxv
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
        
    end;
    
    begin
    	
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
        
    end;
    
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
	
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_role 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_role_id''), role_name, role_display_name, role_desc, '''||
                    v_currenttimestamp||''', '''||v_currenttimestamp||''', 1, 1, 1, 0, 1, uuid_generate_v4() 
					from waf_master.waf_role'||'';
	
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_user 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_user_id''), ''stn'', ''stn'', ''stn'', 
					0, ''stn@stn.in'', ''http://stn.in/'', '''||v_currenttimestamp||''', '''||v_currenttimestamp||''', 
					1, 1, 1, 0, 1, uuid_generate_v4(), ''45537343653232554145595446476D72326B316655773D3D'', null, null, 0, null, null'||'';

	execute ''||'insert into '||client_db_name||'.'||client_db_name||'_user_role 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_user_role_id''), 
                    currval('''||client_db_name||'.seq_'||client_db_name||'_user_id''), 4, '''||v_currenttimestamp||''', '''||v_currenttimestamp||''', 
                    1, 1, 1, 0, 1, uuid_generate_v4()'||'';
    
    execute ''||'insert into '||client_db_name||'.'||client_db_name||'_entity_group 
    				select nextval('''||client_db_name||'.seq_'||client_db_name||'_entity_group_id''), 0, 1, ''stn'', ''stn'', 
					'''||v_currenttimestamp||''', '''||v_currenttimestamp||''', 1, 1, 1, 0'||'';
    
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

$$;


--
