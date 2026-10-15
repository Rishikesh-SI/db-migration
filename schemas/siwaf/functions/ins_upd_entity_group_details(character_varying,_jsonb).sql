-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_upd_entity_group_details(character varying, jsonb)
-- Type: FUNCTION

-- Name: _ins_upd_entity_group_details(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_upd_entity_group_details(p_schema_prefix character varying, p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	 v_entity_group_id numeric;
	 v_waf_entity_group_id numeric;
	 v_client_id numeric;
	 v_group_name text;
	 v_group_desc text;
	 v_created_by numeric;
	 v_updated_by numeric;
	 v_is_active numeric;
	 v_is_deleted numeric;
	 v_is_child numeric;
	 v_count1 numeric;
	 v_created_date timestamp without time zone;
	 v_updated_date timestamp without time zone;
begin
     v_created_date     := current_timestamp;
	 v_updated_date     := current_timestamp;
	 
	 select  p_json->>'entity_group_id',
			 p_json->>'waf_entity_group_id',
			 p_json->>'client_id',
			 p_json->>'group_name',
			 p_json->>'group_desc',
			 p_json->>'created_by',
			 p_json->>'updated_by',
			 p_json->>'is_child',
			 p_json->>'is_active',
			 p_json->>'is_deleted'
			 
	 into    v_entity_group_id,
			 v_waf_entity_group_id,
			 v_client_id,
			 v_group_name,
			 v_group_desc,
			 v_created_by,
			 v_updated_by,
			 v_is_child,
			 v_is_active,
			 v_is_deleted;
		
	 if v_entity_group_id is null or v_entity_group_id=0 then
	 
	      execute 'select count(1)
          from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_group a
           where upper(a.group_name) = '''||upper(v_group_name)||''' 
		   and a.is_active=1 and a.is_deleted=0'
           into v_count1;
		   
				if v_count1 = 0 or v_count1 is null then 
				
				execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_entity_group_id'')'
				into v_entity_group_id
				using p_schema_prefix;
				

				execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_entity_group
				select $1,$2,$3,$4,$5,$6,$7,$8,$9,1,0,$10'
				using v_entity_group_id,v_waf_entity_group_id,
				v_client_id,v_group_name,v_group_desc,
				v_created_date,v_updated_date,v_created_by,v_updated_by,
				v_is_child;
	 
				p_result := v_entity_group_id; 
		 
				else
		
				p_result := -2 ;
		
			end if ;
		   
		   
	 else 
	 
		execute ' update '||p_schema_prefix||'.'||p_schema_prefix||'_entity_group
		          set group_desc= $2,
				      group_name= $3,
					  updated_by=$4,
					  update_date=$5,
					  is_active=$6,
					  is_deleted=$7
				  where entity_group_id=$8'
		using p_schema_prefix,v_group_desc,v_group_name,
		      v_updated_by,v_updated_date,v_is_active,
			  v_is_deleted,v_entity_group_id;
			  
	 p_result:=v_entity_group_id;
	 
	 end if;
	 

	 
	 /*execute 'select row_to_json(row) from (select * from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_group  where entity_group_id='|| v_entity_group_id||') as row;'
	 into p_data;*/
	 
	 
	 
end;

 

$_$;


--
