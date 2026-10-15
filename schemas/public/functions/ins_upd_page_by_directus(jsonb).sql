-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: ins_upd_page_by_directus(jsonb)
-- Type: FUNCTION

-- Name: ins_upd_page_by_directus(jsonb); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.ins_upd_page_by_directus(p_json jsonb, OUT p_result numeric, OUT p_data jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare

   v_page_id 						 labrr.labrr_page.page_id%type;
    v_alias 						 labrr.labrr_page.alias%type;
    v_title 						 labrr.labrr_page.title%type;
    v_status 			 			 labrr.labrr_page.is_published%type;
    v_page_guid 					 labrr.labrr_page.page_guid%type ;    

	v_scheduled_publish        		labRR.labRR_page.scheduled_publish%type;
	v_scheduled_unpublish        	labRR.labRR_page.scheduled_unpublish%type;

	v_created_date        			labRR.labRR_page.created_date%type;
	v_updated_date        			labRR.labRR_page.updated_date%type;
	v_created_by        			labRR.labRR_page.created_by%type;
	v_updated_by        			labRR.labRR_page.updated_by%type;
	v_is_active        				labRR.labRR_page.is_active%type;
	v_is_deleted        			labRR.labRR_page.is_deleted%type;


--  entity variables
 
    v_seojson jsonb;
    v_meta_info jsonb;
    v_show_in_sitemap numeric;

-- temporary json variables

    v_json jsonb := p_json;
    v_sysdate timestamp;
	
-- v_custom_alias character varying ;
-- v_is_required numeric;
-- v_custom_alias character varying ;
-- v_ent_role_map_id  numeric;
-- v_is_amp numeric;
 
-- v_meta_info jsonb;
-- v_show_in_sitemap numeric;
-- v_is_update numeric;
-- v_page_alias     labRR.labRR_page.alias%TYPE;
-- v_page_data_json jsonb;
-- v_mob_flag numeric;
-- v_mob_page_data_json jsonb;
--   V_page_template_name varchar(4000);
--   V_template_html text;
--   v_parent_template_id numeric;
		 
 
begin

      select current_timestamp at time zone 'utc'
      into   v_sysdate; 
	  
	  insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
		log_error_message,log_guid,error_json,created_date,client_name,log_type)
		values (nextval('siwaf.seq_siwaf_api_error_log_id'),'ins_upd_page','logs',uuid_generate_v4(),p_json,current_timestamp,'labtri','logs');

      -------------------------------------------------------
      
      v_json := p_json;
      -------------------------------------------------------
      select   
			    v_json->'data'->>'id',  
				v_json->'data'->>'slug',  
				v_json->'data'->>'title',  
               (case when v_json->'data'->>'status' = 'published' then 1  else 0 end),
		
                coalesce((v_json->'data'->>'scheduled_publish')::timestamp,v_sysdate)::timestamp,
                coalesce((v_json->'data'->>'scheduled_unpublish')::timestamp,v_sysdate)::timestamp, 
             
                v_json->'data'->>'guid',  
				v_json->'data'->'seo',  
				v_json->'data'->>'meta_info', 
				v_json->'data'->>'show_in_sitemap'  

     into        v_page_id,
				v_alias,
				v_title,
				v_status,
				v_scheduled_publish,
                v_scheduled_unpublish,
				v_page_guid,
				v_seojson,
				v_meta_info,
				v_show_in_sitemap;
                -- v_is_required
                
				
				
if v_page_id is null 
then
        v_page_id := nextval('labrr.seq_labrr_page_id');
        v_page_guid := uuid_generate_v4();
       
        v_json := jsonb_set(v_json, '{data,page_id}', v_page_id::text::jsonb, true);
        v_json := jsonb_set(v_json, '{data,page_guid}', ('"' || v_page_guid || '"')::text::jsonb, true);
          
          
         
		
		insert into labrr.labrr_page (
            id,
            slug,
            title,
            is_published,
            page_guid,
            seo,
            meta_info,
            show_in_sitemap,
            created_date,
            updated_date
        )
        values (
            v_page_id,
            v_alias,
            v_title,
            v_status,
            v_page_guid,
            v_seojson,
            v_meta_info,
            v_show_in_sitemap,
            v_sysdate,  
            v_sysdate   
        );
		
else
        
      update labrr.labrr_page
        set
            slug = v_alias,
            title = v_title,
            is_published = v_status,
            seo = v_seojson,
            meta_info = v_meta_info,
            show_in_sitemap = v_show_in_sitemap,
            updated_date = v_sysdate
        where id = v_page_id;
    end if;

    p_result := v_page_id;
    p_data := jsonb_build_object(
        'id', v_page_id,
        'slug', v_alias,
        'title', v_title,
        'status', case when v_status = 1 then 'published' else 'unpublished' end
    );

    return ;
	
end;
$$;


--
