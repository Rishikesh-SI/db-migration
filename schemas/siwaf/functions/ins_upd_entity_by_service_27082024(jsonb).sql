-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_upd_entity_by_service_27082024(jsonb)
-- Type: FUNCTION

-- Name: _ins_upd_entity_by_service_27082024(jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_upd_entity_by_service_27082024(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$
--do
--$$
declare
/*p_result numeric;
p_json jsonb:='{"Data":[ {
      "EntityName": "Bangladesh Premier League, 2019-20",
      "EntityDisplpayName": "Bangladesh Premier League, 2019-20",
      "TourId": "1288",
      "ObjectSourceID": "3502",
      "Sport": "cricket",
      "EntityTypeName": "Series",
      "CanonicalURL": "/series/bangladesh-premier-league-2019-20-1288",
	  "league_code" :""
    }],
	"Client": "labyho"}';
*/
v_error_check text;
err_msg text;
v_json jsonb ;
v_client_schema text;
--p_result numeric;
v_entity jsonb;
v_entity_json jsonb;

v_EntityName text;
v_EntityDisplpayName text;
v_ObjectSourceID text;
v_Sport text;
v_EntityTypeName text;
v_CanonicalURL text;
v_TourId text;
v_role_id numeric;
v_cnt numeric;
v_entity_master_id numeric;
v_entity_role_map_id numeric;
v_exist_ent_master numeric;
v_league_code text;
v_show_content numeric;
v_show_data numeric;
v_count numeric;
v_row_number numeric;
v_entity_url text;
v_add_info jsonb;
v_EntityDisplayName text;

begin
v_json:=p_json;

select v_json->>'Client',
       v_json->'Data'
 into  v_client_schema,v_entity_json;
  
  --raise notice '% %',v_client_id,v_entity;
 
 if v_client_schema is not null then 
 
 for v_entity in  select * from jsonb_array_elements(v_entity_json) 
 loop
      select  v_entity->>'EntityName',
	  		  v_entity->>'EntityDisplpayName',
			  v_entity->>'EntityDisplayName',  -- for ecn_v1
			  v_entity->>'ObjectSourceID',
			  v_entity->>'Sport',
			  v_entity->>'EntityTypeName',
			  v_entity->>'CanonicalURL'  ,
			  v_entity->>'TourId',
			  v_entity->>'league_code',
			  v_entity->>'ShowContent',
			  v_entity->>'ShowData',
			  v_entity->>'entity_url',
			  v_entity->>'Additional_info'

 	 into 	  v_EntityName ,v_EntityDisplpayName,v_EntityDisplayName,v_ObjectSourceID,v_Sport,v_EntityTypeName,v_CanonicalURL,v_TourId,v_league_code,v_show_content,v_show_data,v_entity_url,v_add_info;
	  
	 
	-- raise notice '% % % % % % % % % % % % %',v_EntityName ,v_EntityDisplpayName,v_EntityDisplayName,v_ObjectSourceID,v_Sport,v_EntityTypeName,v_CanonicalURL,v_TourId,v_league_code,v_show_content,v_show_data,v_entity_url,v_add_info;
	 --select 1/0;
	    begin
	   
	    if v_client_schema='labsaw' then 
		execute 'select entity_role_id 
		from '||v_client_schema||'.'||v_client_schema||'_entity_type a
		join '||v_client_schema||'.'||v_client_schema||'_entity_role b 
		on a.entity_type_id=b.entity_type_id
		join '||v_client_schema||'.'||v_client_schema||'_entity_group c
		on b.entity_group_id=c.entity_group_id
		where lower(entity_type_name)=lower($1) 
		and lower(group_name)=lower($2) limit 1'
		into strict  v_role_id
		using v_EntityTypeName,v_Sport;
		
		else 
		
		execute 'select entity_role_id 
		from '||v_client_schema||'.'||v_client_schema||'_entity_type a
		join '||v_client_schema||'.'||v_client_schema||'_entity_role b 
		on a.entity_type_id=b.entity_type_id
		where lower(entity_type_name)=lower($1) limit 1'
		into strict  v_role_id
		using v_EntityTypeName;
		
		end if;
				
			if v_client_schema='labecn_v1' then 

				select case when v_ObjectSourceID like '{%' then replace(v_ObjectSourceID,': ',':') 
             	else v_ObjectSourceID end into v_ObjectSourceID;
				
				execute
			    'select entity_role_map_id,entity_master_id ,count(1),row_number() over( Order by entity_role_map_id) 
				from '||v_client_schema||'.'||v_client_schema||'_entity_role_map
			    where source_object_id = $1 and entity_role_id = $2
				group by entity_role_map_id,entity_master_id
				order by 4 desc
				limit 1' 
				into v_entity_role_map_id,v_entity_master_id,v_count,v_row_number
				using v_ObjectSourceID,v_role_id;
				
				raise notice '% ,%', v_row_number,v_ObjectSourceID;
				
			else
			
			    execute
			    'select entity_role_map_id,entity_master_id ,count(1),row_number() over( Order by entity_role_map_id) 
				from '||v_client_schema||'.'||v_client_schema||'_entity_role_map
			    where source_object_id ~ right($1,6) and entity_role_id = $2
				group by entity_role_map_id,entity_master_id
				order by 4 desc
				limit 1' 
				into v_entity_role_map_id,v_entity_master_id,v_count,v_row_number
				using v_ObjectSourceID,v_role_id;
				
				raise notice '% ,%', v_row_number,v_ObjectSourceID;
			
			end if;
				
				if v_row_number > 1 then
				
				/*execute
			    ' delete from '||v_client_schema||'.'||v_client_schema||'_entity_master
				 where entity_master_id in (select entity_master_id from '||v_client_schema||'.'||v_client_schema||'_entity_role_map
			     where source_object_id ~ right($1,6) and entity_role_id = $2 )' 
		         using v_ObjectSourceID,v_role_id;
		       
			   execute
			    ' delete from '||v_client_schema||'.'||v_client_schema||'_entity_role_map
			     where source_object_id ~ right($1,6) and entity_role_id = $2 ' 
		         using v_ObjectSourceID,v_role_id;*/
				 
				end if;
					
		
		
				--- p_result:=3;
		
		      begin
		         execute 'select b.entity_master_id
				 from '||v_client_schema||'.'||v_client_schema||'_entity_role_map a
				 join '||v_client_schema||'.'||v_client_schema||'_entity_master b on a.entity_master_id=b.entity_master_id
		         where entity_role_id=$1 and source_object_id=$2 and b.is_deleted=0 and b.is_active=1 limit 1'
				 into strict v_exist_ent_master
				 using v_role_id,v_ObjectSourceID ;
				 
				 raise notice '%', v_exist_ent_master;
				 
				 if v_client_schema='labsaw' then 
				 
				 execute 'update '||v_client_schema||'.'||v_client_schema||'_entity_master
				          set entity_name=$1,entity_display_name=$2,canonical_url=$3,show_content =$5,show_data =$6
						  where entity_master_id=$4
						 '
				 using 	v_EntityName,v_EntityDisplpayName,v_CanonicalURL,v_exist_ent_master,coalesce(v_show_content,0),coalesce(v_show_data,0);
				--raise notice ' check % %',coalesce(v_show_content,0),coalesce(v_show_data,0);
				-- select 1/0;

				ELSIF v_client_schema='labecn_v1' then 
				
				 execute 'update '||v_client_schema||'.'||v_client_schema||'_entity_master
				          set entity_name=$1,entity_display_name=$2,canonical_url=$3,entity_url=$5,add_info=$6,show_content =$7,show_data =$8
						  where entity_master_id=$4
						  '
				 using 	v_EntityName,v_EntityDisplayName,v_CanonicalURL,v_exist_ent_master,v_entity_url,v_add_info,coalesce(v_show_content,0),coalesce(v_show_data,0);
				
				else
				 
				 execute 'update '||v_client_schema||'.'||v_client_schema||'_entity_master
				          set entity_name=$1,entity_display_name=$2,canonical_url=$3
						  where entity_master_id=$4
						  '
				 using 	v_EntityName,v_EntityDisplpayName,v_CanonicalURL,v_exist_ent_master;

				
				end if;
				
				 execute 'update '||v_client_schema||'.'||v_client_schema||'_entity_role_map
				 		  set source_object_id=$1,tour_id=$2,league_id=$4
						  where entity_master_id=$3'
				 using v_ObjectSourceID,v_TourId::numeric,v_exist_ent_master,v_league_code;
				
				 
		        --raise notice '% %',v_exist_ent_master,v_ObjectSourceID ;
				--p_result:=2;
				
				exception when no_data_found then 			
			    
			if v_count is null or v_count = 0 or v_row_number > 1  then
				    
						
			 execute 'select nextval('''||v_client_schema||'.seq_'||v_client_schema||'_entity_master_id'')'
			 into v_entity_master_id;
			 
			 execute 'select nextval('''||v_client_schema||'.seq_'||v_client_schema||'_entity_role_map_id'')'
			 into v_entity_role_map_id;
			   
			   if v_client_schema = 'labecn_v1' THEN
			    
			   execute 'Insert into '||v_client_schema||'.'||v_client_schema||'_entity_master (entity_master_id,waf_entity_master_id,client_id,entity_name,entity_display_name,canonical_url,priority,created_date,updated_date,created_by,updated_by,is_active,is_deleted,date_info,city,country,known_as,comp_type,waf_series_master_id,waf_tour_master_id,entity_guid,wafc_entity_name,wafc_entity_display_name,show_content,show_data,entity_url,add_info)
               values ($1,0,1,$2,$3,$6,1,$4,$4,1,1,1,0,null,null,null,$3,null,null,null,$5,$3,$3,$7,$8,$9,$10)
			   '
			   using v_entity_master_id,v_EntityName,v_EntityDisplayName,current_timestamp,uuid_generate_v4() ,v_CanonicalURL,coalesce(v_show_content,0),coalesce(v_show_data,0),v_entity_url,v_add_info;
			  
			   else
               
			   execute 'Insert into '||v_client_schema||'.'||v_client_schema||'_entity_master (entity_master_id,waf_entity_master_id,client_id,entity_name,entity_display_name,canonical_url,priority,created_date,updated_date,created_by,updated_by,is_active,is_deleted,date_info,city,country,known_as,comp_type,waf_series_master_id,waf_tour_master_id,entity_guid,wafc_entity_name,wafc_entity_display_name,show_content,show_data)
               values ($1,0,1,$2,$3,$6,1,$4,$4,1,1,1,0,null,null,null,$3,null,null,null,$5,$3,$3,1,1)
			   '
			   using v_entity_master_id,v_EntityName,v_EntityDisplpayName,current_timestamp,uuid_generate_v4() ,v_CanonicalURL,coalesce(v_show_content,0),coalesce(v_show_data,0);

               end if;
			   
               execute 'Insert into '||v_client_schema||'.'||v_client_schema||'_entity_role_map (entity_role_map_id,entity_role_id,entity_master_id,priority,is_active,source_object_id,created_date,updated_date,hyperlink,tour_id,league_id)
               values($1,$2,$3,1,1,$5,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP,0,$4,$6)'
			   using v_entity_role_map_id,v_role_id,v_entity_master_id,v_TourId::numeric,v_ObjectSourceID,v_league_code;
			
			else
				
				execute 'update '||v_client_schema||'.'||v_client_schema||'_entity_role_map
				 		  set source_object_id=$1
						  where entity_role_map_id=$2'
				 using v_ObjectSourceID,v_entity_role_map_id;
				 
				 execute 'update '||v_client_schema||'.'||v_client_schema||'_entity_master
				          set entity_name=$1,entity_display_name=$2,canonical_url=$3
						  where entity_master_id=$4'
				 using 	v_EntityName,v_EntityDisplpayName,v_CanonicalURL,v_entity_master_id;

			
			end if;
			
			
				 -- select * from labyho.labyho_entity_role_map limit 10;
		           
			 -- p_result:=1;
		
		
		       end ;
		
		
		exception when no_data_found then
		     -- p_result := 2 ;
		
      end;
	  
p_result:=1;	  
-- raise notice '% %,%',v_role_id,v_cnt,p_result;
 
 end loop;
 end if ;
 
 

/*exception when others then 
 get stacked diagnostics 
 v_error_check =pg_exception_context;
          err_msg := SQLERRM;
 p_result := -1;
*/	

end;
$_$;


--
