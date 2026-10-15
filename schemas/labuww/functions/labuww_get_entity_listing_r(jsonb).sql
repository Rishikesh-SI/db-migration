-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_get_entity_listing_r(jsonb)
-- Type: FUNCTION

-- Name: labuww_get_entity_listing_r(jsonb); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_get_entity_listing_r(p_json jsonb, OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	 v_pgnum text;
	 v_pgsize text;
	 v_group_id text;
	 v_type_id text;
	 v_torownumber numeric;
	 v_fromrownumber numeric;
	 v_pagination jsonb;
	 v_type_id1 numeric;
	 v_group_id1 numeric;
	 v_exclude_entity character varying;
	 v_entity numeric[];
	 v_search text;
	 v_searchkeyword varchar(4000);
	 v_entitysearchquery varchar(4000) := ' ';
	 is_selected character varying:= 'false';
	 v_sortby varchar(4000);
	 v_type varchar(4000);
begin

select     p_json->>'pgnum',
		   p_json->>'pgsize',
		   p_json->>'groupid',
		   p_json->>'typeid',
		   p_json->>'ext_ent',
		   p_json->>'search',
		   p_json->>'sortby',
		   p_json->>'type'
		   
into       v_pgnum,
		   v_pgsize,
		   v_group_id,
		   v_type_id,
           v_exclude_entity,
		   v_search,
		   v_sortby,
		   v_type;

v_entity:=(SELECT string_to_array(v_exclude_entity,','));

-- raise notice 'v_entity % ',v_entity;

--select * from labuww.l;

          IF ((v_pgnum is null or v_pgnum = '') or (v_pgsize is null or v_pgsize = '') or (v_group_id is null or v_group_id = '') or (v_type_id is null or v_type_id = ''))
			then
	 	  
		  p_assetjson:='{
		 	"message":"Invalid Request"
			 }';
			p_assetcount:=0;
		 
		  else
		
		 
		v_type_id1 := v_type_id::numeric;
		v_group_id1 := v_group_id::numeric;
		v_fromrownumber := (v_pgnum::numeric * v_pgsize::numeric - (v_pgsize::numeric - 1));
		v_torownumber := (v_pgnum::numeric * v_pgsize::numeric);
		
		 if v_search is not null and v_search!='' then
    			-- v_searchkeyword := replace(v_searchkeyword,'''','''''');

          v_searchkeyword:=  regexp_replace(v_search, '([''!$()*+.:<=>?[\\\]^{|}-])', '\\\1', 'g');        

        		 v_searchkeyword:=replace(v_searchkeyword,'''','''''');

                v_searchkeyword:='*'|| replace(''||v_searchkeyword||'',' ',':* & *') ||':*';
				
                v_entitysearchquery := ' and ( to_tsvector(entity_name) @@@ to_tsquery( '''||v_searchkeyword||'''))';
	
				
    	 end if;
		 
		 if v_sortby is null or v_sortby='' then
		 
		     v_sortby:='a.entity_name';
			 
		 end if;
		 
		
	
        execute
		'select ''{ "items": ''|| json_agg(X) ||''}'' from(
		Select false as is_selected,a.entity_master_id,at.asset_type_id,a.entity_name, a.entity_display_name, a.canonical_url,
			a.priority, a.created_date, a.updated_date,a.date_info, a.known_as, a.comp_type,
			a.waf_tour_master_id, a.wafc_entity_name, a.wafc_entity_display_name, a.parent_entity_id,
			a.player_image_path, a.show_content, a.show_data, a.entity_url,b.entity_role_map_id
			,b.entity_role_id,b.source_object_id,b.hyperlink,b.tour_id,c.entity_type_id,
			c.entity_group_id,row_number() over(order by '||v_sortby||') as rn ,a.add_info
		from labuww.labuww_entity_master a
		join labuww.labuww_entity_role_map b on a.entity_master_id=b.entity_master_id
		join labuww.labuww_entity_role c on b.entity_role_id= c.entity_role_id
		inner join labuww.labuww_asset_type at on at.entity_role_id= c.entity_role_id
		where c.entity_type_id = $1 and c.entity_group_id=$2
		and a.is_deleted=0 and a.is_active=1 and b.source_object_id is not null
		and b.entity_role_map_id not in (select entity from unnest($3)entity) '
		||v_entitysearchquery|| '
		 )AS X
		where rn between '||v_fromrownumber||' and '||v_torownumber 
		into p_assetjson 
		using v_type_id1,v_group_id1,v_entity;

		-- raise notice  '%p_assetjson', p_assetjson;	
        execute
		'Select count(1)
		from labuww.labuww_entity_master a
		join labuww.labuww_entity_role_map b on a.entity_master_id=b.entity_master_id
		join labuww.labuww_entity_role c on b.entity_role_id= c.entity_role_id
		where c.entity_type_id= $1 and c.entity_group_id= $2
		and a.is_deleted=0 and a.is_active=1 and b.source_object_id is not null
		'||v_entitysearchquery
		into p_assetcount
		using v_type_id1,v_group_id1;

		--	END if;

		if p_assetjson is null then 
		 p_assetjson:='{"items":null}';
		 --raise notice '%',p_assetcount;
		 --select 1/0;
		 end if;

		 v_pagination:='{"total":'||p_assetcount||',
						 "current_page":'||coalesce(v_pgnum::numeric,0)||'	
						 }';

		  p_assetjson:=jsonb_set(p_assetjson,'{pagination}',v_pagination,true);
  
 
END if;

end;
$_$;


--
