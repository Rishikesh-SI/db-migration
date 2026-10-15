-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_ins_upd_heros(jsonb)
-- Type: FUNCTION

-- Name: labkkr_v1_ins_upd_heros(jsonb); Type: FUNCTION; Schema: labkkr_v1; Owner: -
--

CREATE FUNCTION labkkr_v1.labkkr_v1_ins_upd_heros(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare

v_json jsonb;
  
-- variables for labkkr_v1_rating_week

v_rating_week_id numeric;
v_start_date timestamp ;
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
-- variables for labkkr_v1_hero_rating

v_playerdatajson 		  json;
v_playerdata              json;

v_hero_rating_id       numeric  ;
v_entity_role_map_id   numeric;
v_sport_id             numeric;
v_role_text            varchar(200);
v_asset_text           text;
v_asset_title          varchar(4000);
v_player_name          varchar(500);
v_player_display_name  varchar(500);
v_rating               numeric ;
v_asset_guid1          varchar(256);            
v_currenttimestamp timestamp;

-- variables for labkkr_v1_hero_rating_asset_map

v_asset_mapjson       json;
v_assetdata           json;

v_hero_rating_asset_map_id numeric;
v_asset_order              numeric;
v_asset_id                 numeric;
v_asset_type_id	           numeric;
v_is_cover                 numeric ;

begin 

 v_json:=p_json ;
 
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
       v_json->'data'->>'v_language_id'
       
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
        
        select current_timestamp into v_currenttimestamp;
       v_rating_week_id := nextval('labkkr_v1.seq_labkkr_v1_rating_week_id');
      v_asset_guid := uuid_generate_v4();
       insert into labkkr_v1.labkkr_v1_rating_week
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
          v_currenttimestamp,   
          v_currenttimestamp,
          v_rating_year,
          v_week_of_year,
          1,
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
       
       
   select v_json->'data'->>'playerdata'
	into   v_playerdatajson; 
    
   	if v_playerdatajson is not null then 
    
         for v_playerdata in select * from json_array_elements(v_playerdatajson)
          loop
        -- select current_timestamp into v_currenttimestamp;
       	v_hero_rating_id   := nextval('labkkr_v1.seq_labkkr_v1_hero_rating_id');
        v_asset_guid1       := uuid_generate_v4();
        
       select v_playerdata->>'entity_role_map_id', 
              v_playerdata->>'sport_id',
              v_playerdata->>'asset_text', 
              v_playerdata->>'asset_title',
              v_playerdata->>'player_name',
              v_playerdata->>'player_display_name',
              v_playerdata->>'rating'
           into 
              v_entity_role_map_id,
              v_sport_id,
              v_asset_text,
              v_asset_title,
              v_player_name,
              v_player_display_name,
              v_rating
              ;
          
        insert into labkkr_v1.labkkr_v1_hero_rating
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
              language_id
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
            v_language_id
        );
			
            
            --  ===========
            		select v_playerdata->>'asset_map'
                    into   v_asset_mapjson;

                            if v_asset_mapjson is not null then
                               for v_assetdata in select * from json_array_elements(v_asset_mapjson)
                            loop
                                  v_hero_rating_asset_map_id:=nextval('labkkr_v1.seq_labkkr_v1_hero_rating_asset_map_id');

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

                                insert into labkkr_v1.labkkr_v1_hero_rating_asset_map
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
                                    v_language_id
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
       
       
    
       
       
       
       
       
      
      p_result := 1;
     
    	if p_result = 1 then
    		
          p_data := v_json;
          
    	end if;  
   
-- exception
	
    --  when others then
    		-- p_result := -1;
	end;

 $$;


--
