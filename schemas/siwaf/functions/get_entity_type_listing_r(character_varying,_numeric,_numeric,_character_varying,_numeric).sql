-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_entity_type_listing_r(character varying, numeric, numeric, character varying, numeric)
-- Type: FUNCTION

-- Name: _get_entity_type_listing_r(character varying, numeric, numeric, character varying, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_entity_type_listing_r(p_schema_prefix character varying, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_is_active numeric, OUT p_entitytyoecount numeric, OUT p_entitytypejson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

	 

	declare
		 v_fromrownumber numeric;
		 v_torownumber numeric;
		 v_search_keyword varchar(4000) := upper(p_searchkeyword);
		 v_search_query varchar(4000) := ' ';   
	begin
	p_itemnumber:=50;
		 v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
		 v_torownumber   := (p_pagenumber * p_itemnumber);
		 if v_search_keyword is not null then
			v_search_query:=' and upper(a.entity_type_name) like ''%'||upper(v_search_keyword)||'%'' ';
		 end if;
		 
		 
		 execute  'select cnt, ''{"items":[''||string_agg(row_to_json(row)::text,'','')||'']}''
				  from (
				  select  a.entity_type_id, coalesce(a.waf_entity_type_id,0), a.client_id, a.entity_type_name, a.entity_type_desc, 
                          a.created_date, a.updated_date, a.created_by, a.updated_by, a.is_active, a.is_deleted, 
                          a.entity_type_identifier, coalesce(a.search_priority,0), a.is_child,coalesce(a.entity_url_type,0)as entity_url_type,
				  row_number() over (order by a.updated_date desc ) as rno,
				  (SELECT JSON_AGG(src) FROM(SELECT gp.entity_group_id,gp.group_name,coalesce(r.entity_type_id,0) as entity_type_id,coalesce(r.entity_role_id,0)as entity_role_id
                 ,coalesce(r.is_active,0) as is_active,coalesce(r.is_deleted,1) as is_deleted
			      FROM '||p_schema_prefix||'.'||p_schema_prefix||'_entity_group gp
                  join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role r on gp.entity_group_id=r.entity_group_id
                  and r.entity_type_id=a.entity_type_id and r.is_deleted=0 and r.is_active=1
				  and gp.is_deleted=0 and gp.is_active=1) src) as EntityRoleList,
				  count(1) over() as cnt
				  from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_type a
				  where a.is_deleted=0 and a.is_active=1
				  '||v_search_query||' )row
				  where rno between  '|| v_fromrownumber||' and '||v_torownumber||'
				  group by cnt'    
				  into p_entitytyoecount,p_entitytypejson;
		 
		/*execute 'select count(1) from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_type where  is_active=1 and is_deleted=0' into p_entitytyoecount;
		  execute '(SELECT JSON_AGG(src) FROM (SELECT * FROM '||p_schema_prefix||'.'||p_schema_prefix||'_entity_type where is_active=1 and is_deleted=0 order by   updated_date ) src)' into p_entitytypejson;
		 */
	end;

	 

	
$$;


--
