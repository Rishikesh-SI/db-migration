-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_get_web_user_timeline_r(numeric, numeric[])
-- Type: FUNCTION

-- Name: labdms_get_web_user_timeline_r(numeric, numeric[]); Type: FUNCTION; Schema: labdms; Owner: -
--

CREATE FUNCTION labdms.labdms_get_web_user_timeline_r(p_user_id numeric, p_entity_role_map_id numeric[], OUT p_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
 
	---********************************preface block*******************************
	--   name: _get_web_user_timeline_r
	----  purpose:
	----  parameters:
	------  external output:
	------  written/modified by:   date:           reason:
	--  r. bhatkar             22/02/2018         creation
	--********************************end preface block***************************
declare
	--ref refcursor;-- declare a cursor variable
  v_sysdate timestamp := current_timestamp at time zone'utc';
  
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
  
begin

select  fev_team_id ,web_usr_team into  v_fev_team_id,v_web_user_team
from labdms.labdms_web_user_timeline
where web_user_id=p_user_id
;
	
	select array_append(p_entity_role_map_id, v_fev_team_id)
    into   v_entity_role_map_id;
	
	select * from labdms.labdms_get_asset_count_by_cat_json_r(v_entity_role_map_id, null, null)
    into v_asset_count, v_category_cur;
	
	
	if v_asset_count::text is null then
    	-- v_asset_count_str := '"'||''||'"';
        v_asset_count_str := '[]';
    else
    	v_asset_count_str := trim(trailing '}' from trim(leading '{' from v_asset_count::text));
    end if;
	
	
	select * from 
     labdms.labdms_get_asset_list_user_r(1, 60, 60, 
                                 v_entity_role_map_id, null, null, null) s1
    into v_listing_asset_count, v_listing_asset_json;
	
	

	
	 v_json := '{"content" : {
                			"data" :{
							       "user_id" : "'||coalesce(p_user_id::text, '')||'",
                            	   "team_id" : "'||coalesce(v_fev_team_id::text, '')||'",
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
--open ref for select * from labdms.labdms_web_user_timeline where web_user_id = p_user_id;-- open the second cursor
--return ref;

end;

$$;


--
