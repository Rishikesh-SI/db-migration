-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_upd_sync_status(jsonb)
-- Type: FUNCTION

-- Name: labgt_upd_sync_status(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_upd_sync_status(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
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

	select p_json->'items',
		   p_json->>'sync_status'	
	     
    into
		   v_assetjson,
   		   v_sync_status;

--raise notice '% v_assetjson',v_assetjson;

for v_asset in select * from jsonb_array_elements(v_assetjson)
      loop	
	  select v_asset->>'CustomerId'
    	into
		   v_user_id;

raise notice '% CustomerId',v_user_id;
--select * from lab.labgt;

update labgt.labgt_web_user
set sync_status = v_sync_status
where user_id=v_user_id;

	v_status:=1;
	
	end loop;

--select * from lab.labgt;

	p_data:='{
	"status": "'|| coalesce(v_status,0) ||'"
	}';

end
$$;


--
