-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_search_entity_by_page(numeric, numeric, character varying, numeric)
-- Type: FUNCTION

-- Name: labyho_search_entity_by_page(numeric, numeric, character varying, numeric); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_search_entity_by_page(p_pagenumber numeric, p_itemnumber numeric, p_searchkeyword character varying, p_ent_type_id numeric, OUT p_entityjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
declare
	
	v_type_str text := ' ';
	v_fromrownumber numeric;
    v_torownumber numeric;
	v_searchkeyword varchar(4000) := upper(p_searchkeyword);
	v_entitysearchquery varchar(4000) := ' ';
	v_english_lang_master_id numeric;
	v_lang_entity_role_map_id numeric;
	 
begin
	
	if p_ent_type_id is not null then
		v_type_str := ' and et.entity_type_id = $6 ';
	end if;
	
	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
	v_torownumber   := (p_pagenumber * p_itemnumber);
	
	if v_searchkeyword is not null then
		v_searchkeyword := '*'||replace(''||v_searchkeyword||'',' ',':* & *')||':*';
		v_entitysearchquery := ' and to_tsvector(entity_name) @@@ to_tsquery('||'$1'||')';
	end if;
	
	select m.entity_master_id, r.entity_role_map_id
	into v_english_lang_master_id, v_lang_entity_role_map_id
	from labyho.labyho_entity_master m
	join labyho.labyho_entity_role_map r
	on m.entity_master_id = r.entity_master_id
	where entity_name = 'English'
	and m.is_active = '1'
	and m.is_deleted = '0'
	and r.is_active = '1';
	
	execute 'select (''{"entities":''||json_agg(row_to_json(tab))::text||''}'')::jsonb
				from (select em.entity_master_id, em.entity_name, em.entity_display_name, em.canonical_url, em.priority, eg.group_name,
								er.entity_role_map_id, et.entity_type_name, er.source_object_id,
								row_number() over(order by et.search_priority nulls last, em.entity_name) slno
						from labyho.labyho_entity_master em
						join labyho.labyho_entity_role_map er
						on em.entity_master_id = er.entity_master_id
						join labyho.labyho_entity_role ero
						on er.entity_role_id = ero.entity_role_id
						join labyho.labyho_entity_type et
						on ero.entity_type_id = et.entity_type_id
						join labyho.labyho_entity_group eg
						on ero.entity_group_id = eg.entity_group_id
						where 1 = 1 '
						||v_entitysearchquery||
						' and em.is_active = 1
						and em.is_deleted = 0 '
						||v_type_str||
						')  as tab
					where slno between '||'$2'||' and '||'$3'
	into p_entityjson
	using v_searchkeyword, v_fromrownumber, v_torownumber, v_english_lang_master_id, v_lang_entity_role_map_id, p_ent_type_id;
	
end;
$_$;


--
