-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_get_author_listing_by_lang_r(numeric, numeric, numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: labbsc_get_author_listing_by_lang_r(numeric, numeric, numeric, numeric, refcursor); Type: FUNCTION; Schema: labbsc; Owner: -
--

CREATE FUNCTION labbsc.labbsc_get_author_listing_by_lang_r(p_language_id numeric, p_page_number numeric, p_item_number numeric, p_page1_size numeric, p_author_cursor refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
 

declare
	
    v_language_id numeric;
	v_language_name varchar(50);
    v_from_row_number numeric;
    v_to_row_number numeric;
    v_english_text char(7) := 'english';
    v_author_count numeric;
begin
	
	select em.entity_master_id, lower(em.entity_name)
    into   v_language_id, v_language_name
    from   labbsc.labbsc_entity_category ec
    join   labbsc.labbsc_entity_role_map erm
    on     erm.entity_role_id = ec.entity_role_id
    and    erm.entity_role_map_id = p_language_id
    join   labbsc.labbsc_entity_master em
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
	
    select count(1)
	from labbsc.labbsc_user u
             join   labbsc.labbsc_user_role ur
             	on     ur.user_id = u.user_id
             	and    ur.role_id = 25
             	where  u.is_active = 1
             	and    u.is_deleted = 0
             	and    u.is_published = 1
				into v_author_count;
	
	
	
    open p_author_cursor for
    execute 'select slno, user_id, user_name, full_name, display_name, profile_picture_url, user_guid, posts_count, bio,
	'|| v_author_count ||' as total_author_count
             from
             (
    		 	select row_number() over (order by u.user_id) slno, u.user_id,
                	   u.user_name,
                 	   case '''||v_language_name||''' when '''||v_english_text||''' then u.full_name else ulm.full_name end full_name,
                 	   case '''||v_language_name||''' when '''||v_english_text||''' then u.display_name else ulm.display_name end display_name,
                 	   u.profile_picture_url, u.user_guid, 0 as posts_count,
                 	   case '''||v_language_name||''' when '''||v_english_text||''' then u.bio else ulm.bio end bio
					 
    		 	from   labbsc.labbsc_user u
                left join labbsc.labbsc_user_language_map ulm
                on     (ulm.user_id = u.user_id
                		and    ulm.language_master_id = '||v_language_id
                ||') join   labbsc.labbsc_user_role ur
             	on     ur.user_id = u.user_id
             	and    ur.role_id = 25
             	where  u.is_active = 1
             	and    u.is_deleted = 0
             	and    u.is_published = 1
                group by u.user_id, case '''||v_language_name||''' when '''||v_english_text||''' then u.user_name else ulm.user_name end,
                 	   	 case '''||v_language_name||''' when '''||v_english_text||''' then u.full_name else ulm.full_name end,
                 	   	 case '''||v_language_name||''' when '''||v_english_text||''' then u.display_name else ulm.display_name end,
                 	   	 u.profile_picture_url, u.user_guid,
                 		 case '''||v_language_name||''' when '''||v_english_text||''' then u.bio else ulm.bio end
             ) tab
             where slno between '||v_from_row_number||' and '||v_to_row_number||'';
    
end;

 
$$;


--
