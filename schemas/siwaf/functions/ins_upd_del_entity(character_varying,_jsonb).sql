-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_upd_del_entity(character varying, jsonb)
-- Type: FUNCTION

-- Name: _ins_upd_del_entity(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_upd_del_entity(p_schema_prefix character varying, p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
declare
v_entity_role_id numeric;
v_entity_name text;
-- p_json jsonb;
v_json jsonb;
v_output_json jsonb;
-- p_schema_prefix character varying;
v_entity_master_id numeric;
v_created_date timestamp without time zone;
v_updated_date timestamp without time zone;
v_entity_guid varchar(256);
v_entity_role_map_id numeric;
v_submit numeric;
v_str text :=' ';
v_count numeric;
v_pagenumber numeric;
v_itemnumber numeric;
v_fromrownumber numeric;
v_torownumber numeric;
--v_is_delete numeric;
v_error_check text;
err_msg text;
v_search_query text :=' ';
v_search_keyword text;
v_result numeric;
v_count1 numeric;
V_entity_display_name text;
v_source_object_id text;
v_count_entity numeric;
v_entity_master_id1 numeric;
v_currenttimestamp timestamp;
begin

/*
p_json := '{
             "data": 
              {
              "role_id": 11,
              "entity_name": "squad page",
              "entity_id": null
              },
             "is_submit": 1,
             "pagenumber":1,
             "itemnumber":10,
             "search_keyword" :"squad page"
            }';
  */
  /*
  p_submit :- 1  insert /update and 2 delete 
  */
  select p_json->'data'->>'role_id',         
         p_json->'data'->>'entity_name',
         p_json->'data'->>'entity_id',
         p_json->'data'->>'is_submit',
         p_json->'data'->>'pagenumber',
         p_json->'data'->>'itemnumber',
         p_json->'data'->>'search_keyword', 
         p_json->'data'->>'entity_display_name',
         p_json->'data'->>'player_id'
         into
         v_entity_role_id,
         v_entity_name,
         v_entity_master_id,
         v_submit,
         v_pagenumber,
         v_itemnumber,
         v_search_keyword,
         V_entity_display_name,
         v_source_object_id;
	   
    select current_timestamp at time zone 'utc' into v_currenttimestamp;

	 insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
	log_error_message,log_guid,error_json,created_date,client_name,log_type)
	values ((select nextval('siwaf.seq_siwaf_api_error_log_id')),'_ins_upd_del_entity',
	'{"exception":""}',uuid_generate_v4(),p_json,v_currenttimestamp,p_schema_prefix,'db-error');
   
v_created_date     := current_timestamp;
v_updated_date     := current_timestamp;

    v_fromrownumber := (v_pagenumber * v_itemnumber - (v_itemnumber - 1));
  	v_torownumber   := (v_pagenumber * v_itemnumber);

if v_entity_role_id is not null then 

    v_str:=' and b.entity_role_id=$1';
    
end if; 

if v_submit = 1 then 


  if v_entity_master_id is null then
  
  execute 'select count(1)
          from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master a 
		  join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map b on a.entity_master_id=b.entity_master_id
           where upper(a.entity_name) = '''||upper(v_entity_name)||''' 
		   and a.is_active=1 and a.is_deleted=0
		   and b.entity_role_id=$1'
           into v_count1
		   using v_entity_role_id;
		   
		   raise notice 'v_count1 %',v_count1;
  -- select 1/0;
 if v_source_object_id is not null then
		   execute 'select count(1)
		   from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map  a
		   join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master b
		   on a.entity_master_id=b.entity_master_id
		   where a.entity_role_id = '''||v_entity_role_id||'''
		   and a.source_object_id = '''||v_source_object_id||'''
		   and a.is_active=1'
		   into v_count_entity;
else

 execute 'select count(1)
		   from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map  a
		   join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master b
		   on a.entity_master_id=b.entity_master_id
		   where a.entity_role_id = '''||v_entity_role_id||'''
		   and a.source_object_id is null
		   and a.is_active=1'
		   into v_count_entity;
		   
		   v_count_entity:=0;
end if;
raise notice ' ans2 v_count_entity %',v_count_entity;

if v_count_entity = 0 or v_count_entity is null then
  raise notice 'ans v_count1 %',v_count1;

	if v_count1 = 0 or v_count1 is null then 
 
     execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_entity_master_id'')' into v_entity_master_id;
     execute 'select nextval('''||p_schema_prefix||'.seq_'||p_schema_prefix||'_entity_role_map_id'')' into v_entity_role_map_id;

     v_entity_guid      := uuid_generate_v4();
   
     execute  'insert into '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master (entity_master_id,waf_entity_master_id,
                                         client_id,entity_name,entity_display_name,
                                         canonical_url,priority,created_date,updated_date,created_by,updated_by,is_active,
                                         is_deleted,date_info,city,country,known_as,comp_type,waf_series_master_id,
                                         waf_tour_master_id,entity_guid,wafc_entity_name,wafc_entity_display_name)
         values ($1,0,1,$2,$3,null,1,$4,$5,1,1,1,0,null,null,null,$6,null,null,null,$7,$8,$9)'
     using  v_entity_master_id,v_entity_name,V_entity_display_name,v_created_date,v_updated_date,
            v_entity_name,v_entity_guid,v_entity_name,v_entity_name;

     execute 'Insert into '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map (entity_role_map_id,entity_role_id,
                                         entity_master_id,priority,is_active,source_object_id,created_date,
                                         updated_date,hyperlink)
            values($1,$2,$3,1,1,$6,$4,$5,0)'
     using v_entity_role_map_id,v_entity_role_id,v_entity_master_id,v_created_date,v_updated_date,v_source_object_id;
     v_result := 1; 
    else
    v_result := -2 ;
  end if ; 
  end if;  
  else
  raise notice 'v_entity_role_id %',v_entity_role_id;
  raise notice 'v_source_object_id %',v_source_object_id;

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

   if (v_entity_master_id1 = v_entity_master_id) or (v_entity_master_id1 is null) then
 
   raise notice 'v_entity_name %',v_entity_name;

 
		  execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master
				   set entity_name= $1,
				   entity_display_name = $1,
				   updated_date= $3
				   where entity_master_id = $2' 
		  using   v_entity_name,v_entity_master_id,v_updated_date;

		  if v_source_object_id is not null then 

		  execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map
				   set source_object_id=$1
				   where entity_master_id=$2' 
		  using   v_source_object_id,v_entity_master_id;

		  end if;

	   v_result := 1;
	   
	else 
	  raise notice 'v_count_entity %',v_count_entity;
	   v_result := 0;
	   p_data:='{}';
 end if;  
end if;

   else if v_submit = 2 then

    execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master
            set is_active = 0,
            is_deleted = 1,
            updated_date= $2
            where entity_master_id = $1' 
        using   v_entity_master_id,v_updated_date;
       v_result := 2 ;
       
    end if;
 end if; 

if v_search_keyword is not null then

 v_search_query:=' and upper(a.entity_name) like ''%'||upper(v_search_keyword)||'%'' ';
 
end if;
        

   execute  'select cnt, ''{"items":[''||string_agg(row_to_json(row)::text,'','')||'']}''
              from (
              select  a.entity_master_id,a.entity_name,a.entity_display_name,
              a.canonical_url ,a.updated_date,d.entity_type_name,d.entity_type_id,c.entity_role_id,
              row_number() over (order by a.updated_date desc ) as rno,
              count(1) over() as cnt,
			  b.source_object_id
              from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master a
              join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map b on a.entity_master_id = b.entity_master_id
              join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role c on b.entity_role_id = c.entity_role_id
              join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_type d on c.entity_type_id = d.entity_type_id
              where a.is_deleted=0 and a.is_active=1
              '||v_str||v_search_query||' )row
              where rno between  '|| v_fromrownumber||' and '||v_torownumber||'
              group by cnt'    
              into v_count,p_data
              using v_entity_role_id;

       p_data:= jsonb_set(p_data,'{Count}',v_count::text::jsonb,true); 
       p_data:= jsonb_set(p_data,'{result}',coalesce(v_result,0)::text::jsonb,true); 
  
 
   --  
   raise notice '%', v_count;
   raise notice '%', v_output_json;
/*   
 exception 
    when others then
	   
		  get stacked diagnostics 
	 	  v_error_check =pg_exception_context;
          err_msg := SQLERRM;
		 --  p_result := -1;
		  p_data := '{"Error_message" :"'||coalesce(err_msg||'-'||v_error_check, '')||'"}';
*/
end;
$_$;


--
