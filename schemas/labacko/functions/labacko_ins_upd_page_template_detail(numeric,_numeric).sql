-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_ins_upd_page_template_detail(numeric, numeric)
-- Type: FUNCTION

-- Name: labacko_ins_upd_page_template_detail(numeric, numeric); Type: FUNCTION; Schema: labacko; Owner: -
--

CREATE FUNCTION labacko.labacko_ins_upd_page_template_detail(p_template_id numeric, p_page_id numeric, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
declare 

v_page_id        				labacko.labacko_page.page_id%type;
v_alias        					labacko.labacko_page.alias%type;
v_title        					labacko.labacko_page.title%type;
v_page_level        			labacko.labacko_page.page_level%type;
v_upfront        				labacko.labacko_page.upfront%type;
v_upfront_app        			labacko.labacko_page.upfront_app%type;
v_upfront_mobile        		labacko.labacko_page.upfront_mobile%type;
v_is_wrapper        			labacko.labacko_page.is_wrapper%type;
v_page_parent_id        	    labacko.labacko_page.parent_id%type;
v_visible        				labacko.labacko_page.visible%type;
v_visible_app       	 		labacko.labacko_page.visible_app%type;
v_visible_mobile        		labacko.labacko_page.visible_mobile%type;
v_scheduled_publish        		labacko.labacko_page.scheduled_publish%type;
v_scheduled_unpublish        	labacko.labacko_page.scheduled_unpublish%type;
v_ordering        				labacko.labacko_page.ordering%type;
v_title_mobile        			labacko.labacko_page.title_mobile%type;
v_title_app        				labacko.labacko_page.title_app%type;
v_is_redirect        			labacko.labacko_page.is_redirect%type;
v_published_version_number      labacko.labacko_page.published_version_number%type;
v_created_date        			labacko.labacko_page.created_date%type;
v_updated_date        			labacko.labacko_page.updated_date%type;
v_created_by        			labacko.labacko_page.created_by%type;
v_updated_by        			labacko.labacko_page.updated_by%type;
v_is_active        				labacko.labacko_page.is_active%type;
v_is_deleted        			labacko.labacko_page.is_deleted%type;
v_status        			labacko.labacko_page.is_published%type;
v_page_guid        				labacko.labacko_page.page_guid%type;

v_template_id        			labacko.labacko_template.template_id%type;
v_template_name        			labacko.labacko_template.template_name%type;
v_template_desc        			labacko.labacko_template.template_desc%type;
v_layout_id        				labacko.labacko_template.layout_id%type;
v_is_inherited        			labacko.labacko_template.is_inherited%type;
v_template_parent_id            labacko.labacko_template.parent_id%type;
v_template_guid        			labacko.labacko_template.template_guid%type;
v_json							jsonb;
v_sysdate						timestamp;
v_is_responsive labacko.labacko_template.is_responsive%type;
v_mobile_html  labacko.labacko_template.mobile_html%type;
 
--  entity variables
v_entityjson json;
v_entity json; 
v_assetentitymapid numeric;
v_assetentitymapguid varchar(256);
v_entityrolemapid numeric;
v_priority numeric;
v_islinkable numeric;
v_isvisible  numeric;
v_asset_type numeric:=11;

-- template variables
v_templatejson jsonb;
v_img_ret numeric;
v_img_ret_data jsonb;
v_t_layout_id numeric;
v_t_template_name varchar(2000);
v_t_parent_id numeric;

v_page_template_json jsonb;
v_seojson 		  jsonb;
v_seodataid numeric;
v_seodataguid varchar(200);

v_asset_type_id numeric;
v_is_custom numeric;
-- v_custom_alias character varying ;
v_is_required numeric;
v_custom_alias character varying ;
v_ent_role_map_id  numeric;
v_is_amp numeric;
 
v_meta_info jsonb;
v_is_update numeric;
v_page_alias     labacko.labacko_page.alias%TYPE;
v_page_data_json jsonb;
v_mob_flag numeric;
v_mob_page_data_json jsonb;
  V_page_template_name varchar(4000);
  V_template_html text;
  v_parent_template_id numeric;
  i numeric;
		 begin
		 
 

if p_page_id is not null then
 v_page_id:=p_page_id;
 	   
   select parent_id, template_name, template_html,
		 mobile_html,is_responsive 
		 from labacko.labacko_template
		 where page_id=p_page_id
        into  v_template_id,V_page_template_name,V_template_html,
		V_mobile_html,v_is_responsive;
		
		select is_responsive 
		 from labacko.labacko_template
		 where template_id=v_template_id
        into  v_is_responsive;
		
		
		select is_amp,alias,is_deleted,is_published
		from  labacko.labacko_page
		where page_id=v_page_id
		into v_is_amp,v_page_alias,v_is_deleted,v_status;
	 
	  if    v_is_responsive=0 then
	execute 'select * from labacko.labacko_get_page_data_by_service_r
		  (	''{
  "inputs": {
    "p_url": "",
	"v_service_page_id": '||v_page_id||',
    "is_mobile":1,
    "is_amp":"'||v_is_amp||'",
	"listing_page_no":"1",
  "search_key": {
    "search_text": null,
    "entity_id": null,
    "page_number": null
  }
 }
}'')'  into v_mob_page_data_json;

end if;
 --raise notice '%', v_page_alias;
 ---select 1/0;
execute 'select * from labacko.labacko_get_page_data_by_service_r
		  (	''{
  "inputs": {
   "p_url": "",
   "v_service_page_id": '||v_page_id||',
    "is_mobile":0,
    "is_amp":"'||v_is_amp||'",
	"listing_page_no":"1",
  "search_key": {
    "search_text": null,
    "entity_id": null,
    "page_number": null
  }
 }
}'')'  into v_page_data_json;				 
					 

 ---raise notice '%,%',v_page_alias,v_page_data_json;	
 
 --select 1/0;
					 
		/*if  not exists(select 1 from labacko.labacko_page_template_detail
					 where page_id=v_page_id
					 ) then	*/
					 delete from labacko.labacko_page_template_detail
					 where page_id=v_page_id;
	   insert into labacko.labacko_page_template_detail
	  select nextval('labacko.seq_labacko_page_template_detail_id'),v_page_id,v_page_alias,
	  V_template_id,V_page_template_name,V_template_html,v_page_data_json,1,current_timestamp,current_timestamp,
	  v_mobile_html,v_mob_page_data_json,v_is_responsive,0,v_is_amp,coalesce(v_is_deleted,0),v_status; 
					 
					 
	  /*else
	  update labacko.labacko_page_template_detail
	  set  page_alias=v_page_alias,
	  page_info_json=v_page_data_json,
	  updated_date=current_timestamp, 
	  mobile_page_json= v_mob_page_data_json,
	  is_responsive=v_is_responsive ,
	  is_amp=v_is_amp,
	  is_deleted=coalesce(v_is_deleted,0),
	  is_published=v_status
	  where page_id=v_page_id;
	  end if;*/ 
						   
                       END IF;
					   
					   
	if p_template_id is not null then
	
	
	v_template_id:=p_template_id;
 	   for i in (select page_id from labacko.labacko_template
				where parent_id=v_template_id
				 and is_published=1
				)  loop
				v_page_id:=i;
				
   select parent_id, template_name, template_html,
		 mobile_html,is_responsive 
		 from labacko.labacko_template
		 where page_id=v_page_id
		   into  v_template_id,V_page_template_name,V_template_html,
		V_mobile_html,v_is_responsive;
		
		select is_responsive 
		 from labacko.labacko_template
		 where template_id=v_template_id
        into  v_is_responsive;
		
		select is_amp,alias,is_deleted,is_published
		from  labacko.labacko_page
		where page_id=v_page_id
		into v_is_amp,v_page_alias,v_is_deleted,v_status;
		
		
	 
	  if    v_is_responsive=0 then
	execute 'select * from labacko.labacko_get_page_data_by_service_r
		  (	''{
  "inputs": {
    "p_url": "",
	"v_service_page_id": '||v_page_id||',
    "is_mobile":1,
    "is_amp":"'||v_is_amp||'",
	"listing_page_no":"1",
  "search_key": {
    "search_text": null,
    "entity_id": null,
    "page_number": null
  }
 }
}'')'  into v_mob_page_data_json;

end if;
 --raise notice '%', v_page_alias;
 ---select 1/0;
execute 'select * from labacko.labacko_get_page_data_by_service_r
		  (	''{
  "inputs": {
   "p_url": "",
   "v_service_page_id": '||v_page_id||',
    "is_mobile":0,
    "is_amp":"'||v_is_amp||'",
	"listing_page_no":"1",
  "search_key": {
    "search_text": null,
    "entity_id": null,
    "page_number": null
  }
 }
}'')'  into v_page_data_json;				 
					 

 ---raise notice '%,%',v_page_alias,v_page_data_json;	
 
 --select 1/0;
					 
		/*if  not exists(select 1 from labacko.labacko_page_template_detail
					 where page_id=v_page_id
					 ) then	*/
					 delete from labacko.labacko_page_template_detail
					 where page_id=v_page_id;
	   insert into labacko.labacko_page_template_detail
	  select nextval('labacko.seq_labacko_page_template_detail_id'),v_page_id,v_page_alias,
	  p_template_id,V_page_template_name,V_template_html,v_page_data_json,1,current_timestamp,current_timestamp,
	  v_mobile_html,v_mob_page_data_json,v_is_responsive,0,v_is_amp,coalesce(v_is_deleted,0),v_status; 
					 
					 
	  /*else
	  update labacko.labacko_page_template_detail
	  set  page_alias=v_page_alias,
	  page_info_json=v_page_data_json,
	  updated_date=current_timestamp, 
	  mobile_page_json= v_mob_page_data_json,
	  is_responsive=v_is_responsive ,
	  is_amp=v_is_amp,
	  is_deleted=coalesce(v_is_deleted,0),
	  is_published=v_status
	  where page_id=v_page_id;
	  end if; */
	end loop;
	
	
	end if;
  
	
   p_result:=1;        
     

end;
$$;


--
