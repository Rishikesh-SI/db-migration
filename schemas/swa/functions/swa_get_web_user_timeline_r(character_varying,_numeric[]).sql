-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_get_web_user_timeline_r(character varying, numeric[])
-- Type: FUNCTION

-- Name: swa_get_web_user_timeline_r(character varying, numeric[]); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_get_web_user_timeline_r(p_user_guid character varying, p_entity_role_map_id numeric[], OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

	---********************************PREFACE BLOCK*******************************
	--      NAME: _get_web_user_timeline_r
	----    Purpose: login user and then fetch user detail data for fev team and predict 11 
	----    Parameters: p_user_id,p_entity_role_map_id
	------  External Output: p_json
	------  Written/Modified by:   Date:              Reason:
	--      R. BHATKAR             22/02/2018         CREATION
	--********************************END PREFACE BLOCK***************************
DECLARE
	
  v_sysdate TIMESTAMP := CURRENT_TIMESTAMP AT TIME ZONE'utc';
  
  v_user_timeline_id numeric;
  v_entity_role_map_id numeric[];
  
  v_asset_count jsonb;
  v_category_cur jsonb;
  v_listing_asset_count numeric;
  v_listing_asset_json jsonb;
  v_json jsonb;
  v_asset_count_str text;
  v_fev_team_id numeric ;
  v_web_user_team jsonb;
  v_user_id numeric;
  
 v_user_name varchar(200);
BEGIN
if p_user_guid is not null then 

select web_user_id, fev_team_id ,web_usr_team 
 into v_user_id, v_fev_team_id,v_web_user_team
from swa.swa_web_user_timeline
where web_user_guid=p_user_guid
;

select  social_user_name into  v_user_name
from swa.swa_web_user 
where user_guid =p_user_guid
;
	
	select array_append(p_entity_role_map_id, v_fev_team_id)
  into   v_entity_role_map_id;
	
	select * from swa.swa_get_asset_count_by_cat_json2_r(v_entity_role_map_id, null, null)
    into v_asset_count, v_category_cur;
	
	
	if v_asset_count::text is null then
       v_asset_count_str := '[]';
   else
    	v_asset_count_str := trim(trailing '}' from trim(leading '{' from v_asset_count::text));
    end if;
	
	
	select * from 
    swa.swa_get_asset_list_user_r(1, 100, 100, 
                                v_entity_role_map_id, null, null, null) s1
    into v_listing_asset_count, v_listing_asset_json;
	
	
     
       
       
      v_json := '{"data":{"user_id":"'||coalesce(v_user_id::text, '')||'",
                          "social_user_name" : "'||coalesce(v_user_name::text, '')||'",
    					"user_guid":"'||coalesce(p_user_guid, '')||'",
                        "Fev_Team_id":"'||coalesce(v_fev_team_id::text, '')||'",
                        "teams":'||v_web_user_team::text||'}}'
						;
      
	  
	 p_json := v_json::jsonb;
	p_json:=jsonb_set(p_json, '{data,category_data}', coalesce(v_category_cur::jsonb,'[]'), true)::jsonb;
	p_json:=jsonb_set(p_json, '{data,items}',  coalesce(v_listing_asset_json::jsonb,'[]'), true)::jsonb;

end if ;
END;

$$;


--
