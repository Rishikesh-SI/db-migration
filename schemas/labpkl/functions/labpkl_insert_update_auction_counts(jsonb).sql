-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_insert_update_auction_counts(jsonb)
-- Type: FUNCTION

-- Name: labpkl_insert_update_auction_counts(jsonb); Type: FUNCTION; Schema: labpkl; Owner: -
--

CREATE FUNCTION labpkl.labpkl_insert_update_auction_counts(p_json jsonb, OUT p_result numeric, OUT v_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare 
v_asset_id character varying;

/*

{
  "asset_id": "s1-q1-123456:0"
}

*/

begin 

select p_json->>'asset_id'
	into
	v_asset_id;
	
if v_asset_id is not null then

if exists (select asset_id from labpkl.labpkl_auction_count where asset_id=v_asset_id) then
	update labpkl.labpkl_auction_count
	set count=count+1
	where asset_id=v_asset_id;
	
	  select '{ "results": '||json_agg(row_alias)||'}'
	   from (select asset_id , count from labpkl.labpkl_auction_count
			where asset_id=v_asset_id) 
	   row_alias 
	   into v_json ;

	
	else if not exists (select asset_id from labpkl.labpkl_auction_count where asset_id=v_asset_id) then
		insert into labpkl.labpkl_auction_count(auction_count_id,asset_id,count)
		VALUES (nextval('labpkl.seq_labpkl_auction_count_id'),v_asset_id,1);
		
		 select '{ "results": '||json_agg(row_alias)||'}'
	   from (select asset_id , count from labpkl.labpkl_auction_count
			where asset_id=v_asset_id) 
	   row_alias 
	   into v_json;
		
	end if;
	end if;
end if;		

p_result:=1;

	end;
$$;


--
