-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_client_dbname_setup_new_client(jsonb)
-- Type: FUNCTION

-- Name: waf_client_dbname_setup_new_client(jsonb); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_client_dbname_setup_new_client(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
    source_db_name text:='cli_stp_v1';
    --source_db_name text:='labgt';

client_db_name text;
	v_result text;
	v_data_object_cursor_row record;
    v_data_object_script text;
    v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
    ----------------------
	v_client_name text;
	v_email_id text;
	v_country text;
	v_contactno text;
	v_password text;
	v_sportstype text;
	v_username text;
	----------------------
	v_max_client_id numeric;
	v_update text;
	v_max_tem_comp numeric;
	v_max_tem numeric;
	v_url_type character varying;
	n record;
	/*
	{
  "data": {
    "clientName": "eisl",
    "emailId": null,
    "country": null,
    "contactNo": null,
    "Password": "316871796C6F446B726470554C56617A2F75707872773D3D",
    "user_name": "eisl",
    "sportsType": null
  }
}
	
	*/
	
begin
	
	
	select  p_json->'data'->>'clientName',
	        p_json->'data'->>'emailId',
			p_json->'data'->>'country',
			p_json->'data'->>'contactNo',
			p_json->'data'->>'Password',
			p_json->'data'->>'sportsType',
			p_json->'data'->>'user_name',
			p_json->'data'->>'url_type'
	into    v_client_name,
	        v_email_id,
			v_country,
			v_contactno,
			v_password,
			v_sportstype,
			v_username,
			v_url_type
			;

	client_db_name:='lab'||v_username ;
	
	
	-- v_url_type := coalesce(v_url_type,0);
	
	--raise notice '%',v_url_type;
	
	--select 1/0;

		
     execute ' create schema '||client_db_name||' authorization waf_agent';
  
   --  conclient_dbname:=client_db_name;
 

    create temp table t_data_object_script
    (
        c_data_object_script text
    );
    
    begin
    	
        insert into t_data_object_script(c_data_object_script)
    	select 'create table '||ts||'.'||tn||' ('||cl||''||case when conclient_dbname is null 
		then ' '  else ', constraint '||conclient_dbname||' primary key ('||constcn||')'  
		end||' );' data_object_script
    	from
    	(
        	select ts, 
          tn,
          string_agg(cn||' '||case  
					 when dt='character varying' and cml is null then dt--||'('||cml||')'
					 when dt='character varying' and cml is not null then dt ||'('||cml||')'
					 when dt='ARRAY' then LTRIM(un,'_')||'[]'
					 else dt end||' '||case inull when 'no' then 'not null' else ' ' end, ', ') cl, 
          conclient_dbname, 
          constcn
        	from
        	(
				select 	c.table_schema ts, 
        				c.table_name tn, 
        				c.column_name cn, 
       					c.ordinal_position cp,
        	 	 	 	c.is_nullable inull,
                        c.data_type dt,
                        c.character_maximum_length cml, 
       					c.numeric_precision_radix npr,
        				c.datetime_precision dp,
						c.udt_name un,
        				ccu.constraint_name conclient_dbname, 
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
    		group by ts, tn, conclient_dbname, constcn
		) as tab1;
		
		
		
    	
      
    	for v_data_object_cursor_row in select c_data_object_script from t_data_object_script where c_data_object_script is not null
    	loop
        
        	v_data_object_script := v_data_object_cursor_row.c_data_object_script;
        	v_data_object_script := replace(v_data_object_script, source_db_name, client_db_name);
			--RAISE NOTICE'v_data_object_cursor_row%',v_data_object_script;
        	v_data_object_script := replace(v_data_object_script, 'ARRAY', 'numeric[]');
        	execute ''||v_data_object_script||'';
    	end loop;
		
		
-- 		for n in (select * from waf_master.waf_column_constraint_info)
-- 		loop
		
-- 		if (n.status='UNQ') THEN
-- 		execute 'alter table '||client_db_name||'.'||client_db_name||'_'||n.table_name||' 
--         add CONSTRAINT '||n.constraint_name||'  UNIQUE ('||n.column_name||')';
-- 		end if;
		
-- 		end loop;
    	
    	delete from t_data_object_script;
        
	end;
    
    begin
    	
        insert into t_data_object_script(c_data_object_script)
    	select 'create sequence '||seqs||'.'||seqn||' increment '||i||' start '||sv||' minvalue '||minv||' maxvalue '||maxv||' cache 20;' data_object_script
		from
		(select seqs,
		 seqn,
		 i,
		   sv,
		 minv,
		 maxv
		 from
			(select sequence_schema seqs, sequence_name seqn, increment i, start_value sv, minimum_value minv, maximum_value maxv
			 --nextval(sequence_schema||'.'||sequence_name) as sv, minimum_value minv, maximum_value maxv
    		from   information_schema.sequences
    		where  sequence_schema = source_db_name
		    ) as tab1
			) as tab2;
    	
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
 
   drop table t_data_object_script;  
   
   select   max(client_id)+1
   into v_max_client_id
   from waf_master.waf_client;
 

   
 select * into v_result from waf_master.waf_cli_stp_transfer_functions(source_db_name,client_db_name,v_url_type);
  
 /*execute 'alter table '||client_db_name||'.'||client_db_name||'_container
  add column container_label varchar(40000)';*/

  select * into v_result from 
    waf_master.waf_transfer_data(
	client_db_name,
	v_client_name,
	v_username,
	v_email_id,
	v_password,
	source_db_name
    )
   ;
  begin 
  
  
        execute 'insert into '||client_db_name||'.'||client_db_name||'_template
         select * from '||source_db_name||'.'||source_db_name||'_template';
 
       --v_update:= 'widget_layout_'||v_client_wid_num;
       
       /*execute 'update '||client_db_name||'.'||client_db_name||'_template
	           set template_html=replace(template_html,''widget_layout_35'',$1)'
	   using v_update 		;	*/
        
		execute 'insert into '||client_db_name||'.'||client_db_name||'_template_component_map
         select * from '||source_db_name||'.'||source_db_name||'_template_component_map';	
  
        execute 'select max(template_id) from  '||client_db_name||'.'||client_db_name||'_template '
		         into v_max_tem ;
		
		  execute 'select max(template_component_map_id) from  '||client_db_name||'.'||client_db_name||'_template_component_map'
		         into v_max_tem_comp ;
		execute 'select setval('''||client_db_name||'.seq_'||client_db_name||'_template_id'',2)'
		         using v_max_tem;
		execute 'select setval('''||client_db_name||'.seq_'||client_db_name||'_template_component_map_id'',20)';
		         		
  
  end ;
  
  
-- Insert into waf_master.waf_client ("client_id","client_name","client_display_name","is_master","created_date","updated_date","created_by","updated_by","is_active","is_deleted","client_end_point","client_port_number","client_database_name","client_schema_name","client_prefix","client_guid","client_code","bootstrap_version","client_wid_num")
-- values (v_max_client_id,v_client_name,v_client_name,0,current_timestamp,current_timestamp,1,1,1,0,'siwafint.clmquhxxma0y.us-east-1.rds.amazonaws.com',5432,'siwafmasstg',client_db_name,client_db_name,uuid_generate_v4(),v_username||'01',4,null);

-- Insert into waf_master.waf_user ("user_id","user_name","full_name","display_name","partner_id","email_id","profile_picture_url","created_date","updated_date","created_by","updated_by","is_active","is_deleted","is_published","user_guid","user_pwd","reset_key","key_expiry_date","failed_attempts","unlock_date","bio") 
-- values (v_max_client_id,v_username,v_client_name,v_client_name,'1',null,null,current_timestamp,current_timestamp,1,1,1,0,1,uuid_generate_v4(),v_password,null,null,null,null,null);

-- Insert into waf_master.waf_user_client_map ("user_client_map_id","user_id","client_id","created_date","updated_date","created_by","updated_by","is_active","is_deleted","is_published","published_date","ucmap_guid") 
-- values (v_max_client_id,v_max_client_id,v_max_client_id,current_timestamp,current_timestamp,1,1,1,0,1,current_timestamp,uuid_generate_v4());

 execute 'GRANT USAGE ON SCHEMA '||client_db_name||' to waf_agent';

 execute 'GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA '||client_db_name||' TO waf_agent';
 execute 'GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA '||client_db_name||' TO waf_agent';
 execute 'GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA '||client_db_name||' TO waf_agent'; 
 
  execute 'GRANT USAGE ON SCHEMA '||client_db_name||' to wafwebagent';

 execute 'GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA '||client_db_name||' TO wafwebagent';
 execute 'GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA '||client_db_name||' TO wafwebagent';
 execute 'GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA '||client_db_name||' TO wafwebagent'; 
   
   p_result:=1;
   
   p_data := jsonb_set(p_json, '{data,client_id}', ('"'||v_username||'01'||'"')::text::jsonb, true);
   p_data := jsonb_set(p_data, '{data,client_code}', ('"'||v_max_client_id||'"')::text::jsonb, true);

 --    p_data:=p_json;*
/*exception when others then 
    p_result:=-1;
    p_data :=null;
 */  
end;
$_$;


--
