-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_search_entity_by_page_18052020(numeric, numeric, character varying, numeric)
-- Type: FUNCTION

-- Name: labyho_search_entity_by_page_18052020(numeric, numeric, character varying, numeric); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_search_entity_by_page_18052020(p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_ent_type_id numeric, OUT p_entityjson jsonb) RETURNS jsonb
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
     
     v_entity_count numeric:=0;
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
     
	 
	  select m.entity_master_id, r.entity_role_map_id
      into v_english_lang_master_id, v_lang_entity_role_map_id
      from labyho.labyho_entity_master m
      inner join labyho.labyho_entity_role_map r 
      on (m.entity_master_id = r.entity_master_id)
      where entity_name = 'English'
      and m.is_active = '1' 
      and m.is_deleted = '0'
      and r.is_active = '1' ; 
	  
	 
        --           raise notice '%',v_searchkeyword;              
     execute 'select array(select row_to_json(tab)
     				  from   (select em.entity_master_id,
					  em.entity_name, 
					  em.entity_display_name, 
					  em.canonical_url,
					  em.priority,
					  eg.group_name,
					  er.entity_role_map_id,
					  et.entity_type_name,
						row_number() over(order by et.search_priority nulls last,em.entity_name ) slno
						/*
						
						     (select array_to_json(array_agg(a))
                                        from   ( select 1 srno,
                                                		em1.entity_master_id, em1.entity_name, ''english'' as language_name, 
                                                		$5 lang_entity_role_map_id, em1.entity_display_name, 
                                                        coalesce(em1.wafc_entity_name,em1.entity_name) wafc_entity_name, 
                                                        coalesce(em1.wafc_entity_display_name,em1.entity_name) wafc_entity_display_name
                                                from labyho.labyho_entity_master em1                                                 
                                                inner join labyho.labyho_entity_role_map emr
                                                on (em1.entity_master_id = emr.entity_master_id)
                                                where em1.entity_master_id = em.entity_master_id
                                                
                                                union 
                                                
                                        		select (case when elm.language_master_id = $4 then 1 else 2 end) srno ,
                                                        elm.entity_master_id, elm.entity_name, em1.entity_name language_name, 
                                                        emr.entity_role_map_id lang_entity_role_map_id,
                                                        elm.entity_display_name, 
                                                        coalesce(elm.wafc_entity_name,elm.entity_name) wafc_entity_name , 
                                                        coalesce(elm.wafc_entity_display_name,elm.entity_name) wafc_entity_display_name
                                                from labyho.labyho_entity_language_map elm
                                                inner join labyho.labyho_entity_master em1 
                                                on (elm.language_master_id = em1.entity_master_id)
                                                inner join labyho.labyho_entity_role_map emr
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
										*/
                           	  from   labyho.labyho_entity_master em
                              join   labyho.labyho_entity_role_map er
                              on em.entity_master_id=er.entity_master_id
                              -- and er.priority=1
                              join   labyho.labyho_entity_role ero
                              on er.entity_role_id=ero.entity_role_id
                              join   labyho.labyho_entity_type et
                              on ero.entity_type_id=et.entity_type_id
							  join   labyho.labyho_entity_group eg
                              on ero.entity_group_id=eg.entity_group_id
							  where  1=1 '
                              ||v_entitysearchquery||
                              'and    em.is_active       = 1
                               and    em.is_deleted      = 0
							   and     et.entity_type_id =$6
							   )  as tab
                               where  slno between '||'$2'||' and '||'$3'||'
                               )
                               '
	into   v_entityjsonarr
     using  v_searchkeyword, v_fromrownumber, v_torownumber , v_english_lang_master_id, v_lang_entity_role_map_id,p_ent_type_id;
     -- raise notice '%',v_searchkeyword;        
     foreach v_entityjson in array v_entityjsonarr
     loop
     	v_json := v_json||v_entityjson||',';
     end loop;
     
     	select count(1)
    	into    v_entity_count
    	from    unnest(v_entityjsonarr) entity_master_id;
        
    -- v_json := substring(v_json,1,(length(v_json)-1))||']}';
     if v_entity_count>0 then
     v_json:= substring(v_json,1,(length(v_json)-1));
     else 
     v_json:= substring(v_json,1,(length(v_json)));
     end if;
      
      v_json := v_json||']}';
      
     p_entityjson := v_json::jsonb;
     
end;

 

$_$;


--
