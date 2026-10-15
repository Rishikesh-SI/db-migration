-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_get_notification_listing_r(jsonb)
-- Type: FUNCTION

-- Name: labrstg_get_notification_listing_r(jsonb); Type: FUNCTION; Schema: labrstg; Owner: -
--

CREATE FUNCTION labrstg.labrstg_get_notification_listing_r(p_json jsonb, OUT p_assetjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$
--do
--$$
 --v_user_guid;
 --v_gallery_id;

declare

v_user_guid character varying;
p_assetcount numeric;
p_pagenumber numeric;
v_pagination jsonb;
v_count numeric;
v_pgnum numeric;
v_pgsize numeric;
v_itnum numeric;
v_limit smallint;
v_offset smallint;

begin

    select p_json->>'user_guid',
			p_json->>'pgnum',
			p_json->>'pgsize',
			p_json->>'inum'
    into   v_user_guid,
			v_pgnum,
			v_pgsize,
			v_itnum;
	

v_limit := case v_pgnum when 1 then v_pgsize else v_itnum end;
v_offset := case v_pgnum when 1 then 0 else (v_pgsize + (((v_pgnum - 1) * v_itnum) - v_itnum)) end;

	select '{"items":'||json_agg(row_alias)||'}'
	from (select gallery_id as asset_id ,config_json,created_date
		 from labrstg.labrstg_gallery
		 where user_guid=v_user_guid
		 and is_read = 0
		 and status=1 )row_alias
		-- limit v_limit
		--offset v_offset
		 into p_assetjson;
	
	select count(1) into p_assetcount
	from labrstg.labrstg_gallery
    where user_guid=v_user_guid
		 and is_read = 0
		 and status=1
	and user_guid=v_user_guid;

	
	v_pagination:='{"total":'||p_assetcount||',
 				 "current_page":'||coalesce(v_pgnum,0)||'	
				 }';

  p_assetjson:=	jsonb_set(p_assetjson,'{pagination}',v_pagination,true);
	
end;
$_$;


--
