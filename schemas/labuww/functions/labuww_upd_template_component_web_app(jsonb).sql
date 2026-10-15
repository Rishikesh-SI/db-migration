-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_upd_template_component_web_app(jsonb)
-- Type: FUNCTION

-- Name: labuww_upd_template_component_web_app(jsonb); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_upd_template_component_web_app(p_webjson jsonb, OUT p_result jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

v_selector_id text;
v_show_in_web boolean;
v_show_in_app boolean;
v_show_in_mweb boolean;
v_field_arena_id text;

begin

select p_webjson-> 'inputjson' ->> 'selector_id',
		   p_webjson-> 'inputjson' ->> 'show_in_web',
			p_webjson-> 'inputjson' ->> 'show_in_app',
			p_webjson-> 'inputjson' ->> 'show_in_mweb',
			p_webjson-> 'inputjson' ->> 'field_arena_id'
	into v_selector_id,
		 v_show_in_web,
		 v_show_in_app,
		 v_show_in_mweb,
		 v_field_arena_id;

IF EXISTS (
    SELECT 1 FROM labuww.labuww_template_component_map
    WHERE tcmap_guid = v_selector_id
) THEN

    -- Determine value for show_podium_web
    IF v_field_arena_id IS NULL OR trim(v_field_arena_id) = '' OR v_show_in_web <> 'true' THEN
        -- Set show_podium_web to false
        UPDATE labuww.labuww_template_component_map
        SET meta_info = jsonb_set(
                jsonb_set(
                    meta_info::jsonb,
                    '{api_config,FIELD_ARENA_ID}',
                    to_jsonb(v_field_arena_id::text)
                ),
                '{show_podium_web}',
                'false'::jsonb
            )
        WHERE tcmap_guid = v_selector_id;

    ELSE
        -- Leave show_podium_web as-is or keep it true
        UPDATE labuww.labuww_template_component_map
        SET meta_info = jsonb_set(
                meta_info::jsonb,
                '{api_config,FIELD_ARENA_ID}',
                to_jsonb(v_field_arena_id::text)
            )
        WHERE tcmap_guid = v_selector_id;
    END IF;

   
    p_result := '{
        "status": 1
    }';

ELSE
   
    p_result := '{
        "status": 0
    }';
END IF;

end;
$$;


--
