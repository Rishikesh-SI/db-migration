-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _ins_cms_user_activity_tracker(jsonb)
-- Type: FUNCTION

-- Name: _ins_cms_user_activity_tracker(jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._ins_cms_user_activity_tracker(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare

v_module_name varchar(2000);
v_action_id numeric;
v_asset_type_id numeric;
v_asset_id numeric;
v_updated_by_user_id numeric;
v_updated_by_user_name varchar(2000);
v_updated_date timestamp;
v_version_number numeric;
v_asset_title varchar(4000);
v_asset_url varchar(4000);
v_client_id text;
v_client_name varchar(2000);
v_guid text;
begin
select p_json->'data'->>'module_name' ,
	   p_json->'data'->>'action_id',
	   p_json->'data'->>'asset_type_id',
	   p_json->'data'->>'asset_id',
	   p_json->'data'->>'updated_by_user_id',
	   p_json->'data'->>'updated_by_user_name',
	   p_json->'data'->>'updated_date',
	   p_json->'data'->>'version_number',
	   p_json->'data'->>'asset_title',
	   p_json->'data'->>'asset_url',
	   p_json->'data'->>'client_id',
	   p_json->'data'->>'client_name',
	   p_json->'data'->>'guid'
into   v_module_name,
	   v_action_id,
	   v_asset_type_id,
	   v_asset_id,
	   v_updated_by_user_id,
	   v_updated_by_user_name,
	   v_updated_date,
	   v_version_number,
	   v_asset_title,
	   v_asset_url,
	   v_client_id,
	   v_client_name ,
	   v_guid;
	  -- select * from siwaf.siwaf_cms_tracking_activity;
	  insert into siwaf.siwaf_cms_tracking_activity
	  select  nextval('siwaf.seq_tracking_act_id'),v_client_id,v_client_name,v_module_name,v_action_id,v_asset_type_id,v_asset_id,v_asset_title,
	  		  v_asset_url,v_updated_by_user_id,v_updated_by_user_name,v_updated_date,v_version_number,v_guid;
     p_result:=1;
/*
exception when others then 
p_result:=0;
*/
end;

 $$;


--
