-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_search_entity_by_page(numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: khi_search_entity_by_page(numeric, numeric, character varying); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_search_entity_by_page(p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, OUT p_entityjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

declare
	   v_fromrownumber numeric;
    v_torownumber numeric;
     v_searchkeyword varchar(4000) := upper(p_searchkeyword);
     v_entitysearchquery varchar(4000) := ' ';
     v_entityjsonarr jsonb[];
     v_entityjson jsonb;
     v_json varchar(300000) := '{"entities":[';
     
     V_ENTITY_COUNT NUMERIC:=0;
	 v_english_lang_master_id numeric;
     v_lang_entity_role_map_id numeric;
begin
     v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
     v_torownumber   := (p_pagenumber * p_itemnumber);
     if v_searchkeyword is not null then
     	
       --  v_entitysearchquery := ' and upper(entity_name) like ''%''||'||'$1'||'||''%'' ';
         --      v_entitysearchquery := ' and to_tsvector( entity_name) @@@ to_tsquery( ''*''||'||'$1'||'||'':*'')';
              v_entitysearchquery := ' and to_tsvector( entity_name) @@@ to_tsquery( '||'$1'||')';
              v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
     end if;
     
	 
	  select M.entity_master_id, r.entity_role_map_id
      into v_english_lang_master_id, v_lang_entity_role_map_id
      from khi.khi_entity_master M
      inner join khi.khi_entity_role_map r 
      on (M.entity_master_id = r.entity_master_id)
      where upper(entity_name) = 'ENGLISH'
      and M.is_active = '1' 
      and M.is_deleted = '0'
      and r.is_active = '1' ; 
	  
	 
        --           RAISE NOTICE '%',v_searchkeyword;              
     execute 'select array(select row_to_json(tab)
     				  from   (select em.entity_master_id,
					  em.entity_name, 
					  em.entity_display_name, 
					  em.canonical_url,
					  em.priority,eg.group_name,
						row_number() over(order by et.search_priority nulls last,em.entity_name ) slno,
						
						     (select array_to_json(array_agg(a))
                                        from   ( select 1 srno,
                                                		em1.entity_master_id, em1.entity_name, ''English'' as language_name, 
                                                		$5 lang_entity_role_map_id, em1.entity_display_name, 
                                                        coalesce(em1.wafc_entity_name,em1.entity_name) wafc_entity_name, 
                                                        coalesce(em1.wafc_entity_display_name,em1.entity_name) wafc_entity_display_name
                                                from khi.khi_entity_master em1                                                 
                                                inner join khi.khi_entity_role_map emr
                                                on (em1.entity_master_id = emr.entity_master_id)
                                                where em1.entity_master_id = em.entity_master_id
                                                
                                                union 
                                                
                                        		select (case when elm.language_master_id = $4 then 1 else 2 end) srno ,
                                                        elm.entity_master_id, elm.entity_name, em1.entity_name language_name, 
                                                        emr.entity_role_map_id lang_entity_role_map_id,
                                                        elm.entity_display_name, 
                                                        coalesce(elm.wafc_entity_name,elm.entity_name) wafc_entity_name , 
                                                        coalesce(elm.wafc_entity_display_name,elm.entity_name) wafc_entity_display_name
                                                from khi.khi_entity_language_map elm
                                                inner join khi.khi_entity_master em1 
                                                on (elm.language_master_id = em1.entity_master_id)
                                                inner join khi.khi_entity_role_map emr
                                                on (em1.entity_master_id = emr.entity_master_id)
                                                where elm.entity_master_id = em.entity_master_id
                                                and elm.is_active = 1 
                                                and elm.is_deleted = 0 
                                                and em1.is_active = 1 
                                                and em1.is_deleted = 0
                                                and emr.is_active = 1                                                
                                                order by srno, 2  
                                             )a   
                                        ) entitylanguage_map
										
                           	  from   khi.khi_entity_master em
                              join   khi.khi_entity_role_map er
                              on em.entity_master_id=er.entity_master_id
                              -- and er.priority=1
                              join   khi.khi_entity_role ero
                              on er.entity_role_id=ero.entity_role_id
                              join   khi.khi_entity_type et
                              on ero.entity_type_id=et.entity_type_id
							  join   khi.khi_entity_group eg
                              on ero.entity_group_id=eg.entity_group_id
                                   where  1=1 '
                                   -- entity_master_id in(select entity_master_id
                                   --				  from   khi.khi_entity_role_map
                                   --                           where  entity_role_id in(select entity_role_id
                                    --                          					  from   khi.khi_entity_role
                                   --                                                    where    is_active       = 1
                                   --                                                    and    is_deleted      = 0)
                                  --                            and    is_active       = 1
                                  --                            and    is_deleted      = 0)'
                                   ||v_entitysearchquery||
                                   'and    em.is_active       = 1
                                   and    em.is_deleted      = 0)  as tab
                                   where  slno between '||'$2'||' and '||'$3'||'
                                   )
                                   '
	into   v_entityjsonarr
     using  v_searchkeyword, v_fromrownumber, v_torownumber , v_english_lang_master_id, v_lang_entity_role_map_id;
      RAISE NOTICE '%',v_searchkeyword;        
     foreach v_entityjson in array v_entityjsonarr
     loop
     	v_json := v_json||v_entityjson||',';
     end loop;
     
     	SELECT COUNT(1)
    	INTO    V_ENTITY_COUNT
    	FROM    UNNEST(v_entityjsonarr) entity_master_id;
        
    -- v_json := substring(v_json,1,(length(v_json)-1))||']}';
     IF V_ENTITY_COUNT>0 THEN
     V_JSON:= substring(v_json,1,(length(v_json)-1));
     ELSE 
     V_JSON:= substring(v_json,1,(length(v_json)));
     END IF;
      
      v_json := v_json||']}';
      
     p_entityjson := v_json::jsonb;
     
end;

$_$;


--
