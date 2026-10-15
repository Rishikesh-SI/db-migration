-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: lablakr_upd_page_hierarchy(numeric, character varying[], numeric[], numeric[], numeric[], character varying[], character varying[], numeric[], numeric)
-- Type: FUNCTION

-- Name: lablakr_upd_page_hierarchy(numeric, character varying[], numeric[], numeric[], numeric[], character varying[], character varying[], numeric[], numeric); Type: FUNCTION; Schema: lablakr; Owner: -
--

CREATE FUNCTION lablakr.lablakr_upd_page_hierarchy(p_lang_id numeric, p_page_id character varying[], p_level numeric[], p_parent_id numeric[], p_ordering numeric[], p_title character varying[], p_alias character varying[], p_is_published numeric[], p_updated_by numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

  

declare
v_current_timestamp timestamp;
-- b numeric[]:= p_parent_id;
v_page_asset_type_id numeric :=11;
a numeric[] :=p_page_id;
-- c numeric[] :=p_parent_id;
pg_level numeric;
pg_id character varying;
b numeric[] :=p_level;
begin

-- if p_parent_id is null 
-- then 
--  p_parent_id:= null::integer ;
-- end if;

v_current_timestamp:= current_timestamp at time zone 'utc';
-- raise notice '%',p_parent_id;

 select id -- count(1)
  into   pg_id
   from   unnest(p_page_id)id
   limit 1;
   
if pg_id is not null then

          for t in array_lower(a, 1) .. array_upper(a, 1)
            loop
   -- raise notice '%',p_parent_id[t];
            
				update lablakr.lablakr_page
				set ordering=p_ordering[t],
				page_level=p_level[t],
				 parent_id   =p_parent_id[t],
                alias=p_alias[t],
                title=p_title[t],
                is_published=p_is_published[t]
				where page_id=p_page_id[t]::numeric ;
                
      -- raise notice '%',p_parent_id[t];
       
			end loop;
			
else 

-- if p_parent_id is null 
-- then 
-- p_parent_id :: integer

-- end if;
/*
   insert into lablakr.lablakr_page ( page_id, 
                                        alias, 
										title,
										page_level,
										upfront,
										upfront_app,
										upfront_mobile,
										is_wrapper, 
										parent_id,
										visible,
										visible_app,
                                        visible_mobile,
										scheduled_publish,
										scheduled_unpublish,
										ordering,
										title_mobile,
										title_app,
										is_redirect,
										published_version_number,
                                        created_date,
										updated_date,
										created_by,
										updated_by,
										is_active,
										is_deleted,
										is_published,
										page_guid,
										asset_type_id)

			values             
			                          (
									   nextval('lablakr.seq_lablakr_page_id'),
									   unnest(p_alias),
									   unnest(p_title),
									   unnest(p_level),
									   1,
									   0,
									   0,
									   0,
									    unnest(p_parent_id::numeric[])  ,
                                      -- unnest('{null,null}'::numeric[]),  
									   0,
									   0,
									   0,
									   v_current_timestamp,
									   v_current_timestamp,
									   unnest(p_ordering),
									   unnest(p_title),
									   unnest(p_title),
									   0,
									   1,
									   v_current_timestamp,
									   v_current_timestamp,
									   p_updated_by,
									   p_updated_by,
									   1,
									   0,
									   unnest(p_is_published),
									   uuid_generate_v4() ,
									   null
									  )
									  ;
	*/
    
    -- select  count(1)
   -- into   pg_level
    --  from   unnest(p_level)id ;
     
     for t in array_lower(b, 1) .. array_upper(b, 1)
            loop
     insert into lablakr.lablakr_page (         page_id, 
                                        alias, 
										title,
										page_level,
										upfront,
										upfront_app,
										upfront_mobile,
										is_wrapper, 
										parent_id,
										visible,
										visible_app,
                                        visible_mobile,
										scheduled_publish,
										scheduled_unpublish,
										ordering,
										title_mobile,
										title_app,
										is_redirect,
										published_version_number,
                                        created_date,
										updated_date,
										created_by,
										updated_by,
										is_active,
										is_deleted,
										is_published,
										page_guid,
										asset_type_id)

			values             
			                          (
									  nextval('lablakr.seq_lablakr_page_id'),
									  p_alias[t],
									  p_title[t],
									  p_level[t],
									   1,
									   0,
									   0,
									   0,
									   p_parent_id[t] ,
                                      -- unnest('{null,null}'::numeric[]),  
									   0,
									   0,
									   0,
									   v_current_timestamp,
									   v_current_timestamp,
									   p_ordering[t],
									   p_title[t],
									   p_title[t],
									   0,
									   1,
									   v_current_timestamp,
									   v_current_timestamp,
									   p_updated_by,
									   p_updated_by,
									   1,
									   0,
									   p_is_published[t],
									   uuid_generate_v4() ,
									   null
									  )
									  ;
     
     
                 -- insert data into asset_entity_map
                   
                   insert into  lablakr.lablakr_asset_entity_map ( asset_entity_map_id,
                                                            asset_id,
                                                            asset_type_id,
                                                            entity_role_map_id,
                                                            is_linkable,
                                                            is_visible,
                                                            priority,
                                                            created_date,
                                                            updated_date,
                                                            created_by,
                                                            updated_by,
                                                            is_active,
                                                            is_deleted,
                                                            is_published,
                                                            aemap_guid
     
                                                          )
                                          values(
                                                nextval('lablakr.seq_lablakr_asset_entity_map_id'),
                                                currval('lablakr.seq_lablakr_page_id'),
                                                v_page_asset_type_id,
                                                p_lang_id,
                                                0,0,0,
                                                v_current_timestamp,
                                                v_current_timestamp,
                                                p_updated_by,
                                                p_updated_by,
                                                1,0, 1,
                                                uuid_generate_v4()
                
                                               )     ;
     
     
     
           end loop;
           
     
	end if ;
    
    p_result:= 1;
    
    -- exception 
   -- when
   -- others then p_result:= -1;
    
  -- perform lablakr.lablakr_get_page_listing
   -- (p_lang_id,p_page_cursor) 
     -- s;
   
 -- open p_page_cursor for execute' select * from lablakr.lablakr_get_page_listing('||p_lang_id||',''a'') ; 
   --                              fetch all in "a";' ;

end ;

  

 $$;


--
