-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_cli_stp_transfer_functions(character varying, character varying, character varying)
-- Type: FUNCTION

-- Name: waf_cli_stp_transfer_functions(character varying, character varying, character varying); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_cli_stp_transfer_functions(source_db_name character varying, client_db_name character varying, p_url_type character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$

 
 declare
 
   v_data_object_cursor_row record;
   v_data_object_script text;
   v_currenttimestamp timestamp := current_timestamp at time zone 'utc';
   v_new_url character varying;
   
 begin
 
  create temp table t_data_object_script
    (
        c_data_object_script text
    );
    
    insert into t_data_object_script(c_data_object_script)
        select pg_get_functiondef(p.oid) as func_def
        from   (select *
                from   pg_proc p
                where  p.prokind <> 'a') p
		join   pg_namespace n
        on     n.oid = p.pronamespace
        where  n.nspname = source_db_name;
    	
    	for v_data_object_cursor_row in select c_data_object_script from t_data_object_script where c_data_object_script is not null
    	loop
        	v_data_object_script := v_data_object_cursor_row.c_data_object_script;
			
			
			
			if  p_url_type is not null  and  v_data_object_script like '% cli_stp_v1.cli_stp_v1_get_page_data_r(p_in_json jsonb, OUT p_out_json jsonb)%' then
				
				p_url_type := replace(p_url_type,'{0}','em1.canonical_url');
				p_url_type := replace(p_url_type,'{1}','em.canonical_url');
				p_url_type := replace(p_url_type,'{3}','v_lang_canonical_url_1');
				p_url_type := replace(p_url_type,'/','||''/''||');
				
				v_new_url := 'select '|| p_url_type ||' into v_new_entity_path';
				
				-- raise notice '%',v_new_url;
			
			    v_data_object_script := replace(v_data_object_script, 'select em.canonical_url into v_new_entity_path',v_new_url);			
			
			end if;
			
        	v_data_object_script := replace(v_data_object_script, source_db_name, client_db_name);
			
			
			
        	execute ''||v_data_object_script||'';
    	end loop;
       drop table t_data_object_script; 
	   
	   
	   
	  
	   
        end ;

$$;


--
