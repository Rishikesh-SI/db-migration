-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_get_author_listing_by_lang_r(numeric, numeric, numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: abp_get_author_listing_by_lang_r(numeric, numeric, numeric, numeric, refcursor); Type: FUNCTION; Schema: abpp; Owner: -
--

CREATE FUNCTION abpp.abp_get_author_listing_by_lang_r(p_language_id numeric, p_page_number numeric, p_item_number numeric, p_page1_size numeric, p_author_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
    v_language_id numeric;
	v_language_name varchar(50);
    v_from_row_number numeric;
    v_to_row_number numeric;
    v_english_text char(20) := 'English';
    
begin
	
	select em.entity_master_id, em.entity_name
    into   v_language_id, v_language_name
    from   abp.abp_entity_category ec
    join   abp.abp_entity_role_map erm
    on     erm.entity_role_id = ec.entity_role_id
    and    erm.entity_role_map_id = p_language_id
    join   abp.abp_entity_master em
    on     em.entity_master_id = erm.entity_master_id
    where  category_name = 'Language';
    
    if p_page1_size is null then
    	v_from_row_number := p_page_number * (p_item_number - (p_item_number - 1));
        v_to_row_number := p_page_number * p_item_number;
	else
    	if p_page_number = 1 then
        	v_from_row_number := p_page_number * (p_item_number - (p_item_number - 1));
		else
        	v_from_row_number := p_page1_size + (((p_page_number - 1) * p_item_number) - (p_item_number - 1));
		end if;
   		v_to_row_number := p_page1_size + ((p_page_number - 1) * p_item_number);
	end if;
    
    open p_author_cursor for
    execute 'select * from (select row_number() over (order by user_id) slno, user_id, user_name, full_name, display_name, profile_picture_url, user_guid,
					posts_count, bio
             from
             (
    		 	select  au.user_id,  
                 		au.user_name, au.full_name, au.display_name, au.profile_picture_url, au.user_guid, au.bio, 
                 		count(aa.asset_id) posts_count
                 from
                 (
                    /*select u.user_id, 
                             u.user_name, u.full_name, u.display_name, u.profile_picture_url, u.user_guid, u.bio                	
                    from   abp.abp_user u
                    where not exists (select 1 from abp.abp_user_language_map ulm where ulm.user_id = u.user_id)
                    and   u.is_active = 1
                    and   u.is_deleted = 0
                    and   u.is_published = 1
                    and   u.is_show_listing = 1 
                    and  '''||v_language_name||''' = '''||v_english_text||'''

                     union all*/

                     select u.user_id,  
                            ulm.user_name, ulm.full_name, ulm.display_name, u.profile_picture_url, u.user_guid, ulm.bio
                     from   abp.abp_user u
                    inner join abp.abp_user_language_map ulm
                    on     (ulm.user_id = u.user_id
                            and    ulm.language_master_id = '||v_language_id
                    ||')
                    where  u.is_active = 1
                    and    u.is_deleted = 0
                    and    u.is_published = 1
                    and    u.is_show_listing = 1 
                 
                ) au
                join   abp.abp_user_role ur
             	on     ur.user_id = au.user_id
             	and    ur.role_id = 4
                join   abp.abp_author_action aa
                on     (aa.author_id = ur.user_id
                 		and aa.action_id = ur.role_id)
                and    aa.asset_type_id = 1
                join   abp.abp_asset_list al
                on     (al.asset_id = aa.asset_id
                 		and al.asset_type_id = aa.asset_type_id)
				and    al.is_published = 1
                and    al.is_trashed = 0
             	/*where  au.is_active = 1
             	and    au.is_deleted = 0
             	and    au.is_published = 1
                and    au.is_show_listing = 1 */                                					
				group by au.user_id, au.user_name, au.full_name, au.display_name, au.profile_picture_url, au.user_guid, au.bio
             ) tab
			where  user_name is not null
			)tab1
             where slno between '||v_from_row_number||' and '||v_to_row_number||'';
    
end;

$$;


--
