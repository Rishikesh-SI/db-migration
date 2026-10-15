-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_get_auction_r(jsonb)
-- Type: FUNCTION

-- Name: labpkl_v1_get_auction_r(jsonb); Type: FUNCTION; Schema: labpkl_v1; Owner: -
--

CREATE FUNCTION labpkl_v1.labpkl_v1_get_auction_r(p_json jsonb, OUT v_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare 
v_asset_id character varying;

begin 

select p_json->>'asset_id'
	into
	v_asset_id;
	

 if v_asset_id is not null and v_asset_id!=''  then
 	 select '{ "results": '||json_agg(row_alias)||'}'
	   from (select asset_id , count from labpkl_v1.labpkl_v1_auction_count
			where asset_id=v_asset_id)
	   row_alias 
	   into v_json ;
 
 else if v_asset_id is null or v_asset_id='' then
 	 select '{ "results": '||json_agg(row_alias)||'}'
	   from (select count,asset_id from labpkl_v1.labpkl_v1_auction_count)
	   row_alias
	into v_json ;
 	end if;
	end if;
	
p_result:=1;

	end;
$$;


--
