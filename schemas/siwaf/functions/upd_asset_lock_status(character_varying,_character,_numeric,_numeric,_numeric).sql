-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _upd_asset_lock_status(character varying, character, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: _upd_asset_lock_status(character varying, character, numeric, numeric, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._upd_asset_lock_status(p_schema_prefix character varying, p_option character, p_asset_id numeric, p_asset_type_id numeric, p_user_id numeric, OUT p_lock_status numeric, OUT p_locked_by_user_id numeric, OUT p_locked_by_user_name character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$ 

declare
	
	v_user_id numeric := coalesce(p_user_id,0);
	v_sysdate timestamp := current_timestamp at time zone 'utc';
	
begin
	
	if p_option = 'U' then
		execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list
				set checked_out_by = '||case v_user_id when 0 then null else v_user_id end||'
					checked_out_date = '''||v_sysdate||'''
				where asset_id = '||p_asset_id||'
				and asset_type_id = '||p_asset_type_id;
    	end if;
    
    	execute 'select case checked_out_by when null then 0 else 1 end, checked_out_by, display_name user_name
			from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list
			left join '||p_schema_prefix||'.'||p_schema_prefix||'_user
			on user_id = checked_out_by
			where asset_id = '||p_asset_id||'
			and asset_type_id = '||p_asset_type_id
	into p_lock_status, p_locked_by_user_id, p_locked_by_user_name;
	
end;

$$;


--
