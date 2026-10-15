-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_get_author_detail_by_cat_r(numeric[], numeric[], character varying, numeric, numeric, numeric, numeric, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: dhm_get_author_detail_by_cat_r(numeric[], numeric[], character varying, numeric, numeric, numeric, numeric, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_get_author_detail_by_cat_r(p_entity_role_map_id numeric[], p_asset_type_id numeric[], p_search_keyword character varying, p_page_number numeric, p_item_number numeric, p_page_size numeric, p_author_id numeric, p_author_cursor refcursor, p_asset_count refcursor, p_category_cur refcursor, p_listing_asset_count refcursor, p_listing_asset_json refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

declare
    
    v_language_id numeric;
	v_language_name varchar(50);
    v_language_role_map_id numeric;
    v_english_text char(7) := 'english';
    v_listing_asset_count numeric;
    v_listing_asset_json jsonb;
    
begin
	
    select em.entity_master_id, em.entity_name, erm.entity_role_map_id
    into   v_language_id, v_language_name, v_language_role_map_id
    from   dhm.dhm_entity_category ec
    join   dhm.dhm_entity_role_map erm
    on     erm.entity_role_id = ec.entity_role_id
    and    erm.entity_role_map_id in (select language_name from unnest(p_entity_role_map_id) u(language_name))
    join   dhm.dhm_entity_master em
    on     em.entity_master_id = erm.entity_master_id
    where  category_name = 'language';
    
    open p_author_cursor for
    execute 'select u.user_id, u.user_name,
    		 		case '''||v_language_name||''' when '''||v_english_text||''' then u.full_name else ulm.full_name end full_name,
                    case '''||v_language_name||''' when '''||v_english_text||''' then u.display_name else ulm.display_name end display_name,
                    u.profile_picture_url, u.user_guid, count(aa.asset_id) posts_count,
                    case '''||v_language_name||''' when '''||v_english_text||''' then u.bio else ulm.bio end bio
			 from   dhm.dhm_user u
             left join dhm.dhm_user_language_map ulm
             on     (ulm.user_id = u.user_id
             		 and    ulm.language_master_id = '||v_language_id
			 ||') join   dhm.dhm_user_role ur
             on     ur.user_id = u.user_id
             and    ur.role_id = 4
             join   dhm.dhm_author_action aa
             on     (aa.author_id = ur.user_id
             		 and aa.action_id = ur.role_id)
             join   dhm.dhm_asset_list al
             on     (al.asset_id = aa.asset_id
             		 and al.asset_type_id = aa.asset_type_id)
			 and    al.is_published = 1
             and    al.is_trashed = 0
             where  u.user_id = '||p_author_id
             ||' and    u.is_active = 1
             and    u.is_deleted = 0
             and    u.is_published = 1
             and    exists(select 1
             				  from   dhm.dhm_asset_entity_map aem
             				  where  aem.asset_id = al.asset_id
             				  and    aem.asset_type_id = al.asset_type_id
             				  and    aem.entity_role_map_id = '||v_language_role_map_id||')
             group by u.user_id, case '''||v_language_name||''' when '''||v_english_text||''' then u.user_name else ulm.user_name end,
             		  case '''||v_language_name||''' when '''||v_english_text||''' then u.full_name else ulm.full_name end,
                      case '''||v_language_name||''' when '''||v_english_text||''' then u.display_name else ulm.display_name end,
                      u.profile_picture_url, u.user_guid,
                      case '''||v_language_name||''' when '''||v_english_text||''' then u.bio else ulm.bio end';
    
	perform dhm.dhm_get_asset_count_by_cat_rb_r(p_entity_role_map_id, null, null, p_author_id, p_asset_count, p_category_cur);
   	select * from dhm.dhm_get_asset_listing_r(p_page_number, p_item_number, p_page_size, p_entity_role_map_id, null, null, null, p_author_id) s1
    into v_listing_asset_count, v_listing_asset_json;
    open p_listing_asset_count for select v_listing_asset_count;
    open p_listing_asset_json for select v_listing_asset_json;
 
end;

 $$;


--
