-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_upd_del_entity_details(character varying, jsonb)
-- Type: FUNCTION

-- Name: _ins_upd_del_entity_details(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_upd_del_entity_details(p_schema_prefix character varying, p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
v_entity_role_id numeric;
v_entity_group_id numeric;
v_entity_type_id numeric;
v_entity_name text;
v_entity_master_id numeric;
v_created_date timestamp without time zone;
v_updated_date timestamp without time zone;
v_entity_guid varchar(256);
v_entity_role_map_id numeric;
v_count numeric;
v_search_query text :=' ';
v_search_keyword text;
v_count1 numeric;
V_entity_display_name text;
v_source_object_id text;
v_queery text;
v_client_id numeric;
v_created_by numeric;
v_updated_by numeric;
v_is_active numeric;
v_is_deleted numeric;
v_canonical_url varchar(300);
v_player_image_path varchar(300);
v_entity_url varchar(300);
v_show_data numeric;
v_show_content numeric;
v_canonical_url_old varchar(300);
-- i record ;
v_json jsonb;
v_entity_role_map_id_1 numeric;
v_count_entity numeric:=0;
v_entity_master_id1 numeric;
v_currenttimestamp timestamp;
v_entity_name_old character varying;
v_check numeric;
v_unq_code character varying;
p_data1 jsonb;
p_data2 jsonb;
p_prefix character varying;
v_entity_code character varying;
v_entity_display_name_old character varying;
v_ref_source_object_id character varying;
v_ref_tag_id numeric;
v_ref_url character varying;
v_show_standings numeric;
v_add_info jsonb;
v_message character varying;
v_is_add_info boolean;
begin

select   p_json->'data'->>'entity_name',
         p_json->'data'->>'entity_master_id', 
         p_json->'data'->>'entity_display_name',
         p_json->'data'->>'source_object_id',
		 p_json->'data'->>'entity_group_id', 
		 p_json->'data'->>'entity_type_id',
		 p_json->'data'->>'client_id', 
		 p_json->'data'->>'created_by', 
		 p_json->'data'->>'updated_by', 
		 p_json->'data'->>'is_active', 
		 p_json->'data'->>'is_deleted',
		 p_json->'data'->>'canonical_url',
		 p_json->'data'->>'player_image_path',
		 p_json->'data'->>'entity_url',
		 p_json->'data'->>'show_data',
		 p_json->'data'->>'show_content',
         p_json->'data'->>'ref_source_object_id',
         p_json->'data'->>'ref_tag_id',
         p_json->'data'->>'ref_url',
         p_json->'data'->>'show_standings',
         p_json->'data'->>'add_info',
		 p_json->'data'->>'is_add_info'
		 
        
         into
         v_entity_name,
         v_entity_master_id,
         V_entity_display_name,
         v_source_object_id,
		 v_entity_group_id,
		 v_entity_type_id,
		 v_client_id,
		 v_created_by,
		 v_updated_by,
		 v_is_active,
		 v_is_deleted,
		 v_canonical_url,
		 v_player_image_path,
		 v_entity_url,
		 v_show_data,
		 v_show_content,
         v_ref_source_object_id,
         v_ref_tag_id,
         v_ref_url,
         v_show_standings,
         v_add_info,
		 v_is_add_info;

    select current_timestamp at time zone 'utc' into v_currenttimestamp;

	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
	log_error_message,log_guid,error_json,created_date,client_name,log_type)
	values ((select nextval('siwaf.seq_siwaf_api_error_log_id')),'_ins_upd_del_entity_details',
	'{"exception":""}',uuid_generate_v4(),p_json,v_currenttimestamp,p_schema_prefix,'db-error');

v_created_date     := current_timestamp;
v_updated_date     := current_timestamp;

  execute 'select entity_role_id from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role 
           where entity_group_id='||v_entity_group_id||' and entity_type_id='||v_entity_type_id||''
  into v_entity_role_id;
  
  --v_queery:='select entity_role_id from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role 
     --      where entity_group_id='||v_entity_group_id||' and entity_type_id='||v_entity_type_id||'';
  
  --raise notice '% gourp ', v_entity_group_id;
  
  --raise notice '% type ', v_entity_type_id;
  
  raise notice '% role ', v_entity_role_id;
  
 -- raise notice '% query ', v_queery;
  
-- raise notice 'v_entity_role_id %',v_entity_role_id;
 
if (p_schema_prefix != 'labkkr') then
  if v_entity_master_id is null or v_entity_master_id=0 then

  execute 'select count(1)
          from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master a
		  join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map b on a.entity_master_id=b.entity_master_id
           where upper(a.entity_name) = '''||upper(v_entity_name)||''' 
		   and a.is_active=1 and a.is_deleted=0
		   and b.entity_role_id=$1'
           into v_count1
		   using v_entity_role_id;
  
raise notice 'v_count1 %',v_count1;

		   execute 'select count(1)
		   from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map  a
		   join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master b
		   on a.entity_master_id=b.entity_master_id
		   where a.entity_role_id = '''||v_entity_role_id||'''
		   and a.source_object_id = '''||coalesce(v_source_object_id,'NA')||'''
		   and a.source_object_id is not null
		   and a.is_active=1'
		   into v_count_entity;

raise notice 'v_count_entity %',v_count_entity;

if (v_count_entity = 0) or (v_source_object_id is null) then

     raise notice '1.entity_url%',v_entity_url;
	 
	  if v_count1 = 0 or v_count1 is null then 
	  
		 execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_entity_master_id'')' into v_entity_master_id;
		 execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_entity_role_map_id'')' into v_entity_role_map_id;
  
		 if(p_schema_prefix <> 'labwis') then
		 
		 	v_canonical_url :=CONCAT(v_canonical_url,'-', v_entity_role_map_id);
		 	v_entity_url :=CONCAT(v_entity_url,'-', v_entity_role_map_id);
			
		else
			if(v_canonical_url = '' or v_canonical_url is null) then
				v_canonical_url = null;
			else 
				v_canonical_url :=CONCAT(v_canonical_url,'-', v_entity_role_map_id);
			end if;
		 end if;
		 v_entity_guid      := uuid_generate_v4();
		 
	     v_check:= 1;
		 
		 raise notice 'v_entity_url %',v_entity_url;
		 raise notice 'innnn ';
		 
		 execute  'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master (entity_master_id,waf_entity_master_id,
											 client_id,entity_name,entity_display_name,
											 canonical_url,priority,created_date,updated_date,created_by,updated_by,is_active,
											 is_deleted,date_info,city,country,known_as,comp_type,waf_series_master_id,
											 waf_tour_master_id,entity_guid,wafc_entity_name,wafc_entity_display_name,player_image_path
											 ,entity_url,show_data,show_content,is_add_info)
			 values ($1,0,$10,$2,$3,$13,1,$4,$5,$11,$12,1,0,null,null,null,$6,null,null,null,$7,$8,$9,$14,$15,$16,$17,$18)'
		 using  v_entity_master_id,v_entity_name,V_entity_display_name,v_created_date,v_updated_date,
				v_entity_name,v_entity_guid,v_entity_name,V_entity_display_name,v_client_id,v_created_by,v_updated_by
				,v_canonical_url,v_player_image_path,v_entity_url,v_show_data,v_show_content,v_is_add_info;

		 execute 'Insert into '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map (entity_role_map_id,entity_role_id,
											 entity_master_id,priority,is_active,source_object_id,created_date,
											 updated_date,hyperlink)
				values($1,$2,$3,1,1,$6,$4,$5,0)'
		 using v_entity_role_map_id,v_entity_role_id,v_entity_master_id,v_created_date,v_updated_date,v_source_object_id;
		 
		 p_result := v_entity_master_id; 
		 
		else
		
		p_result := -2 ;
		
	  end if ;
	  end if;
    else
	
	 		if (v_entity_role_id is not null) and (v_source_object_id is not null) then
	
				   execute 'select b.entity_master_id
				   from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map  a
				   join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master b
				   on a.entity_master_id=b.entity_master_id
				   where a.entity_role_id = '''||v_entity_role_id||'''
				   and a.source_object_id = '''||v_source_object_id||'''
				   and a.is_active=1' 
				   into v_entity_master_id1;

		 	end if;
raise notice 'v_entity_master_id1 %',v_entity_master_id1;
raise notice 'v_entity_master_id %',v_entity_master_id;

		   if (v_entity_master_id1 = v_entity_master_id) or (v_entity_master_id1 is null) then

		  		-- raise notice 'v_entity_name %',v_entity_name;
	
     		    execute 'select canonical_url,entity_name,entity_display_name
         	         from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master a
           		     where entity_master_id = $1 
		             and a.is_active=1 and a.is_deleted=0'
			   into v_canonical_url_old,v_entity_name_old,v_entity_display_name_old
			   using v_entity_master_id;

		if p_schema_prefix in ('labkkr_v1','labtkr','labadkr','labkc_v1','lablakr') then

     		    execute 'select entity_code
         	         from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map a
           		     where entity_master_id = $1'
			   into v_unq_code
			   using v_entity_master_id;
		end if;
		
		raise notice 'v_unq_code %',v_unq_code;
		raise notice 'entity_url%',v_entity_url;

	
	if exists(select 1 from labwis.labwis_entity_master where canonical_url = v_canonical_url and entity_master_id <> v_entity_master_id) and p_schema_prefix = ('labwis') then

	p_result := -1;
	v_message:= 'Canonical Url already exists';
	ELSE
      execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master
               set entity_name= $1,
               entity_display_name = $10,
               updated_date= $3,
			   updated_by=$4,
			   canonical_url=$5,
			   player_image_path=$6,
			   is_active=$7,
			   is_deleted=$8,
			   entity_url=$9,
			   show_data=$11,
			   show_content=$12
               where entity_master_id = $2' 
      using   v_entity_name,v_entity_master_id,v_updated_date,
	          v_updated_by,v_canonical_url,v_player_image_path,
			  v_is_active,v_is_deleted,v_entity_url,V_entity_display_name,v_show_data,v_show_content;
			  
	 p_result := v_entity_master_id; 
			  
	end if;  
	  --if v_source_object_id is not null then 
	  
	  execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map
               set source_object_id=$1,entity_role_id=$2,is_active=$4
			   where entity_master_id=$3' 
      using   v_source_object_id,v_entity_role_id,v_entity_master_id,v_is_active;
--------------------------------------	  
  execute 'select entity_role_map_id from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map 
           where entity_master_id='||v_entity_master_id||' '
  into v_entity_role_map_id;
------------------------------------------------	  
	  	  if (v_is_deleted = 1) and (v_is_active = 0) then
		  	execute	'update '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map
					set is_active=0,is_deleted=1,is_published=0
					where entity_role_map_id in (select entity_role_map_id 
									   			from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map
									   			where entity_master_id=$1)'
			using v_entity_master_id;
	     end if;
	  
	 	else 
	  raise notice 'v_count_entity %',v_count_entity;
	   p_result := 0;
	   p_data:='{}';
 	end if;  
	 ---------------------------------
	  if p_schema_prefix in ('labfih','labgt','labukk','labmcfc_v1','labgmr','labgfg','labgg','labkkr_v1','labadkr','labtkr','labkc_v1','lablakr','labisl_v1','labwpl','labkxip','labdd_v1','labwis','labecn_v1','labgsoc','labgrl') then

		   if v_canonical_url <> v_canonical_url_old or v_entity_name <> v_entity_name_old or v_entity_display_name <> v_entity_display_name_old  then
		   
		   		 execute 'select entity_role_map_id
         	         	  from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map a
           		          where entity_master_id = $1'
           into v_entity_role_map_id_1
		   using v_entity_master_id;

		   -- v_json := '{"entity_role_map_id" : "'||coalesce(v_entity_role_map_id_1::varchar,'')||'"}';
		  --  v_json := '{ "entity_role_map_id": "'||coalesce(v_entity_role_map_id_1::text::jsonb,'') ||'"}';
			
			 v_json := '{"entity_role_map_id" : '||v_entity_role_map_id_1::text::json||'}' ;
			 
			raise notice 'v_json %',v_json;
			
		   execute 'select * from '||p_schema_prefix||'.'||p_schema_prefix||'_update_asset_list_json(null,$1)'
		   using v_json;
		   
		   end if ;
		 
	  end if ;
	  
	  --end if;

	

end if;
	--	v_unq_code:= (p_prefix||v_entity_role_map_id)::text;		
		--raise notice 'v_unq_code %',v_unq_code;
		
if p_schema_prefix in ('labkkr_v1','labtkr','labadkr','labkc_v1','lablakr') then

	if v_unq_code is null then
	
		v_unq_code =BTRIM(LOWER(REPLACE(v_entity_name,' ','-')),'-');
	raise notice 'v_unq_code %',v_unq_code;
	  	execute	'update '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map
		set entity_code=$1
		where entity_master_id = $2'
		using v_unq_code,v_entity_master_id;
        
        execute 'select entity_code  
        from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map 
        where entity_master_id=$1 ' into v_entity_code
        using v_entity_master_id;
        
    else 
	
		v_entity_code := v_unq_code;
	
	end if;

end if;

if p_schema_prefix in ('labwis','labecn_v1','labgrl','labgsoc','labgt','labrr',
					   'labeisl', 'labkxip', 'labukk', 'labrstg', 'labpvl', 'labsaw', 
					   'labbr', 'labgmr', 'labmcfc_v1', 'labrg', 'labdv', 'labgg', 'labgfg',
					   'lablsg', 'labpc', 'labpr', 'labfih', 'labdsg', 'labkc_v1', 'labkkr', 'labwpl', 
					   'labupw', 'lablakr', 'labisl_v1', 'labspz_v1', 'labkkr_v1', 'labdd_v1', 'labwf', 
					   'labecn_v1', 'labilt', 'labsm', 'labetpl', 'labwskl') then

execute	'update '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map
		set ref_source_object_id=$2,
        ref_tag_id=$3,
        ref_url=$4
		where entity_master_id = $1'
		using v_entity_master_id,v_ref_source_object_id,v_ref_tag_id,v_ref_url;
      
execute	'update '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master
		set show_standings=$2,
        add_info=$3
		where entity_master_id = $1'
		using v_entity_master_id,v_show_standings,v_add_info;

end if;

		p_data1:= '{
		"data":
		{
			  "entity_name":"'||coalesce(v_entity_name,'')||'",
              "entity_code":"'||coalesce(v_entity_code,'')||'",
			  "entity_master_id":"0",
			  "entity_display_name":"'||coalesce(V_entity_display_name,'')||'",
			  "entity_group_id":"'||coalesce(v_entity_group_id,0)||'",
			  "entity_type_id":"'||coalesce(v_entity_type_id,0)||'",
			  "client_id":"'||coalesce(v_client_id,0)||'",
			  "created_by":"'||coalesce(v_created_by,0)||'",
			  "updated_by":"'||coalesce(v_updated_by,0)||'",
			  "is_active":"'||coalesce(v_is_active,0)||'",
			  "is_deleted":"'||coalesce(v_is_deleted,0)||'",
			  "canonical_url":"'||coalesce(v_canonical_url,'')||'",
			  "unique_code":"'||coalesce(v_unq_code,'')||'",
			  "player_image_path":"'||coalesce(v_player_image_path,'')||'",
			  "entity_url":"'||coalesce(v_entity_url,'')||'",
			  "show_data":"'||coalesce(v_show_data,0)||'",
			  "show_content":"'||coalesce(v_show_content,0)||'",
			  "ref_entity_master_id":"'||coalesce(v_entity_master_id,0)||'",
              "ref_source_object_id":"'||coalesce(v_ref_source_object_id,'')||'",
              "ref_tag_id":"'||coalesce(v_ref_tag_id,0)||'",
              "ref_url":"'||coalesce(v_ref_url,'')||'",
              "show_standings":"'||coalesce(v_show_standings,0)||'",
			  "v_message" : "'||coalesce(v_message,'null')||'",
			  "is_add_info":"'||coalesce(v_is_add_info::boolean, false)||'"

			  }
	}';
    
if p_schema_prefix <> 'labecn_v1' then

 p_data1:=jsonb_set(p_data1,'{data,source_object_id}',coalesce(to_jsonb(v_source_object_id),'{}'));

end if;

    p_data1:=jsonb_set(p_data1,'{data,add_info}',coalesce(to_jsonb(v_add_info),'{}'));  
    
    p_data:=p_data1;
 
    
    else
    select 1/0;
    
    end if;
--raise notice 'p_data1 %',p_data1;
/*
  if p_schema_prefix in ('labkkr','labtkr','labadkr') then
   raise notice 'reached';
  	select p_output_json from labkc_v1.labkc_v1_sync_entity_data(p_data1) into p_data2;		
  end if;
*/  
--raise notice 'p_data2 %',p_data2;
--p_data:=p_data2;

end;
$_$;


--
