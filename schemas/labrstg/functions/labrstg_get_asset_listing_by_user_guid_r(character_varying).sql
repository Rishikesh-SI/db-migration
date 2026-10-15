-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_get_asset_listing_by_user_guid_r(character varying)
-- Type: FUNCTION

-- Name: labrstg_get_asset_listing_by_user_guid_r(character varying); Type: FUNCTION; Schema: labrstg; Owner: -
--

CREATE FUNCTION labrstg.labrstg_get_asset_listing_by_user_guid_r(p_user_guid character varying, OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
--do
--$$
 

declare
	
	v_user_id numeric;
	
begin

	
   select '{"items":['||string_agg(web_listing_json::text,'')||']}'
   --select '{"items":'||json_agg(row_alias)||'}'
			from (select 
					asset_list_id,web_listing_json
    from   labrstg.labrstg_asset_list
    where   user_id  = (select user_id
						from labrstg.labrstg_web_user
						where user_guid=p_user_guid))row_alias
    into   p_assetjson;
    --using  v_user_id;
   

    select count(1)
    from   labrstg.labrstg_asset_list sl
    where  sl.user_id  =(select user_id
						from labrstg.labrstg_web_user
						where user_guid=p_user_guid)
		 
	into p_assetcount;
	--using  v_user_id;
    
		 
 if p_assetjson is null then 
 p_assetjson:='{"items":null}';
 --raise notice '%',p_assetcount;
 --select 1/0;
 end if;
 
 
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';
		  */
 
end;
$_$;


--
