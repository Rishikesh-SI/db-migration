-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_entity_listing_r(character varying, numeric, numeric, character varying, numeric)
-- Type: FUNCTION

-- Name: _get_entity_listing_r(character varying, numeric, numeric, character varying, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_entity_listing_r(p_schema_prefix character varying, p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_is_active numeric, OUT p_entitycount numeric, OUT p_entityjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare
	 v_fromrownumber numeric;
     v_torownumber numeric;
     v_search_keyword varchar(4000) := upper(p_searchkeyword);
     v_search_query varchar(4000) := ' ';   
begin
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
	 
       if v_search_keyword is not null then

          v_search_query:=' and upper(a.entity_name) like ''%'||upper(v_search_keyword)||'%'' ';
 
      end if;
     
	execute  'select cnt, ''{"items":[''||string_agg(row_to_json(row)::text,'','')||'']}''
              from (
              select  a.entity_master_id,a.entity_name,a.entity_display_name,a.is_active,
              a.canonical_url ,a.updated_date,a.created_date,(d.entity_type_name) as entity_type_name ,d.entity_type_id,c.entity_role_id,
			  e.group_name as entity_group_name ,row_number() over (order by a.updated_date desc ) as rno,
              count(1) over() as cnt,
			  b.source_object_id
              from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master a
              join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map b on a.entity_master_id = b.entity_master_id
              join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role c on b.entity_role_id = c.entity_role_id
              join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_type d on c.entity_type_id = d.entity_type_id
			  join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_group e on c.entity_group_id = e.entity_group_id
              where a.is_deleted=0 and a.is_active=1
              '||v_search_query||' )row
              where rno between  '|| v_fromrownumber||' and '||v_torownumber||'
              group by cnt'    
              into p_entitycount,p_entityjson;
	
end;

 

$$;


--
