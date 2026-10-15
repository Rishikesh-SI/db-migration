-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_transfer_data(character varying, character varying, character varying, character varying, character varying, character varying)
-- Type: FUNCTION

-- Name: waf_transfer_data(character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: waf_master; Owner: -
--

CREATE FUNCTION waf_master.waf_transfer_data(p_new_schema character varying, p_client_name character varying, p_client_usr_name character varying, p_email_id character varying, p_pass_wd character varying, p_source_db_name character varying) RETURNS void
    LANGUAGE plpgsql
    AS $_$
declare 
/*p_new_schema text :='test';
p_client_name text;
p_client_usr_name text :='abc' ;
p_email_id text; 
p_pass_wd text;
*/
v_max_menu_action_id numeric;
begin 
begin   
execute 'insert into '||p_new_schema||'.'||p_new_schema||'_user
         select * from '||p_source_db_name||'.'||p_source_db_name||'_user';
		
 execute 'update '||p_new_schema||'.'||p_new_schema||'_user
         set user_name=$1,
		     full_name=$2,
			 display_name=$2,
			 email_id=$3,
			 user_pwd=$4'
 using 	p_client_usr_name,p_client_name,p_email_id,p_pass_wd;	
 
 execute 'insert into '||p_new_schema||'.'||p_new_schema||'_entity_type
         select * from '||p_source_db_name||'.'||p_source_db_name||'_entity_type';
 
 execute 'insert into '||p_new_schema||'.'||p_new_schema||'_entity_group
         select * from '||p_source_db_name||'.'||p_source_db_name||'_entity_group';
		 
execute 'update '||p_new_schema||'.'||p_new_schema||'_entity_group
		 set group_name=$1,group_desc=$1
		 where  group_name=''client_name'''
using p_client_name;
		 

execute 'update '||p_new_schema||'.'||p_new_schema||'_entity_group
         set group_name=$1,
		     group_desc=$1
		 where entity_group_id=1'
using 	p_client_name;	
 
execute 'insert into '||p_new_schema||'.'||p_new_schema||'_entity_role
         select * from '||p_source_db_name||'.'||p_source_db_name||'_entity_role';
		
execute 'insert into '||p_new_schema||'.'||p_new_schema||'_entity_category
         select * from '||p_source_db_name||'.'||p_source_db_name||'_entity_category';
		
execute 'insert into '||p_new_schema||'.'||p_new_schema||'_entity_master
         select * from '||p_source_db_name||'.'||p_source_db_name||'_entity_master';
		 
		 

execute 'insert into '||p_new_schema||'.'||p_new_schema||'_entity_role_map
         select * from '||p_source_db_name||'.'||p_source_db_name||'_entity_role_map';
		 
execute 'update '||p_new_schema||'.'||p_new_schema||'_entity_master
		 set entity_name= $1,
		     entity_display_name=$1,
			 wafc_entity_name=$1,
			 wafc_entity_display_name=$1,
			 known_as=$1
		 where entity_name=''p_client'''
using 	p_client_name ;	 
		 
		 
execute 'insert into '||p_new_schema||'.'||p_new_schema||'_asset_type
         select * from '||p_source_db_name||'.'||p_source_db_name||'_asset_type';

execute 'insert into '||p_new_schema||'.'||p_new_schema||'_container
         select * from '||p_source_db_name||'.'||p_source_db_name||'_container';
		 
execute 'insert into '||p_new_schema||'.'||p_new_schema||'_content_provider
         select * from '||p_source_db_name||'.'||p_source_db_name||'_content_provider';
		 
execute 'insert into '||p_new_schema||'.'||p_new_schema||'_role
         select * from '||p_source_db_name||'.'||p_source_db_name||'_role';
		 
execute 'insert into '||p_new_schema||'.'||p_new_schema||'_user_role
         select * from '||p_source_db_name||'.'||p_source_db_name||'_user_role';
		 
execute 'insert into '||p_new_schema||'.'||p_new_schema||'_ad_client
         select * from '||p_source_db_name||'.'||p_source_db_name||'_ad_client';	
		 
execute 'insert into '||p_new_schema||'.'||p_new_schema||'_user_role_menu_action_map2
         select * from '||p_source_db_name||'.'||p_source_db_name||'_user_role_menu_action_map2';	
   
execute 'select max(role_menu_action_id) from 
	 		 '||p_new_schema||'.'||p_new_schema||'_user_role_menu_action_map2'
into v_max_menu_action_id ;

execute 'select setval('''||p_new_schema||'.seq_'||p_new_schema||'_user_role_menu_action_map'','||v_max_menu_action_id||')';	 

insert into siwaf.siwaf_client_sitemap_category_map
select  nextval('siwaf.seq_siwaf_client_sitemap_category_map_id'), p_new_schema ,1,0,null,null,'site-map/','.xml',1;

insert into siwaf.siwaf_client_sitemap_category_map
select  nextval('siwaf.seq_siwaf_client_sitemap_category_map_id'), p_new_schema ,2,0,null,null,'site-map/','.xml',1;
 
insert into siwaf.siwaf_client_sitemap_category_map
select  nextval('siwaf.seq_siwaf_client_sitemap_category_map_id'), p_new_schema ,3,1,5000,null,'site-map/','.xml',1;
 
 
end ; 
end;
$_$;


--
