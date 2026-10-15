-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_upd_entity_type_details(character varying, jsonb)
-- Type: FUNCTION

-- Name: _ins_upd_entity_type_details(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_upd_entity_type_details(p_schema_prefix character varying, p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	 v_EntityRoleList jsonb;
	 v_Entity_role_json jsonb;
	 v_entity_type_id numeric;
	 v_entity_group_id numeric;
	 v_entity_role_id numeric;
	 v_client_id numeric;
	 v_waf_entity_type_id numeric;
	 v_entity_type_name varchar(4000);
	 v_entity_type_desc varchar(4000);
	 v_entity_type_identifier varchar(4000);
	 v_is_active numeric;
	 v_is_deleted numeric;
	 v_created_date timestamp without time zone;
	 v_updated_date timestamp without time zone;
	 v_created_by numeric;
	 v_updated_by numeric;
	 v_search_priority numeric;
	 v_is_child numeric;
	 v_role_list jsonb;
	 v_current_timestamp timestamp without time zone;
	 v_entity_role_is_active numeric;
	 v_entity_role_is_deleted numeric;
	 v_count1 numeric;
	 v_entity_url_type numeric;
	 
	  	
begin
   v_current_timestamp := current_timestamp at time zone 'utc';
   
     v_created_date := v_current_timestamp;
     v_updated_date := v_current_timestamp; 
     
	 select  p_json->'EntityRoleList',
			 p_json->'entity_type_id',
			 p_json->'client_id',
			 p_json->'waf_entity_type_id',
			 p_json->>'entity_type_name',
			 p_json->>'entity_type_desc',
			 p_json->'is_active',
			 p_json->'is_deleted',
			 p_json->'created_by',
			 p_json->'updated_by',
			 p_json->>'entity_type_identifier',
			 p_json->'search_priority',
			 p_json->'is_child',
			 p_json->'is_active',
			 p_json->'is_deleted',
			 p_json->'entity_url_type'
	 into    v_EntityRoleList,
			 v_entity_type_id,
			 v_client_id,
			 v_waf_entity_type_id,
			 v_entity_type_name,
			 v_entity_type_desc,
			 v_is_active,
			 v_is_deleted,
			 v_created_by,
			 v_updated_by,
			 v_entity_type_identifier,
			 v_search_priority,
			 v_is_child,
			 v_is_active,
			 v_is_deleted,
			 v_entity_url_type;
		
	 if v_entity_type_id is null or v_entity_type_id=0 then
	 
	 execute 'select count(1)
          from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_type a
           where upper(a.entity_type_name) = '''||upper(v_entity_type_name)||''' 
		   and a.is_active=1 and a.is_deleted=0'
           into v_count1;
		   
           if v_count1 = 0 or v_count1 is null then 
			execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_entity_type_id'')'
				into v_entity_type_id
				using p_schema_prefix;
				

				execute 'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_entity_type
				select $1,$2,$3,$4,$5,$6,$7,$8,$9,1,0,$10,$11,$12,$13'
				using v_entity_type_id,v_waf_entity_type_id,
				v_client_id,v_entity_type_name,v_entity_type_desc,
				v_created_date,v_updated_date,v_created_by,v_updated_by,
				v_entity_type_identifier,v_search_priority,v_is_child,v_entity_url_type;
				
				for v_Entity_role_json in select * from jsonb_array_elements(v_EntityRoleList)	
                loop
					select  v_Entity_role_json->'entity_group_id',
							v_Entity_role_json->'entity_role_id',
							v_Entity_role_json->'is_active',
							v_Entity_role_json->'is_deleted'
					into  	v_entity_group_id,
							v_entity_role_id,
							v_entity_role_is_active,
							v_entity_role_is_deleted;
					
						 if ((v_entity_role_id is null or v_entity_role_id=0) and v_entity_role_is_active=1) then
							        execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_entity_role_id'')'
									into v_entity_role_id
									using p_schema_prefix;
									
									execute 'insert into '||$1||'.'||$1||'_entity_role
									select $2,$3,$4,$5,$6,$7,$8,1,0'
									using p_schema_prefix,v_entity_role_id,v_entity_type_id,v_entity_group_id,
									v_created_date,v_updated_date,v_created_by,v_updated_by;
																		      
					    end if;		   
               end loop;
			   
			   p_result := v_entity_type_id;

            		 
				else
		
				p_result := -2 ;
		
			end if ;			   
	  
	  
	  
	 else 
	 
		execute ' update '||p_schema_prefix||'.'||p_schema_prefix||'_entity_type
		          set entity_type_name= $2,
				      entity_type_desc= $3,
					  updated_date=$4,
					  updated_by=$5,
					  entity_type_identifier=$6,
					  is_active=$8,
					  is_deleted=$9,
					  entity_url_type=$10

				  where entity_type_id=$7'
		using p_schema_prefix,v_entity_type_name,v_entity_type_desc,
		  v_current_timestamp,v_updated_by,v_entity_type_identifier,
		  v_entity_type_id,v_is_active,v_is_deleted,v_entity_url_type;
		  
		  
		  for v_Entity_role_json in select * from jsonb_array_elements(v_EntityRoleList)	
                loop
					select  v_Entity_role_json->'entity_group_id',
							v_Entity_role_json->'entity_role_id',
							v_Entity_role_json->'is_active',
							v_Entity_role_json->'is_deleted'
					into  	v_entity_group_id,
							v_entity_role_id,
							v_entity_role_is_active,
							v_entity_role_is_deleted;
					begin 		
							
				            if v_entity_role_id >0  then			
					
									execute ' update '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role
									set is_active= $2,
									  is_deleted= $3,
									  updated_date=$4,
									  updated_by=$5

									where entity_role_id=$6'
									using p_schema_prefix,v_entity_role_is_active,v_entity_role_is_deleted,
									v_current_timestamp,v_updated_by,v_entity_role_id;
								
							else 
							   if ((v_entity_role_id is null or v_entity_role_id=0) and v_entity_role_is_active=1) then
							        execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_entity_role_id'')'
									into v_entity_role_id
									using p_schema_prefix;
									
									execute 'insert into '||$1||'.'||$1||'_entity_role
									select $2,$3,$4,$5,$6,$7,$8,1,0'
									using p_schema_prefix,v_entity_role_id,v_entity_type_id,v_entity_group_id,
									v_created_date,v_updated_date,v_created_by,v_updated_by;
										
							 
							      
							  end if;
					        end if;
						end;	
               end loop;
			   
			   p_result := v_entity_type_id;
	 
	 
	 end if;
	 

	 
	/*execute 'select waf_entity_type_id,client_id,
	          entity_type_name,entity_type_desc,created_date,updated_date,
			  created_by,updated_by,entity_type_identifier,search_priority,is_child
	          from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_type where entity_type_id='||v_entity_type_id||''	 
	 into    v_waf_entity_type_id,v_client_id,
	          v_entity_type_name,v_entity_type_desc,v_created_date,v_updated_date,
			  v_created_by,v_updated_by,v_entity_type_identifier,v_search_priority,v_is_child;
	 
	 execute 'SELECT JSON_AGG(src) FROM(SELECT gp.entity_group_id,gp.group_name,coalesce(r.entity_type_id,0) as entity_type_id,coalesce(r.entity_role_id,0)as entity_role_id
              ,coalesce(r.is_active,0) as is_active,coalesce(r.is_deleted,1) as is_deleted
			  FROM '||p_schema_prefix||'.'||p_schema_prefix||'_entity_group gp
              left join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role r on gp.entity_group_id=r.entity_group_id
              and r.entity_type_id='||v_entity_type_id||') src'
	 into v_role_list;
	 
	 
	  p_data = '{
	 "entity_type_id":'||coalesce(v_entity_type_id,0)||',
	 "waf_entity_type_id":'|| coalesce(v_waf_entity_type_id,0)||',
	 "client_id":'||coalesce(v_client_id,0)||',
	 "entity_type_name":"'|| coalesce(v_entity_type_name,'')||'",
	 "entity_type_desc":"'||coalesce(v_entity_type_desc,'')||'",
	 "created_date":"'|| coalesce(v_created_date,v_current_timestamp)||'",
	 "updated_date":"'||coalesce(v_updated_date,v_current_timestamp)||'",
	 "created_by":'|| coalesce(v_created_by,0)||',
	 "updated_by":'||coalesce(v_updated_by,0)||',
	 "entity_type_identifier":"'|| coalesce(v_entity_type_identifier,'')||'",
	 "search_priority":'||coalesce(v_search_priority,0)||',
	 "is_child":'|| coalesce(v_is_child,0)||',
	 "EntityRoleList":'||v_role_list ::text||'
	 }' ;  */
	 
	--  p_result:=v_entity_type_id;------------------
	
	

	 
end;

 

$_$;


--
