-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_menu_action(character varying)
-- Type: FUNCTION

-- Name: _get_menu_action(character varying); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_menu_action(p_schema_prefix character varying, OUT p_out_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

DECLARE
err_msg text;
BEGIN


                      

select ('{"menu":'||jsonb_agg(
    json_build_object('menu_id',t.user_menu_id,'menu_name',t.menu_name,'parent_id',coalesce(t.parent_id,0),
					  'module_flag',module_flag
                      ,'actions',(select json_agg(to_jsonb(tab)) from (
select 
																													
action_name,
menu_action_id  as action_id,'0' as is_active,module_flag
from siwaf.siwaf_menu_action
where t.user_menu_id=any(parent_id)) tab)
                     ))::text||'}')::jsonb 
into p_out_json
from siwaf.siwaf_user_menu t;
--where parent_id IS NULL;

end ;

$$;


--
