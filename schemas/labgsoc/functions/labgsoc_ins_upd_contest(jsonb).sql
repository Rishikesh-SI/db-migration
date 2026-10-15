-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_ins_upd_contest(jsonb)
-- Type: FUNCTION

-- Name: labgsoc_ins_upd_contest(jsonb); Type: FUNCTION; Schema: labgsoc; Owner: -
--

CREATE FUNCTION labgsoc.labgsoc_ins_upd_contest(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
    v_json             	  jsonb;
	v_contestid        	  numeric;
	v_status           	  numeric;
	v_assetdraftid     	  numeric;
	v_assetid          	  numeric;
	v_assettypeid      	  numeric;
	v_createdby        	  numeric;
	v_updatedby        	  numeric;
	v_assetdraftguid   	  varchar;
	v_versionnumber    	  numeric := 1;
	v_contentsourceid  	  numeric;
	v_title        	      varchar;
	v_titlealias       	  varchar;
	v_browsertitle     	  varchar;
	v_highlights    	  jsonb;
	v_place            	  varchar;
	v_country             varchar;
	v_fulltext            text;
	v_introtext           text;
	v_published_date      timestamp;
	v_contestguid         varchar;
	v_assetentitymapid    numeric;
	v_entityrolemapid     numeric;
	v_priority 	    	  numeric;
	v_labgsocinkable  		  numeric;
	v_isvisible  		  numeric;
	v_assetentitymapguid  varchar;
	v_seojson 		      jsonb;
	v_seodataid 		  numeric;
	v_seodataguid 		  varchar;
	v_entityjson 		  json;
	v_entity 			  json;
	v_contestexists 	  numeric;
	v_seoexists 		  numeric;
	v_entityexists 	      numeric;
	v_currenttimestamp    timestamp;
	v_contestassetmapjson json;
	v_contestassetmap	  json;
	v_aam_assetid		  numeric;
	v_aam_assettypeid	  numeric;
	v_contestassetmapid   numeric;
	v_contestassetmapguid varchar;
	v_assetmetajson       jsonb;
	v_is_trashed          numeric;
	v_authordatajson      json;
	v_authordata          jsonb;
	v_author_id           numeric;        
	v_action_id           numeric;
	v_authoractionid      numeric;
	v_pubversionnumber    numeric;
	v_show_copyright 	  numeric;
	v_show_in_web 		  numeric;
	v_show_in_mobile  	  numeric;
	v_content_source_link varchar;
	v_order_number 	      numeric;
	v_asset_list_id 	  numeric;
	v_image_file_name 	  varchar;
	v_image_path 		  varchar;
	v_imageid 		      numeric;
	v_is_cover 		      numeric;
	v_continue		      numeric := 0;
    v_slugurl			  varchar;
    p_result1             numeric;
    v_ispublished         numeric;
    v_contestpublishedstatus numeric;
    v_contesttrashedstatus numeric;
    v_shorttitle varchar;
    v_entity_lang_id numeric;
	v_web_listing_json jsonb ;
	v_array numeric[];
	v_image jsonb;
    v_entity_count numeric;
    v_sitemap_json jsonb;
	v_start_date timestamp ;
	v_end_date timestamp ;
	v_contest_description text;
	v_contest_questions jsonb;
	v_for_loggedin_user boolean;
	v_contestoptionjson jsonb;
	v_counter numeric;
	v_contestoption jsonb;
	v_option text;
	v_optionorder numeric;
	v_contest_option_id numeric;
	v_contestoptionid numeric;
	v_contestoptionguid text;
	v_answer text ;
	v_is_correct_answer boolean;
	v_is_deleted numeric;
	v_contestanswers jsonb;
	v_answwer_id numeric;
	v_counter1 numeric := 0;
	v_contest_answers_array jsonb;
	v_is_deleted1 numeric;
	v_answer_type text;
	v_is_ans text;
	v_contest_information text;
	v_contest_status text;
	v_allow_multiple_entries boolean;
begin
	
	v_currenttimestamp := current_timestamp at time zone 'utc';
	
insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'ins_upd_contest','logs',uuid_generate_v4(),p_json,current_timestamp,'labgsoc','logs');
	
	select p_json->'data' into p_json;
	v_json:='{"data":'||p_json::json||'}';
	
	select v_json->'data'->>'contest_id',
     	   v_json->'data'->>'status',
           v_json->'data'->>'asset_type',
           v_json->'data'->>'created_by',
           v_json->'data'->>'edited_by',
           v_json->'data'->>'content_source_id',
           v_json->'data'->>'title',
           -- v_json->'data'->>'title_alias',
           v_json->'data'->>'browser_title',
           v_json->'data'->>'highlights',
           v_json->'data'->>'place',
		   v_json->'data'->>'country',
           v_json->'data'->>'full_text',
           v_json->'data'->>'intro_text',
           v_json->'data'->'seo',
           v_json->'data'->>'asset_meta',
           v_json->'data'->>'published_date',
           v_json->'data'->>'is_trashed',
           v_json->'data'->>'show_copyright',
           v_json->'data'->>'show_in_web',
           v_json->'data'->>'show_in_mobile',
           v_json->'data'->>'content_source_link',
           v_json->'data'->>'order_number',
           v_json->'data'->>'image_id',
           v_json->'data'->>'image_file_name',
           v_json->'data'->>'image_path',
           v_json->'data'->>'slug_url',
           v_json->'data'->>'short_title',
		   v_json->'data'->>'start_date',
		   v_json->'data'->>'end_date',
		   v_json->'data'->>'contest_description',
		   v_json->'data'->>'contest_questions',
		   v_json->'data'->>'for_loggedin_user',
		   v_json->'data'->>'is_ans',
		   v_json->'data'->>'contest_information',
		   --v_json->'data'->>'contest_status',
		   v_json->'data'->>'allow_multiple_entries'
		   
		   
	into   v_contestid,
		   v_status,
           v_assettypeid,
           v_createdby,
           v_updatedby,
           v_contentsourceid,
           v_title,
           -- v_titlealias,
           v_browsertitle,
           v_highlights,
           v_place,
           v_country,
           v_fulltext,
           v_introtext,
           v_seojson,
           v_assetmetajson,
           v_published_date,
           v_is_trashed,
           v_show_copyright,
           v_show_in_web,
           v_show_in_mobile,
           v_content_source_link,
           v_order_number,
           v_imageid,
           v_image_file_name,
           v_image_path,
           v_titlealias,
           v_shorttitle,
		   v_start_date ,
		   v_end_date ,
		   v_contest_description,
		   v_contest_questions,
		   v_for_loggedin_user,
		   v_is_ans,
		   v_contest_information,
		  -- v_contest_status,
		   v_allow_multiple_entries;
		   
		
           
	-- insert entry in labgsoc_redirect table :- changes done by rakesh bhatkar --
    select labgsoc.labgsoc_ins_up_redirect(v_contestid,v_titlealias,v_status,v_assettypeid) into p_result1;
  	-- insert entry in labgsoc_redirect table :- changes done by rakesh bhatkar --
	
	
	
    begin

	   raise notice ',v_contest_information %',v_contest_information; 

		
        select contest_id
     	into strict v_contestexists
     	from   labgsoc.labgsoc_contest
     	where  upper(title_alias) = upper(v_titlealias);
        
		if v_contestid is null then
        	v_continue := -1;
		else
        	if v_contestexists = v_contestid then
            	v_continue := 1;
          	else
           		v_continue := -1;
          	end if;
		end if;
        
     exception
     	when others then
          	v_continue := 1;
	end;
	
 --    case
 --         when v_start_date > current_timestamp then v_contest_status := 2
	-- 	 when  v_end_date < current_timestamp then v_contest_status := 0
	-- 	 when v_start_date <= current_timestamp <=  v_end_date then v_contest_status := 1
	-- end ;

	v_contest_status := 
  CASE 
    WHEN v_start_date > current_timestamp THEN 2
    WHEN v_start_date <= current_timestamp AND v_end_date >= current_timestamp THEN 1
    ELSE 0
  END;
    	
        v_published_date := coalesce(v_published_date,v_currenttimestamp); 
		v_assetdraftid := nextval('labgsoc.seq_labgsoc_asset_draft_id');
		v_assetdraftguid := uuid_generate_v4();
		
		if v_contestid is null then
			
            v_contestid := nextval('labgsoc.seq_labgsoc_contest_id');
			v_contestguid := uuid_generate_v4();
			v_seodataid := nextval('labgsoc.seq_labgsoc_seo_data_id');
			v_seodataguid := uuid_generate_v4();
			v_asset_list_id := nextval ('labgsoc.seq_labgsoc_asset_list_id');
			v_json := jsonb_set(v_json, '{data,contest_id}', v_contestid::text::jsonb, true);
			v_json := jsonb_set(v_json, '{data,guid}', ('"'||v_contestguid||'"')::text::jsonb, true);
				
			insert into labgsoc.labgsoc_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
                                            created_by, updated_by, is_active, is_deleted, asset_draft_guid)
			values(v_assetdraftid, v_contestid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby, v_updatedby,
                   1, 0, v_assetdraftguid);
				   
			
			insert into labgsoc.labgsoc_contest(contest_id, content_source_id, asset_meta, title, title_alias, browser_title, highlights, content_source, place,
                                        country, show_in_app, disclaimer_text, checked_out_by, full_text, intro_text, published_version_number,
                                        created_date, updated_date, created_by, updated_by, is_active, is_deleted, is_published, is_trashed,
                                        contest_guid, published_date, show_in_web, show_in_mobile, show_copyright, content_source_link, order_number,
                                        slug_url,short_title,start_date,end_date,contest_description,contest_questions,for_loggedin_user , contest_information , contest_status,allow_multiple_entries)
			values(v_contestid, v_contentsourceid, v_assetmetajson, v_title, v_titlealias, v_browsertitle, v_highlights, null, v_place, v_country, 0,
                   null, null, v_fulltext, v_introtext, v_versionnumber, v_currenttimestamp, v_currenttimestamp, v_createdby, v_updatedby, 1, 0,
                   v_status, v_is_trashed, v_contestguid, v_published_date, v_show_in_web, v_show_in_mobile, v_show_copyright, v_content_source_link,
                   v_order_number, v_slugurl,v_shorttitle,v_start_date,v_end_date,v_contest_description,v_contest_questions,v_for_loggedin_user , v_contest_information , v_contest_status ,v_allow_multiple_entries);
			
			insert into labgsoc.labgsoc_asset_list(asset_list_id, asset_id, asset_type_id, asset_title, title_alias, author_id, short_desc, tags,
                                           primary_entity_role_map_id, secondary_entity_role_map_id, total_assets, image_file_name, image_path,
                                           duration, show_in_web, show_in_mobile, show_in_app, published_version_number, is_trashed, created_date, 
                                           updated_date, created_by, updated_by, is_active, is_deleted, is_published, published_date, asset_guid,
                                           show_copyright, order_number,short_title)
			values(v_asset_list_id, v_contestid, v_assettypeid, v_title, v_titlealias, null, v_introtext, null, null, null, null, v_image_file_name,
                   v_image_path, null, v_show_in_web, v_show_in_mobile, 0, v_versionnumber, v_is_trashed, v_currenttimestamp, v_currenttimestamp,
                   v_updatedby, v_updatedby, 1, 0, v_status, v_published_date, v_contestguid, v_show_copyright, v_order_number,v_shorttitle);
			
			insert into labgsoc.labgsoc_seo_data(seo_data_id, asset_id, asset_type_id, meta_info, published_version_number, created_date, updated_date,
                                         created_by, updated_by, is_active, is_deleted, is_published, seo_data_guid)
			values(v_seodataid, v_contestid, v_assettypeid, v_seojson, v_versionnumber, v_currenttimestamp, v_currenttimestamp, v_createdby, v_updatedby,
                   1, 0, v_status, v_seodataguid);
			
		else
        	
            select is_published, is_trashed
            into v_contestpublishedstatus, v_contesttrashedstatus
            from labgsoc.labgsoc_contest
            where contest_id = v_contestid;
            
            if v_status = 0 then
            	
                if v_is_trashed = 0 then
                	
                    select coalesce(published_version_number,1), is_published
					into   strict v_pubversionnumber, v_ispublished
					from   labgsoc.labgsoc_contest
					where  contest_id = v_contestid;
						
					select max(version_number)
					into   strict v_versionnumber
					from   labgsoc.labgsoc_asset_draft
					where  asset_type_id = v_assettypeid
					and    asset_id      = v_contestid;
						raise notice '1';
						raise notice ' v_versionnumber %',v_versionnumber;
						raise notice ' v_pubversionnumber %',v_pubversionnumber;

					update labgsoc.labgsoc_contest
					set is_published=0,
					 is_trashed=0
					where contest_id = v_contestid;
					
						
					if ((v_versionnumber = v_pubversionnumber and v_ispublished = 0) or (v_versionnumber > v_pubversionnumber)) then
						
                        update labgsoc.labgsoc_asset_draft ad
						set    asset_data        = v_json,
						       updated_date      = v_currenttimestamp
						where  asset_id          = v_contestid
                        and    asset_type_id     = v_assettypeid
						and    ad.version_number = (select max(ad1.version_number)
                                                    from   labgsoc.labgsoc_asset_draft ad1
                                                    where  ad1.asset_id = ad.asset_id
                                                    and    ad1.asset_type_id = ad.asset_type_id);
						
					else
						raise notice '2';
						v_versionnumber := v_versionnumber + 1;
                        
						insert into labgsoc.labgsoc_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
                                                        created_by, updated_by, is_active, is_deleted, asset_draft_guid)
						values(v_assetdraftid, v_contestid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby,
                               v_updatedby, 1, 0, v_assetdraftguid);
						
                    end if;
                    
				else
					
                    update labgsoc.labgsoc_contest
					set    is_published = v_status,
                    	   is_trashed   = 1,
						   updated_date = v_currenttimestamp
					where  contest_id   = v_contestid;
					
					        delete from   labgsoc.labgsoc_asset_entity_map
							where  asset_type_id = v_assettypeid
							and    asset_id      = v_contestid;
					
                    update labgsoc.labgsoc_asset_draft ad
                    set    asset_data        = v_json,
                    	   updated_date      = v_currenttimestamp
					where  asset_id          = v_contestid
					and    asset_type_id     = v_assettypeid
                    and    ad.version_number = (select max(ad1.version_number)
                                                from   labgsoc.labgsoc_asset_draft ad1
                                                where  ad1.asset_id = ad.asset_id
                                                and ad1.asset_type_id = ad.asset_type_id);
					
					update labgsoc.labgsoc_asset_list
					set    updated_date = v_currenttimestamp,
						   updated_by   = v_updatedby,  
                           is_published = v_status,
                           is_trashed   = v_is_trashed
					where  asset_id     = v_contestid
          			and asset_type_id   = v_assettypeid;
                    
			  		select max(ad1.version_number)
                    into   v_versionnumber
                    from   labgsoc.labgsoc_asset_draft ad1
                    where  ad1.asset_id = v_contestid
					and    ad1.asset_type_id = v_assettypeid;
                    
				end if;
                
			else
				
				select max(version_number)
				into   strict v_versionnumber
				from   labgsoc.labgsoc_asset_draft
				where  asset_type_id = v_assettypeid
				and    asset_id      = v_contestid;
				
				v_versionnumber := v_versionnumber + 1;
				
				insert into labgsoc.labgsoc_asset_draft(asset_draft_id, asset_id, asset_type_id, version_number, asset_data, created_date, updated_date,
                                                created_by, updated_by, is_active, is_deleted, asset_draft_guid)
				values(v_assetdraftid, v_contestid, v_assettypeid, v_versionnumber, v_json, v_currenttimestamp, v_currenttimestamp, v_createdby, 
                       v_updatedby, 1, 0, v_assetdraftguid);
				
				update labgsoc.labgsoc_contest
				set    content_source_id 	    = v_contentsourceid,
					   asset_meta        	    = v_assetmetajson,
                       title        	        = v_title,
                       title_alias       	    = v_titlealias,
                       browser_title     	    = v_browsertitle,
                       highlights    	        = v_highlights,
                       content_source    	    = null,
                       place             	    = v_place,
                       country 			        = v_country,
                       show_in_app       	    = 0,
                       disclaimer_text   	    = null,
                       checked_out_by    	    = null,
                       full_text         	    = v_fulltext,
                       intro_text        	    = v_introtext,
                       published_version_number = v_versionnumber,
                       updated_date      	    = v_currenttimestamp,
                       updated_by        	    = v_updatedby,
                       is_active         	    = 1,
                       is_deleted        	    = 0,
                       is_published      	    = v_status,
                       is_trashed        	    = v_is_trashed,
                       published_date           = v_published_date,
                       show_in_web          	= v_show_in_web,
                       show_in_mobile           = v_show_in_mobile,
                       show_copyright           = v_show_copyright,
                       content_source_link      = v_content_source_link,
                       order_number             = v_order_number,
                       slug_url                 = v_slugurl,
                       short_title              = v_shorttitle,
					   start_date               =  v_start_date,
					   end_date                 =  v_end_date,
					   contest_questions        =   v_contest_questions,
					   contest_description      =   v_contest_description,
					   for_loggedin_user        =   v_for_loggedin_user,
					    contest_information     =    v_contest_information,
					    -- contest_status          =     CASE WHEN v_contest_status = 'past' THEN 0 
						   --                                 WHEN v_contest_status = 'present' THEN 1
         --                                                   WHEN v_contest_status = 'future' THEN 2  ELSE NULL END
                      contest_status           =   v_contest_status,
					  allow_multiple_entries   =    v_allow_multiple_entries
				 where  contest_id        	    = v_contestid;
                
				update labgsoc.labgsoc_seo_data
				set    meta_info 	 = v_seojson,
					   updated_date  = v_currenttimestamp
				where  asset_type_id = v_assettypeid
				and    asset_id      = v_contestid;
                
				update labgsoc.labgsoc_asset_list
				set   asset_title        	   = v_title,
					  title_alias       	   = v_titlealias,
                      short_desc    	       = v_introtext,
                      show_in_app       	   = 0,
                      published_version_number = v_versionnumber,
                      updated_date      	   = v_currenttimestamp,
                      updated_by        	   = v_updatedby,
                      is_active         	   = 1,
                      is_deleted        	   = 0,
                      is_published      	   = v_status,
                      is_trashed        	   = v_is_trashed,
                      published_date           = v_published_date,
                      show_in_web              = v_show_in_web ,
                      show_in_mobile           = v_show_in_mobile,
                      show_copyright           = v_show_copyright,
                      order_number 			   = v_order_number,
                      short_title              = v_shorttitle
				where asset_id        	       = v_contestid
        		and   asset_type_id            = v_assettypeid;
                
			end if;
		
		end if;
		--raise notice 'v_contestoptionjson %',v_contestoptionjson;

		select v_json->'data'->>'contest_questions'
                into   v_contestoptionjson;
				
          if v_contestoptionjson is not null then
               	     v_counter := 0;
                    for v_contestoption in (select * from jsonb_array_elements(v_contestoptionjson)
                   )
                     
                    loop

						
                     	
                     select v_contestoption->>'question', v_contestoption->>'option_order',v_contestoption->>'question_id' , v_contestoption->>'is_deleted', v_contestoption->>'answer_type'
					into   v_option, v_optionorder,v_contest_option_id,v_is_deleted1,v_answer_type;
					
					
					-- select 1/0;
             
 
           	if not exists(select 1 from labgsoc.labgsoc_contest_option where contest_option_id = v_contest_option_id and contest_id = v_contestid) then              
						 
               			v_contest_option_id := nextval('labgsoc.seq_labgsoc_contest_option_id');
												
                              v_contestoptionguid := uuid_generate_v4();
			end if;
			  
	
				v_contestoption= jsonb_set(v_contestoption,('{question_id}'),('"'||v_contest_option_id||'"')::text::jsonb,true);				 
					 
		select v_contestoption->'contest_answers' into v_contest_answers_array;

	

		if 	v_contest_answers_array is not null and v_contest_answers_array <> '[]' and v_contest_answers_array <> 'null' then

		v_counter1 := 0;
		
		   for v_contestanswers in (select * from jsonb_array_elements(v_contest_answers_array))

		   		loop 

				   

						select v_contestanswers ->>'answer' ,v_contestanswers ->>'answer_id', v_contestanswers ->>'is_correct_answer' , v_contestanswers ->>'is_deleted'
						into v_answer ,v_answwer_id, v_is_correct_answer , v_is_deleted;

				if not exists (select 1 from labgsoc.labgsoc_contest_answer where contest_answer_id = v_answwer_id and contest_option_id =v_contest_option_id and contest_id = v_contestid) then 

						  v_answwer_id = nextval('labgsoc.seq_labgsoc_contest_answer_id');
						  

						insert into labgsoc.labgsoc_contest_answer values (v_answwer_id , v_contestid , v_contest_option_id ,  v_answer , v_is_correct_answer , v_is_deleted ) ;

						else

						 update labgsoc.labgsoc_contest_answer
					   set answer = v_answer,
							is_correct_answer = v_is_correct_answer,
							is_deleted = v_is_deleted
					   where contest_option_id =v_contest_option_id and contest_id = v_contestid and contest_answer_id = v_answwer_id;

						
						
						end if;

						v_contestoption= jsonb_set(v_contestoption , ('{contest_answers,' || v_counter1 ::text ||' , answer_id}' ):: text[] , ('"'|| v_answwer_id||'"')::text::jsonb,true);
                    
						
						
						v_counter1 := v_counter1 + 1;

						 

						
						end loop;
		end if;

		
	
		v_json= jsonb_set(v_json,('{data,contest_questions,'||v_counter::text||'}')::text[],
                                 v_contestoption,true);	

	
	if not exists(select 1 from labgsoc.labgsoc_contest_option where contest_option_id = v_contest_option_id and contest_id = v_contestid) then
								 
		 insert into labgsoc.labgsoc_contest_option(contest_option_id, contest_id, option, 
            created_date, updated_date, created_by, updated_by, is_active, is_deleted,
               contest_option_guid, option_order , answer_type)
						values(v_contest_option_id, v_contestid, v_contestoption, v_currenttimestamp, v_currenttimestamp, v_createdby,
            v_createdby, 1, 0, v_contestoptionguid, v_optionorder  , v_answer_type);

			   
    else

	raise notice '58';
               update labgsoc.labgsoc_contest_option
               set option = v_contestoption,
                    updated_date = v_currenttimestamp,
                    option_order = v_optionorder,
					is_ans = v_is_ans,
					answer_type = v_answer_type,
					is_active = case when v_is_deleted1 = 0 then 1 else 0 end ,
					is_deleted = v_is_deleted1
					
               where contest_option_id =v_contest_option_id and contest_id = v_contestid;
               
  	end if;

	  v_counter := v_counter + 1;
	  
	  end loop;
	  
	end if;

		
        if  (v_status = 1)then
			
            select v_json->'data'->>'entitydata'
			into   v_entityjson;
            
			if v_entityjson is not null then
            	
                delete
				from   labgsoc.labgsoc_asset_entity_map
				where  asset_type_id = v_assettypeid
				and    asset_id      = v_contestid;
                
				for v_entity in select * from json_array_elements(v_entityjson)
				loop
					
                    select v_entity->>'entity_role_map_id',
					  	   v_entity->>'priority',
						   v_entity->>'is_linkable',
						   v_entity->>'is_visible'
					into   v_entityrolemapid,
					       v_priority,
						   v_labgsocinkable,
						   v_isvisible;
                           
                select count(1) into v_entity_count from labgsoc.labgsoc_asset_list
				where tagged_entity is not null and tagged_entity@> Array[v_entityrolemapid]::int[];
				 
				update labgsoc.labgsoc_entity_role_map 
				set entity_count=v_entity_count
				where entity_role_map_id= v_entityrolemapid;
					
					if (v_entityrolemapid is not null and v_priority is not null) then
                    	
						v_assetentitymapid   := nextval('labgsoc.seq_labgsoc_asset_entity_map_id');
						v_assetentitymapguid := uuid_generate_v4();
						
						insert into labgsoc.labgsoc_asset_entity_map(asset_entity_map_id, asset_id, asset_type_id, entity_role_map_id, is_linkable, is_visible,
															 priority, created_date, updated_date, created_by, updated_by, is_active, is_deleted,
                                                             is_published, aemap_guid)
						values(v_assetentitymapid, coalesce(v_contestid, v_assetid), v_assettypeid, v_entityrolemapid, coalesce(v_labgsocinkable,0),
                               v_isvisible, v_priority, v_currenttimestamp, v_currenttimestamp, v_createdby, v_updatedby, 1, 0, 1, v_assetentitymapguid);
						
						update labgsoc.labgsoc_asset_list
						set    primary_entity_role_map_id 	= case when v_priority = 1 then v_entityrolemapid else primary_entity_role_map_id end,
							   secondary_entity_role_map_id = case when v_priority = 2 then v_entityrolemapid else secondary_entity_role_map_id end
						where  asset_id 				    = coalesce(v_contestid, v_assetid)
           				and    asset_type_id                = v_assettypeid;
                        
					end if;
                    
				end loop;
                
			 
				
			end if;
			SELECT  obj.value->>'entity_role_map_id' into v_entity_lang_id
             from jsonb_array_elements(v_entityjson::jsonb) obj(value)
             where obj.value->>'is_lang'='1';   
				
            
			 update labgsoc.labgsoc_asset_list
             set    language_id=v_entity_lang_id,
             language_entity_role_map_id=v_entity_lang_id
             where  asset_id        = coalesce(v_contestid, v_assetid)
             and    asset_type_id   = v_assettypeid;
			
			select v_json->'data'->>'asset_map'
			into   v_contestassetmapjson;
            
			if v_contestassetmapjson is not null then
            
				delete
				from   labgsoc.labgsoc_contest_asset_map
				where  contest_id      = v_contestid;
                
				for v_contestassetmap in select * from json_array_elements(v_contestassetmapjson)
				loop
                	
                    select v_contestassetmap->>'asset_id',
                    	   v_contestassetmap->>'asset_type_id',
                           v_contestassetmap->>'is_cover'
					into   v_aam_assetid,
                    	   v_aam_assettypeid,
                           v_is_cover;
					
					
					if (v_aam_assetid is not null and v_aam_assettypeid is not null) then
                    	
                        v_contestassetmapid   := nextval('labgsoc.seq_labgsoc_contest_asset_map_id');
						v_contestassetmapguid := uuid_generate_v4();
                        
						insert into labgsoc.labgsoc_contest_asset_map(contest_asset_map_id, contest_id, asset_id, asset_type_id, created_date, updated_date,
                                                              created_by, updated_by, is_active, is_deleted, is_published, aamap_guid, is_cover)
						values(v_contestassetmapid, coalesce(v_contestid, v_assetid), v_aam_assetid, v_aam_assettypeid, v_currenttimestamp,
							   v_currenttimestamp, v_createdby, v_updatedby, 1, 0, v_status, v_contestassetmapguid, v_is_cover);
						
              			if v_is_cover = 1 then
                			
                            select image_path, image_file_name
                			into v_image_path, v_image_file_name
                            from labgsoc.labgsoc_image
                            where image_id = v_aam_assetid;
                            
                			update labgsoc.labgsoc_asset_list
                			set    image_path      = v_image_path,
                            	   image_file_name = v_image_file_name
                			where  asset_id        = coalesce(v_contestid, v_assetid)
                			and    asset_type_id   = v_assettypeid;
                            
              			end if;
                        
					end if;
                    
				end loop;
                
			end if;
            
			select v_json->'data'->>'author_data'
			into   v_authordatajson;
            
			if v_authordatajson is not null then
            	
                delete
                from   labgsoc.labgsoc_author_action
                where  asset_type_id = v_assettypeid
                and    asset_id      = v_contestid;
                
				for v_authordata in select * from json_array_elements(v_authordatajson)
				loop
                	
                    select v_authordata->>'author_id',
					  	   v_authordata->>'action_id'
					into   v_author_id,
                    	   v_action_id;
					
				   	if (v_author_id is not null and v_action_id is not null) then
                    	
						v_authoractionid := nextval('labgsoc.seq_labgsoc_author_action_id');
						
						insert into labgsoc.labgsoc_author_action(author_action_id, author_id, asset_id, asset_type_id, action_id, created_date, updated_date)
						values(v_authoractionid, v_author_id, coalesce(v_contestid, v_assetid), v_assettypeid, v_action_id, v_currenttimestamp,
							   v_currenttimestamp);
						
             			if v_action_id = 4 then
                        	
                            update labgsoc.labgsoc_asset_list
                			set    author_id     = coalesce(v_author_id, author_id)
                			where  asset_id      = coalesce(v_contestid, v_assetid)
                			and    asset_type_id = v_assettypeid;
                            
						end if;
                        
					end if;
                    
				end loop;
                
			end if;
            
		end if;
        
        v_json := jsonb_set(v_json, '{data,version_number}', ('"'||v_versionnumber||'"')::text::jsonb, true);
		
		
		if  v_status = 1 then
        	
			
            
            
            select labgsoc.labgsoc_get_sitemap_json(v_assettypeid,coalesce(v_contestid, v_assetid)) into
            strict v_sitemap_json;
			

               --raise notice 'v_contestid : %',v_contestid;
              ---- raise notice 'v_assetid : %',v_assetid;
              -- raise notice 'v_assettypeid : %',v_assettypeid;
               
               -- select 1/0;
			   
			   
			   	select array(select entity_role_map_id 
					 from labgsoc.labgsoc_asset_entity_map
					 where asset_id = coalesce(v_contestid, v_assetid) 
					 and asset_type_id = v_assettypeid
         
					)	a into v_array; 
					
		select row_to_json(row) into v_image from(
				select a.image_id,1 is_cover,a.image_caption,a.image_path imagePath,
				a.image_desc,a.image_caption as image_alt,a.image_file_name,a.title_alias as img_title,copyright_text image_src
				from labgsoc.labgsoc_image a
				where a.image_id in (
				select asset_id from labgsoc.labgsoc_contest_asset_map
				where contest_id= v_contestid  and is_cover = 1 ))row;
				
				
               
          update labgsoc.labgsoc_asset_list 
		  set
			  web_detail_jsn = v_json,
			  tagged_entity=v_array,
              sitemap_json=v_sitemap_json
		  where asset_id = coalesce(v_contestid, v_assetid) and asset_type_id = v_assettypeid;

		update labgsoc.labgsoc_asset_draft
		  set
			  asset_data = v_json
		  where asset_id = coalesce(v_contestid, v_assetid) and asset_type_id = v_assettypeid;

		  select * from  labgsoc._get_web_list_json(null,39,coalesce(v_contestid, v_assetid)) 
			into strict v_web_listing_json;
			
		--raise notice 'v_web_listing_json : %',v_web_listing_json;
			
		--v_web_listing_json := jsonb_set(v_web_listing_json, '{image_data}',v_image, true);	
		
		 

		   update labgsoc.labgsoc_asset_list 
		  set web_listing_json = v_web_listing_json
		  where asset_id = coalesce(v_contestid, v_assetid) and asset_type_id = v_assettypeid;
            
        end if;
		
		
        p_result := 1;
        
	/*else
     	 p_result := 0;
	end if;*/
    
	if p_result = 1 then
    	
        p_data := v_json;
        
	end if;
    
/*exception
	
	when others then
		p_result := -1;*/
end;
$$;


--
