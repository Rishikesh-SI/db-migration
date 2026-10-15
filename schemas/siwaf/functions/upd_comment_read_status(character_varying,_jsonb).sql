-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _upd_comment_read_status(character varying, jsonb)
-- Type: FUNCTION

-- Name: _upd_comment_read_status(character varying, jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._upd_comment_read_status(p_schema_prefix character varying, p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $_$

/*
'{
  "comment_id": "883,768"
}';
*/

declare
	
     v_comment_id_arr numeric[];
     
begin
	
     select string_to_array(p_json->>'comment_id',',')::numeric[]
     into v_comment_id_arr;
   	
    	execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_user_asset_reaction
    			set is_read = 1
    			where (user_asset_reaction_id =any(select unnest($1)) or parent_comment_id =any(select unnest($1)))'
    	using v_comment_id_arr;
    	
    	execute 'update '||p_schema_prefix||'.'||p_schema_prefix||'_asset_comment_reaction
    			set is_read = 1
    			where comment_id =any(select unnest($1))'
    	using v_comment_id_arr;
    	
   	p_result := 1;

exception
	when others then
     	p_result := -1;
	
end;

$_$;


--
