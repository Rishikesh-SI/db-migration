-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_ins_upd_rating_week(jsonb)
-- Type: FUNCTION

-- Name: hsl_ins_upd_rating_week(jsonb); Type: FUNCTION; Schema: hsl; Owner: -
--

CREATE FUNCTION hsl.hsl_ins_upd_rating_week(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare

	v_json jsonb;
     
	-- variables for hsl_rating_week
	
	v_start_date timestamp;
     v_end_date timestamp;
	v_rating_year numeric;
	v_week_of_year numeric;
	v_week_number numeric;
	v_show_in_web numeric;
	v_show_in_mobile numeric;
	v_show_in_app numeric;
	v_published_version_number numeric :=1;
	v_is_trashed numeric;
	v_created_date timestamp;
	v_updated_date timestamp;
	v_created_by  numeric :=1;
	v_updated_by numeric :=1;
	v_is_active numeric :=1;
	v_is_deleted numeric :=1;
	v_is_published numeric :=1;
	v_published_date timestamp;
	v_asset_guid varchar(256);
	v_language_id numeric;
     v_oldheroratingid numeric;
	
	-- variables for hsl_hero_rating
	
	v_playerdatajson 		  json;
	v_playerdata              json;
	
	v_hero_rating_id       numeric;
	v_entity_role_map_id   numeric;
	v_sport_id             numeric;
	v_role_text            varchar(200);
	v_asset_text           text;
	v_asset_title          varchar(4000);
	v_player_name          varchar(500);
	v_player_display_name  varchar(500);
	v_rating               numeric ;
     v_player_dob      timestamp;
     v_player_pob      varchar(400);
	v_player_skillset1       varchar(4000);
	v_player_skillset2       varchar(4000);
	v_player_skillset3       varchar(4000);
	v_asset_guid1          varchar(256);            
	v_currenttimestamp     timestamp;
	
	-- variables for hsl_hero_rating_asset_map
	
	v_asset_mapjson       json;
	v_assetdata           json;
	
	v_hero_rating_asset_map_id numeric;
	v_asset_order              numeric;
	v_asset_id                 numeric;
	v_asset_type_id	           numeric;
	v_is_cover                 numeric ;
	
	v_rating_asset_type_id    numeric ;
	v_rating_week_id       numeric ;
	v_assetid          	  numeric;
	
	v_entityrolemapid     numeric;
	v_priority 	    	  numeric;
	v_islinkable  		  numeric;
	v_isvisible  		  numeric;
	v_assetentitymapguid  varchar(256);
  	
	v_updatedby        	  numeric;
  	v_entityjson 		  json;
	v_entity 			  json;
  	v_assetentitymapid    numeric;
  	
  	-- variables for seo data insert
  	v_seojson 		  jsonb;
  	v_seodataid     numeric;
  	v_versionnumber    	  numeric := 1;
  	v_seo_guid varchar(256);
  	
  	v_ratingyear numeric;
  	v_weekofyear numeric;
  	v_rate_year_week_of_year varchar(200);
  	v_hero_asset_list_data_exists numeric;
	v_asset_list_id numeric;
     v_assetlistguid varchar(256);
     v_asset_entity_map_id numeric;
     v_asset_entity_map_guid varchar(256);
     v_heroestypeid numeric := 14;
     v_herotitlealias varchar(1000) := ' ';
     v_league_code varchar(256);
     v_league_id varchar(256);
     
begin 
	
 	v_json:=p_json ;
 	v_rating_asset_type_id:=7;
 	v_currenttimestamp := current_timestamp at time zone 'utc'; 
  	
 	select 
     	v_json->'data'->>'rating_year',
       	v_json->'data'->>'week_of_year',
       	v_json->'data'->>'show_in_web',
       	v_json->'data'->>'show_in_mobile',
       	v_json->'data'->>'show_in_app',
       	v_json->'data'->>'status',
       v_json->'data'->>'is_trashed',
       v_json->'data'->>'updated_by',
       v_json->'data'->>'published_date',
       v_json->'data'->>'language_id'
       
       into 
       v_rating_year,
       v_week_of_year,
       v_show_in_web,
       v_show_in_mobile,
       v_show_in_app,
       v_is_published,
       v_is_trashed,
       v_updated_by,
       v_published_date,
       v_language_id
        ;
        
       select to_char(v_rating_year,'9999')||'-'||to_char(v_week_of_year,'9999') into v_rate_year_week_of_year;
       
       select to_date(v_rate_year_week_of_year, 'iyyy-iw') into v_start_date;
       
       select to_date(v_rate_year_week_of_year, 'iyyy-iw')+7 into v_end_date;
       
       select rating_week_id into  v_rating_week_id 
       from hsl.hsl_rating_week 
       where rating_year=v_rating_year
       and week_of_year=v_week_of_year
       and language_id = v_language_id;
      
        
       
       if  v_rating_week_id is not null
       then 
        update hsl.hsl_rating_week
        set show_in_web=v_show_in_web,
            show_in_mobile=v_show_in_mobile,
            show_in_app=v_show_in_app,
            is_trashed=v_is_trashed,
            is_published=v_is_published,
            updated_by=v_updated_by,
            published_date=v_published_date,
            updated_date=v_currenttimestamp
        where rating_year=v_rating_year
        and week_of_year=v_week_of_year
        and rating_week_id=v_rating_week_id
        and language_id = v_language_id;
 
          delete from  hsl.hsl_hero_rating_asset_map
          where hero_rating_id in (select hero_rating_id from  hsl.hsl_hero_rating
          where rating_week_id=v_rating_week_id
                                  and language_id = v_language_id);
          
          delete from hsl.hsl_hero_rating
          where rating_week_id=v_rating_week_id
          and language_id = v_language_id;
          
          delete from hsl.hsl_seo_data
          where asset_id=v_rating_week_id
          and asset_type_id=v_rating_asset_type_id;
          
          delete from hsl.hsl_asset_entity_map
          where asset_id=v_rating_week_id
          and asset_type_id=v_rating_asset_type_id;
  
       else 
       v_rating_week_id := nextval('hsl.seq_hsl_rating_week_id');
       v_week_number := nextval('hsl.seq_hsl_week_number');
       v_asset_guid := uuid_generate_v4();
       insert into hsl.hsl_rating_week
          ( rating_week_id,
            start_date,
            end_date,
            rating_year,
            week_of_year,
            week_number,
            show_in_web,
            show_in_mobile,
            show_in_app,
            published_version_number,
            is_trashed,
            created_date,
            updated_date,
            created_by,
            updated_by,
            is_active,
            is_deleted,
            is_published,
            published_date,
            asset_guid,
           language_id
           )
         values
          (
         v_rating_week_id,
          v_start_date,   
          v_end_date,
          v_rating_year,
          v_week_of_year,
          v_week_number,
          v_show_in_web,
          v_show_in_mobile,
          v_show_in_app,
          1,
          v_is_trashed,
         -- v_published_date,
         v_currenttimestamp,
         v_currenttimestamp,
          1,
          v_updated_by,    
          1,
          1   , 
          v_is_published,
          v_currenttimestamp,
          v_asset_guid,
              v_language_id
          )
          ;
       end if;
       
   select v_json->'data'->>'playerdata'
	into   v_playerdatajson; 
    
   	if v_playerdatajson is not null then 
    
         for v_playerdata in select * from json_array_elements(v_playerdatajson)
          loop
        -- select current_timestamp into v_currenttimestamp;
       	v_hero_rating_id   := nextval('hsl.seq_hsl_hero_rating_id');
        v_asset_guid1       := uuid_generate_v4();
        
       select v_playerdata->>'entity_role_map_id', 
              v_playerdata->>'sport_id',
              v_playerdata->>'asset_text', 
              v_playerdata->>'asset_title',
              v_playerdata->>'player_name',
              v_playerdata->>'player_display_name',
              v_playerdata->>'rating',
              v_playerdata->>'dob',
              v_playerdata->>'pob',
              v_playerdata->>'skill_set_1',
              v_playerdata->>'skill_set_2',
              v_playerdata->>'skill_set_3',
              v_playerdata->>'league_code',
              v_playerdata->>'league_id'
           into 
              v_entity_role_map_id,
              v_sport_id,
              v_asset_text,
              v_asset_title,
              v_player_name,
              v_player_display_name,
              v_rating,
              v_player_dob,
              v_player_pob,
			v_player_skillset1,
			v_player_skillset2,
			v_player_skillset3,
               v_league_code,
               v_league_id;
          
        insert into hsl.hsl_hero_rating
          (
                  hero_rating_id,
			      entity_role_map_id,
			      sport_id,
			      role_text,
			      asset_text,
			      asset_title,
			      player_name,
			      player_display_name,
			      rating,
			      rating_week_id,
			      created_date,
			      updated_date,
			      created_by,
			      updated_by,
			      is_active,
			      is_deleted,
			      asset_guid,
              		language_id,
			skill_set_1,
			skill_set_2,
			skill_set_3,
              player_dob,
              player_pob,
              league_code,
              league_id
          )
        values
        (
        v_hero_rating_id,
        v_entity_role_map_id,
        v_sport_id,
        v_role_text,
        v_asset_text,
        v_asset_title,
        v_player_name,
        v_player_display_name,
        v_rating  ,
        v_rating_week_id,
        v_currenttimestamp,
        v_currenttimestamp  ,
        v_created_by,
        v_updated_by,   
        v_is_active,
        v_is_deleted,
        v_asset_guid,
            v_language_id,
			v_player_skillset1,
			v_player_skillset2,
			v_player_skillset3,
            v_player_dob,
              v_player_pob,
            v_league_code,
            v_league_id
        );
			
        select count(*)
        into   v_hero_asset_list_data_exists
        from   hsl.hsl_asset_list
        where  asset_type_id = v_heroestypeid
        and    primary_entity_role_map_id = v_language_id
        and    secondary_entity_role_map_id = v_entity_role_map_id;
        
        v_herotitlealias := v_entity_role_map_id||'-'||hsl.hsl_get_url(v_player_name);
                
        if v_hero_asset_list_data_exists = 0 then
        	
          v_asset_list_id := nextval ('hsl.seq_hsl_asset_list_id');
		v_assetlistguid := uuid_generate_v4();
          v_asset_entity_map_id := nextval ('hsl.seq_hsl_asset_list_id');
		v_assetentitymapguid := uuid_generate_v4();
          
          insert into hsl.hsl_asset_list(asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id, short_desc, tags, primary_entity_role_map_id,
                                         secondary_entity_role_map_id, total_assets, image_file_name, image_path, duration, show_in_web, show_in_mobile, show_in_app,
                                         published_version_number, is_trashed, created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published,
                                         published_date, asset_guid, show_copyright, order_number)
          values(v_asset_list_id, v_hero_rating_id, v_heroestypeid, v_player_display_name, v_herotitlealias, v_created_by, v_asset_title, hsl.hsl_get_entity_name(v_sport_id),
                 v_language_id, v_entity_role_map_id, v_rating, null, null, null, 1, 1, 1, 1, 0, v_currenttimestamp, v_currenttimestamp, v_created_by, v_updated_by, 1, 0, 1,
                 v_start_date, v_assetlistguid, null, v_sport_id);
          
          insert into hsl.hsl_asset_entity_map(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible, priority, created_date, updated_date,
                                               created_by, updated_by, is_active, is_deleted, is_published, aemap_guid)
          values(v_asset_entity_map_id, v_hero_rating_id, v_heroestypeid, v_language_id, 1, 1, 1, v_currenttimestamp, v_currenttimestamp, v_created_by, v_updated_by, 1, 0, 1,
                 v_asset_entity_map_guid);
          
        else
        	
          select asset_id
          into   v_oldheroratingid
          from   hsl.hsl_asset_list
          where  asset_type_id = v_heroestypeid
        	and    primary_entity_role_map_id = v_language_id
        	and    secondary_entity_role_map_id = v_entity_role_map_id;
          
          update hsl.hsl_asset_list
          set    asset_id = v_hero_rating_id,
          	  asset_title = v_player_display_name,
                 title_alias = v_herotitlealias,
                 total_assets = v_rating,
                 published_date = v_start_date,
                 order_number = v_sport_id
          where  asset_type_id = v_heroestypeid
        	and    primary_entity_role_map_id = v_language_id
        	and    secondary_entity_role_map_id = v_entity_role_map_id;
          
          update hsl.hsl_asset_entity_map
          set    asset_id = v_hero_rating_id,
          	  updated_by = v_updated_by,
                 updated_date = v_currenttimestamp
          where  asset_type_id = v_heroestypeid
        	and    asset_id = v_oldheroratingid;
          
        end if;
        
            --  ===========
            		select v_playerdata->>'asset_map'
                    into   v_asset_mapjson;

                            if v_asset_mapjson is not null then
                               for v_assetdata in select * from json_array_elements(v_asset_mapjson)
                            loop
                                  v_hero_rating_asset_map_id:=nextval('hsl.seq_hsl_hero_rating_asset_map_id');

                          select 
                                 v_assetdata->>'asset_id',
                                 v_assetdata->>'asset_type_id',
                                 v_assetdata->>'is_cover',
                                 v_assetdata->>'asset_order'

                           into 
                                v_asset_id,
                                v_asset_type_id,
                                v_is_cover,
                                v_asset_order
                                ;

                                insert into hsl.hsl_hero_rating_asset_map
                                (
                                    hero_rating_asset_map_id,
                                    hero_rating_id,
                                    asset_order,
                                    asset_id,
                                    asset_type_id,
                                    created_date,
                                    updated_date,
                                    created_by,
                                    updated_by,
                                    is_active,
                                    is_deleted,
                                    is_published,
                                    asset_guid,
                                    is_cover,
                                    language_id
                                )
                             values
                             (  v_hero_rating_asset_map_id,
                                v_hero_rating_id,
                                v_asset_order,
                                v_asset_id,
                                v_asset_type_id,
                                v_currenttimestamp,
                                v_currenttimestamp,
                                v_created_by,
                                v_updated_by,   
                                v_is_active,
                                v_is_deleted,
                                v_is_published,
                                v_asset_guid,
                                v_is_cover,
                              v_language_id
                             );

                          end loop;

                          end if;
            --  ===========
       end loop;
       end if;
       
       -- ======
   select v_json->'data'->>'entitydata'
	into   v_entityjson;
    
	if v_entityjson is not null then
     	
    delete
		from   hsl.hsl_asset_entity_map
		where  asset_type_id = v_rating_asset_type_id
		and    asset_id      = v_rating_week_id ;
         
       
		for v_entity in select * from json_array_elements(v_entityjson)
		loop
          	
               select v_entity->>'entity_role_map_id',
               	      v_entity->>'priority',
                      v_entity->>'is_linkable',
                      v_entity->>'is_visible'
			into   v_entityrolemapid,
                    v_priority,
                      v_islinkable,
                      v_isvisible;
               
               
			if (v_entityrolemapid is not null and v_priority is not null) then
               	
                    v_assetentitymapid   := nextval('hsl.seq_hsl_asset_entity_map_id');
				v_assetentitymapguid := uuid_generate_v4();
                 
				insert into hsl.hsl_asset_entity_map(asset_entity_map_id,
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
                                                         aemap_guid)
				values(v_assetentitymapid,
                           coalesce(v_rating_week_id , v_assetid),
                           v_rating_asset_type_id,
                           v_entityrolemapid,
                           coalesce(v_islinkable,0),
                           v_isvisible,
                           v_priority,
                           v_currenttimestamp,
                           v_currenttimestamp,
                           v_updated_by,
                           v_updated_by,
                           1,
                           0,
                           1,
                           v_assetentitymapguid);
				
                    
				
			end if;
               
		end loop;
          
	end if;
	     
 -- =====
 -- insert seo_data table --
 select v_json->'data'->'seo'
	into   v_seojson;
   
   
   if v_seojson is not null then 
   
   v_seodataid := nextval('hsl.seq_hsl_seo_data_id');
   v_seo_guid := uuid_generate_v4();
   
  insert into hsl.hsl_seo_data
  (
seo_data_id,
asset_id,
asset_type_id,
meta_info,
published_version_number,
created_date,
updated_date,
created_by,
updated_by,
is_active,
is_deleted,
is_published,
seo_data_guid
  )
values
(
v_seodataid,
v_rating_week_id,
v_rating_asset_type_id,
v_seojson,
v_versionnumber,    
v_currenttimestamp,
v_currenttimestamp,
v_created_by,
v_updated_by,   
v_is_active,
v_is_deleted,
v_is_published,
v_seo_guid
)
      ;
      
      end if;
  
  
       
      
      
      
      
      
      p_result := 1;
     
    	if p_result = 1 then
    		
          p_data := v_json;
          
    	end if;  
   
 /*exception
	
    when others then
    		 p_result := -1;*/
	end;

 $$;


--
