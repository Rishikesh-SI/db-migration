-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _is_asset_alias_exists(character varying, numeric, character varying)
-- Type: FUNCTION

-- Name: _is_asset_alias_exists(character varying, numeric, character varying); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._is_asset_alias_exists(p_schema_prefix character varying, p_asset_id numeric, p_asset_alias character varying, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_asset_filter_query character varying(30) := ' ';
     v_asset_count numeric;
     v_asset_alias text := upper(p_asset_alias);
     
begin
	
	if p_asset_id is not null then
		v_asset_filter_query := ' and asset_id <> '||p_asset_id;    
     end if;
     
     execute 'select count(1)
			from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list
			where upper(title_alias) = '''||v_asset_alias||''''
			||v_asset_filter_query
	into v_asset_count;
	
     if v_asset_count > 0 then
		p_result := 1;
	else
		p_result := 0;
	end if;
     
exception
	when others then
		p_result := -1;

end;

$$;


--
