-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_upd_sync_status(jsonb)
-- Type: FUNCTION

-- Name: labrstg_upd_sync_status(jsonb); Type: FUNCTION; Schema: labrstg; Owner: -
--

CREATE FUNCTION labrstg.labrstg_upd_sync_status(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

v_user_guid  character varying;
v_sync_status numeric;
v_data_json jsonb;
v_data_json1 jsonb;
v_status numeric;
v_assetjson jsonb;
v_asset jsonb;
p_assetjson jsonb;
v_user_id numeric;

begin

	select p_json->'data'->>'items'
	     
    into
		   v_assetjson;		   

for v_asset in select * from jsonb_array_elements(v_assetjson)
      loop	
	  select v_asset->>'user_guid',
	  		 v_asset->>'sync_status'
    	into
		   v_user_guid,
		   v_sync_status;
	
	
update labrstg.labrstg_web_user
set sync_status=v_sync_status
where user_guid=v_user_guid;

	v_status:=1;
	
	end loop;
	
	p_data:='{
	"status": "'|| coalesce(v_status,0) ||'"
	}';

end
$$;


--
