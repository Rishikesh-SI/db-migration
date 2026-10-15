-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr
-- Object: labtkr_search_entity_by_page(numeric, numeric, character varying, numeric)
-- Type: FUNCTION

-- Name: labtkr_search_entity_by_page(numeric, numeric, character varying, numeric); Type: FUNCTION; Schema: labtkr; Owner: -
--

CREATE FUNCTION labtkr.labtkr_search_entity_by_page(p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_ent_type_id numeric, OUT p_entityjson jsonb) RETURNS jsonb
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
	 v_type_str text :=' ';
begin

if p_ent_type_id is not null then 
--raise notice '%',p_ent_type_id;
--select 1/0;
v_type_str :=' and et.entity_type_id =$6';

end if;
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
      from labtkr.labtkr_entity_master m
      inner join labtkr.labtkr_entity_role_map r 
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
					     	  from   labtkr.labtkr_entity_master em
                              join   labtkr.labtkr_entity_role_map er
                              on em.entity_master_id=er.entity_master_id
                              -- and er.priority=1
                              join   labtkr.labtkr_entity_role ero
                              on er.entity_role_id=ero.entity_role_id
                              join   labtkr.labtkr_entity_type et
                              on ero.entity_type_id=et.entity_type_id
							  join   labtkr.labtkr_entity_group eg
                              on ero.entity_group_id=eg.entity_group_id
							  where  1=1 '
                              ||v_entitysearchquery||
                              'and    em.is_active       = 1
                               and    em.is_deleted      = 0'
							  ||v_type_str||'
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
