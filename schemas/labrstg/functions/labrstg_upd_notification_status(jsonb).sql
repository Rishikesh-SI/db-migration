-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_upd_notification_status(jsonb)
-- Type: FUNCTION

-- Name: labrstg_upd_notification_status(jsonb); Type: FUNCTION; Schema: labrstg; Owner: -
--

CREATE FUNCTION labrstg.labrstg_upd_notification_status(p_json jsonb, OUT v_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
--do
--$$
 

declare
	
	v_user_id numeric;
	v_gallery_id numeric;
	v_user_guid character varying;
	v_assetjson jsonb;
	v_asset jsonb;
	p_assetjson jsonb;
	v_status numeric;

begin

	select p_json->'Data'->>'items',
	       p_json->'Data'->>'user_guid'
    into
		   v_assetjson,
		   v_user_guid;
		   

for v_asset in select * from jsonb_array_elements(v_assetjson)
      loop	
	  select v_asset->'asset_id'
    	into
		   v_gallery_id;
	  
raise notice ' %',v_gallery_id;
raise notice ' %',v_user_guid;

	update labrstg.labrstg_gallery
	set is_read=1
	where user_guid=v_user_guid
	and gallery_id=v_gallery_id;
	
	if exists(select is_read from labrstg.labrstg_gallery
			 where user_guid=v_user_guid
	and gallery_id=v_gallery_id
	and is_read=1) then
	
	v_status:= 1;
	
	else
	
	v_status:=-1;
	exit;
	
	end if;
	raise notice ' %',v_gallery_id;
 
 end loop;
 

	v_json:='{
	"status": "'|| coalesce(v_status,0) ||'"
	}';
 

end;
$_$;


--
