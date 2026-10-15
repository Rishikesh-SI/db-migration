-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_get_web_user_timeline_r(numeric, numeric[])
-- Type: FUNCTION

-- Name: dd_get_web_user_timeline_r(numeric, numeric[]); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_get_web_user_timeline_r(p_user_id numeric, p_entity_role_map_id numeric[], OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
 
	---********************************PREFACE BLOCK*******************************
	--   NAME: _get_web_user_timeline_r
	----  Purpose:
	----  Parameters:
	------  External Output:
	------  Written/Modified by:   Date:           Reason:
	--  R. BHATKAR             22/02/2018         CREATION
	--********************************END PREFACE BLOCK***************************
DECLARE
	--REF refcursor;-- Declare a cursor variable
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
  
BEGIN

select  fev_team_id ,web_usr_team into  v_fev_team_id,v_web_user_team
from dd.dd_web_user_timeline
where web_user_id=p_user_id
;
	
	select array_append(p_entity_role_map_id, v_fev_team_id)
    into   v_entity_role_map_id;
	
	select * from dd.dd_get_asset_count_by_cat_json_r(v_entity_role_map_id, null, null)
    into v_asset_count, v_category_cur;
	
	
	if v_asset_count::text is null then
    	-- v_asset_count_str := '"'||''||'"';
        v_asset_count_str := '[]';
    else
    	v_asset_count_str := trim(trailing '}' from trim(leading '{' from v_asset_count::text));
    end if;
	
	
	select * from 
     dd.dd_get_asset_list_user_r(1, 60, 60, 
                                 v_entity_role_map_id, null, null, null) s1
    into v_listing_asset_count, v_listing_asset_json;
	
	

	
	 v_json := '{"content" : {
                			"data" :{
							       "user_id" : "'||coalesce(p_user_id::text, '')||'",
                            	   "Team_id" : "'||coalesce(v_fev_team_id::text, '')||'",
								    '||trim(trailing '}' from trim(leading '{' from v_web_user_team::text))||',
                                   '||trim(trailing '}' from trim(leading '{' from v_listing_asset_json::text))||',
                                   "category_data" : '||trim(trailing '}' from trim(leading '{' from v_category_cur::text))||',
                                   "asset_data" : '||v_asset_count_str||'}},
				"imagesdata" : null,
                "authordata" : null,
                "nextprev" : null,
                "entitydata" : null,
                "meta" : null}';
	 p_json := v_json::jsonb;
--OPEN REF FOR SELECT * FROM dd.dd_web_user_timeline WHERE web_user_id = p_user_id;-- Open the second cursor
--RETURN REF;

END;

$$;


--
