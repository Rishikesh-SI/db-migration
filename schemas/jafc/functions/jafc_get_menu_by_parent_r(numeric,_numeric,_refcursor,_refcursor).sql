-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_get_menu_by_parent_r(numeric, numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: jafc_get_menu_by_parent_r(numeric, numeric, refcursor, refcursor); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.jafc_get_menu_by_parent_r(p_parent_id numeric, p_language_id numeric, p_page_cur refcursor, p_page_ent_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

    declare
  			v_sysdate timestamp:=current_timestamp at time zone 'utc';
            v_arr_page_id numeric[];
            v_page_asset_type_id numeric:=11;
            v_level_one_par numeric;
            v_lang_filter_query varchar(1000) := ' ';
            v_parent_id numeric;
            v_rno numeric;
    begin
    
    if p_language_id is not null then
		v_lang_filter_query := ' and page_id in(select asset_id
        										from jafc.jafc_asset_entity_map
                                                where asset_type_id = 11
                                                and entity_role_map_id in($1)) ';
    end if;
    
     /*if p_parent_id is null then
     select array(  
     select page_id
     from jafc.jafc_page
     where upfront = 1
     and is_published=1
     and is_deleted=0
     and is_active=1
     and scheduled_publish<=v_sysdate)
     
     into v_arr_page_id;
     
     else
          
          
          select page_id 
          into v_level_one_par
          from 
          (
          with    recursive ancestors as
                  (
                  select page_id, parent_id, 0 as level
                  from    jafc.jafc_page
                  where   page_id = p_parent_id
                  union all
                  select  q.page_id, q.parent_id, m.level+1 as level
                  from     jafc.jafc_page q
                  join    ancestors m
                  on      q.page_id = m.parent_id
                  )
          select  page_id,row_number() over(order by level desc) rno
          from    ancestors
              
              ) pa
          where rno=2;

          select array(
        select page_id 
        from (
                with recursive nodes(page_id,alias,title,parent_id) as 
                (
                select s1.page_id, s1.alias,s1.title, s1.page_id parent_id,s1.page_level
                from jafc.jafc_page s1 where page_id = v_level_one_par
                union 
                select s1.page_id, s1.alias,s1.title, s1.page_id,s1.page_level
                from jafc.jafc_page s1   
                join nodes p on s1.parent_id = p.parent_id 
                and s1.is_published=1
                and s1.is_deleted=0
                and s1.is_active=1
                and s1.scheduled_publish<=v_sysdate
                )
        select * from jafc.jafc_page where page_id in (select page_id from nodes)
            )a
            )
        into v_arr_page_id;   
        
     end if;*/
     
     if p_parent_id is null then
     execute 'select array(  
     select page_id
     from jafc.jafc_page
     where upfront = 1
     and is_published=1
     and is_deleted=0
     and is_active=1
     and scheduled_publish<='''||v_sysdate||''' '
     ||v_lang_filter_query||
     ')'
     into v_arr_page_id
     using p_language_id;
     
     else
          
          select parent_id
          into v_parent_id
          from jafc.jafc_page
          where page_id = p_parent_id;
          
          if v_parent_id is null then
          	v_rno = 1;
          else
          	v_rno = 2;
          end if;
          
          select page_id 
          into v_level_one_par
          from 
          (
          with    recursive ancestors as
                  (
                  select page_id, parent_id, 0 as level
                  from    jafc.jafc_page
                  where   page_id = p_parent_id
                  union all
                  select  q.page_id, q.parent_id, m.level+1 as level
                  from     jafc.jafc_page q
                  join    ancestors m
                  on      q.page_id = m.parent_id
                  )
          select  page_id,row_number() over(order by level desc) rno
          from    ancestors
              
              ) pa
          where rno=v_rno;

          execute'select array(
        select page_id 
        from (
                with recursive nodes(page_id,alias,title,parent_id) as 
                (
                select s1.page_id, s1.alias,s1.title, s1.page_id parent_id,s1.page_level
                from jafc.jafc_page s1 where page_id = '||coalesce(v_level_one_par,-1)||'
                union 
                select s1.page_id, s1.alias,s1.title, s1.page_id,s1.page_level
                from jafc.jafc_page s1   
                join nodes p on s1.parent_id = p.parent_id 
                and s1.is_published=1
                and s1.is_deleted=0
                and s1.is_active=1
                and s1.scheduled_publish<='''||v_sysdate||'''
                )
        select * from jafc.jafc_page where page_id in (select page_id from nodes)'
        ||v_lang_filter_query||
        '
            )a
            )'
        into v_arr_page_id
        using p_language_id;   
        
     end if;
     
     open p_page_cur for  
     select * from jafc.jafc_page
     where  page_id in (select page_id from unnest(v_arr_page_id) page_id) order by ordering;
     
     open p_page_ent_cur for 
     select *,jafc.jafc_get_entity_known_as(entity_role_map_id) known_as  from jafc.jafc_asset_entity_map
     where asset_type_id = v_page_asset_type_id
     and asset_id in (select page_id from unnest(v_arr_page_id) page_id);
     
     
    
      
                                                     
end;
    

$_$;


--
