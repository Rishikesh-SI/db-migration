-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_search_entity_r(character varying)
-- Type: FUNCTION

-- Name: labyho_search_entity_r(character varying); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_search_entity_r(p_searchkeyword character varying, OUT p_entityjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

	
declare
	
    v_searchkeyword varchar(4000) := upper(p_searchkeyword);
    v_entitysearchquery varchar(4000) := ' ';
    v_yahooplayerquery text := ' ';
    
begin
	
    if v_searchkeyword is not null then     	
    	v_entitysearchquery := ' and upper(entity_display_name) like ''%''||'||'$1'||'||''%'' ';
        if v_searchkeyword like '%-YAHOOPLAYER' then
        	v_searchkeyword := replace(v_searchkeyword,'-YAHOOPLAYER','');
        	v_yahooplayerquery := ' ';
        end if;
	end if;
    
    execute 'select (''{"entities":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::json
    			from(select em.entity_master_id, entity_name, entity_display_name, canonical_url, em.priority, erm.source_object_id
                		from labyho.labyho_entity_master em
                        join labyho.labyho_entity_role_map erm
                        on erm.entity_master_id = em.entity_master_id
                        join labyho.labyho_entity_role er
                        on er.entity_role_id = erm.entity_role_id
                        where erm.is_active = 1 '
                        ||v_entitysearchquery
                        ||v_yahooplayerquery
                        ||')row'
	into p_entityjson
    using v_searchkeyword;
    
    if p_entityjson is null then
    	p_entityjson := '{"entities":[]}'::jsonb;
    end if;
    
end;

$_$;


--
