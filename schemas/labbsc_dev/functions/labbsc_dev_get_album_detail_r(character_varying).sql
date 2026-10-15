-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_get_album_detail_r(character varying)
-- Type: FUNCTION

-- Name: labbsc_dev_get_album_detail_r(character varying); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_get_album_detail_r(p_titlealias character varying, OUT p_result numeric, OUT p_albumjson jsonb, OUT p_imagejson jsonb, OUT p_authorjson jsonb, OUT p_entjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$

 

declare
	
     v_versionnumber numeric;
     v_albumid numeric;
     v_titlealias text := upper(p_titlealias);
     v_asset_type_id numeric := 2;
     v_imagejsonarr jsonb[];
     v_imagejson jsonb;
     v_json text := '{"items":[';
     v_authorjsonarr jsonb[];
     v_authorjson jsonb;
     v_json1 text := '{"authors":[';
     v_author_count numeric;
     v_language_id numeric;
     v_entjsonarr jsonb[];
     v_entjson jsonb;
     v_json2 varchar(30000) := '{"entities":[';
     v_ent_count numeric;
     v_lang_master_id numeric;
     v_modifieddate timestamp;
     v_sysdate timestamp := current_timestamp at time zone 'utc';
     
     
      v_primary_ent_id numeric;
     v_secondary_ent_id numeric;
     p_nextprevjson jsonb;
begin

     select album_id, published_version_number, updated_date
     into   strict v_albumid, v_versionnumber, v_modifieddate
     from   labbsc_dev.labbsc_dev_album
     where  upper(title_alias) = v_titlealias
     and    published_date <= v_sysdate;
     
     select updated_date ,web_detail_jsn
      into v_modifieddate ,p_albumjson
     from labbsc_dev.labbsc_dev_asset_list
     where asset_id = v_albumid
     and asset_type_id = 2
	 and is_published=1
	 and is_trashed=0;
     
          
     p_albumjson := jsonb_set(p_albumjson, '{data,modified_date}', ('"'||v_modifieddate||'"')::text::jsonb, true);
     
  
          select array(
     select row_to_json(row) jsonrow
     from
     ( select 
a.*
from (
		select asset_order as order_number, image_id, image_file_name, image_path ,is_cover, array_to_json(array_agg(em)) entitydata,
         i.image_caption, i.image_desc,
	i.title_alias, aam.is_active,
	aam.is_deleted, i.copyright_text,
	aam.phototypeid,
	(select name from labbsc_dev.labbsc_dev_visual_stories
    where id=aam.phototypeid) as phototypename
     from   labbsc_dev.labbsc_dev_album_asset_map aam
     join   labbsc_dev.labbsc_dev_image i
     on     i.image_id = aam.asset_id
     and    aam.asset_type_id = 3
	left join   labbsc_dev.labbsc_dev_asset_entity_map aem
         on aem.asset_id = i.image_id
         and aem.asset_type_id = 3
	left join  (select 1 as priority, erm.entity_role_map_id, emi.entity_name,emi.entity_master_id
                 from   labbsc_dev.labbsc_dev_entity_master emi
			join   labbsc_dev.labbsc_dev_entity_role_map erm
               on     erm.entity_master_id = emi.entity_master_id
                join  labbsc_dev.labbsc_dev_asset_entity_map aem1
                on    aem1.entity_role_map_id = erm.entity_role_map_id
                 join labbsc_dev.labbsc_dev_album_asset_map aam1
                 on  aam1.asset_id = aem1.asset_id
                 and  aam1.asset_type_id = aem1.asset_type_id
                 and aam1.album_id =  v_albumid
                ) as em
               on         aem.entity_role_map_id = em.entity_role_map_id
	
     where  album_id = v_albumid
         and aam.is_deleted = 0
		 group by asset_order, image_id, image_file_name, image_path ,is_cover, i.image_caption, i.image_desc
         , i.title_alias, aam.is_active, aam.is_deleted, i.copyright_text,aam.phototypeid
         order by order_number
     
              )a
   order by case when is_cover=1 then 0 else 1 end,order_number
             )
             
             as row)
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
     (select u.user_id,
      u.full_name ,
      u.user_name ,
      u.display_name
      from   labbsc_dev.labbsc_dev_user_role as ur
      join   labbsc_dev.labbsc_dev_user as u
      on     u.user_id = ur.user_id
      join   labbsc_dev.labbsc_dev_author_action aa
      on     aa.author_id = u.user_id
      where  u.is_active = 1
      and    u.is_deleted = 0
      and    aa.asset_type_id = 2
      and    aa.action_id = 4
      and    aa.asset_id = v_albumid) as row)
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
     
     select ae.entity_role_map_id 
      into v_language_id
      from labbsc_dev.labbsc_dev_asset_entity_map ae
      join labbsc_dev.labbsc_dev_entity_role_map ar
      on ae.entity_role_map_id=ar.entity_role_map_id
      join labbsc_dev.labbsc_dev_entity_category ec
      on ar.entity_role_id=ec.entity_role_id
      where asset_type_id=v_asset_type_id
      and asset_id=v_albumid
      and ec.category_name='language';
      
      select entity_master_id
      into v_lang_master_id
      from labbsc_dev.labbsc_dev_entity_role_map
      where entity_role_map_id = v_language_id;
      
      select primary_entity_role_map_id,secondary_entity_role_map_id
     into v_primary_ent_id,v_secondary_ent_id
     from labbsc_dev.labbsc_dev_asset_list 
     where asset_type_id=v_asset_type_id
     and asset_id=v_albumid;
     
     ------------- changes done by rakesh bhatkar date:-11062017
     
     

     
       select s.p_assetjson
     from labbsc_dev.labbsc_dev_get_album_related_stories_r(v_albumid,v_asset_type_id,array[v_primary_ent_id,v_secondary_ent_id,v_language_id],6) s
    into p_nextprevjson;
     
     
    p_albumjson:=jsonb_set(p_albumjson,'{nextprev}',p_nextprevjson,true);
   ----------------changes done by rakesh bhatkar date:-11062017
     
     select array(
     select row_to_json(row)
     from(
     select aem.entity_role_map_id, 
         coalesce(elm.entity_display_name,
                  em.entity_display_name)ent_display_name,
         -- labbsc_dev.labbsc_dev_get_entity_display_name_by_language(v_language_id, aem.entity_role_map_id) ent_display_name,
         em.canonical_url
     from labbsc_dev.labbsc_dev_asset_entity_map aem
	join labbsc_dev.labbsc_dev_entity_role_map erm
	on erm.entity_role_map_id = aem.entity_role_map_id
	join labbsc_dev.labbsc_dev_entity_master em
	on em.entity_master_id = erm.entity_master_id
	left join labbsc_dev.labbsc_dev_entity_language_map elm
	on elm.entity_master_id = em.entity_master_id
	and elm.language_master_id = v_lang_master_id
     where aem.asset_id = v_albumid
     and aem.asset_type_id = v_asset_type_id)row)
     into v_entjsonarr;
     
     foreach v_entjson in array v_entjsonarr
     loop
     	v_json2 := v_json2||v_entjson||',';
     end loop;
     
     select count(1)
     into    v_ent_count
     from    unnest(v_entjsonarr) author_id;
     
     if v_ent_count > 0 then
     	v_json2 := substring(v_json2,1,(length(v_json2)-1));
     else
     	v_json2:= substring(v_json2,1,(length(v_json2)));
     end if;
     
     v_json2 := v_json2||']}';
     
     p_entjson := v_json2::jsonb;
     
     p_result := 1;
     
exception
	when others then
    		p_result := -1;
            p_imagejson := '{"items":[]}';
            p_authorjson := '{"authors":[]}';
end;

 

$$;


--
