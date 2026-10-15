-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_get_album_detail_web(numeric, numeric)
-- Type: FUNCTION

-- Name: labiis_get_album_detail_web(numeric, numeric); Type: FUNCTION; Schema: labiis; Owner: -
--

CREATE FUNCTION labiis.labiis_get_album_detail_web(p_albumid numeric, p_versionnumber numeric, OUT p_result numeric, OUT p_albumjson jsonb, OUT p_imagejson jsonb, OUT p_authorjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_versionnumber numeric;
     v_asset_type_id numeric := 2;
     v_imagejsonarr jsonb[];
     v_imagejson jsonb;
     v_json text := '{"items":[';
     v_authorjsonarr jsonb[];
     v_authorjson jsonb;
     v_json1 text := '{"authors":[';
     v_author_count numeric;
     
begin
	
     if p_versionnumber is null then
     	
          /*select      published_version_number
          into strict v_versionnumber
          from   	  labiis.labiis_album
          where  	  album_id = p_albumid;*/
          
          select version_number
          into strict v_versionnumber
          from labiis.labiis_asset_draft ad
          where asset_type_id = 2
          and asset_id = p_albumid
          order by version_number desc
          limit 1;
          
     else
     	
          v_versionnumber := p_versionnumber;
          
     end if;
     
     select 	  asset_data
     into strict p_albumjson
     from   	  labiis.labiis_asset_draft
     where  	  asset_type_id  = v_asset_type_id
     and    	  asset_id       = p_albumid
	and    	  version_number = v_versionnumber;
     
     select array(
     select row_to_json(row) jsonrow
     from
     (
     select order_number, image_id, image_file_name, image_path ,is_cover, em as entitydata, i.image_caption, i.image_desc
     from   labiis.labiis_album_asset_map aam
     join   labiis.labiis_image i
     on     i.image_id = aam.asset_id
     and    aam.asset_type_id = 3
	left join   labiis.labiis_asset_entity_map aem
         on aem.asset_id = i.image_id
         and aem.asset_type_id = 3
	left join  (select 1 as priority, erm.entity_role_map_id, emi.entity_name,emi.entity_master_id
                 from   labiis.labiis_entity_master emi
			join   labiis.labiis_entity_role_map erm
               on     erm.entity_master_id = emi.entity_master_id) as em(priority, entity_role_map_id, entity_name,entity_master_id)
               on         aem.entity_role_map_id = em.entity_role_map_id
     where  album_id = p_albumid
         and aam.is_deleted = 0
         order by order_number) as row)
         into v_imagejsonarr;
     
     foreach v_imagejson in array v_imagejsonarr
     loop
     	v_json := v_json||v_imagejson||',';
     end loop;
     
     v_json := substring(v_json,1,(length(v_json)-1));
     
     v_json := v_json||']}';
     
     p_imagejson := v_json::jsonb;
     
     select array(
     select row_to_json(row) jsonrow
     from
     (select u.user_id, u.user_name
      from   labiis.labiis_user_role as ur
      join   labiis.labiis_user as u
      on     u.user_id = ur.user_id
      join   labiis.labiis_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = 2
      and    aa.action_id = 4
      and    aa.asset_id = p_albumid) as row)
     into v_authorjsonarr;
     
     foreach v_authorjson in array v_authorjsonarr
     loop
     	v_json1 := v_json1||v_authorjson||',';
     end loop;
     
     select count(1)
     	into    v_author_count
     	from    unnest(v_authorjsonarr) author_id;
     	
     	if v_author_count > 0 then
     		v_json1 := substring(v_json1,1,(length(v_json1)-1));
     	else
     		v_json1:= substring(v_json1,1,(length(v_json1)));
     	end if;
     
     v_json1 := v_json1||']}';
     
     p_authorjson := v_json1::jsonb;
     
     p_result := 1;
     
/*exception
	when others then
    		p_result := -1;
            p_imagejson := '{"items":[]}';
            p_authorjson := '{"authors":[]}';*/
end;

 $$;


--
