-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_get_custom_web_model_r(jsonb)
-- Type: FUNCTION

-- Name: labgt_get_custom_web_model_r(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_get_custom_web_model_r(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

DECLARE
    v_user_guid   TEXT;
    v_module_name TEXT;

BEGIN

    v_module_name := lower(p_json->>'module_name');
    v_user_guid   := p_json->>'user_guid';

    ------------------------------------------------------------------
    -- 🔵 MODULE 1 : titans_fifer_lsg_vs_gt
    ------------------------------------------------------------------
    IF v_module_name = 'titans_fifer_lsg_vs_gt' THEN

        IF NOT EXISTS (
            SELECT 1
            FROM labgt.labgt_titans_fifer_2026
            WHERE user_guid = v_user_guid
              AND lower(module_name) = 'titans_fifer_lsg_vs_gt'
        ) THEN

            p_data := jsonb_build_object(
                'data', jsonb_build_object(
                    'status','1',
                    'message','Not Exists'
                )
            );

        ELSE

            p_data := jsonb_build_object(
                'data',
                jsonb_build_object(
                    'status', '1',
                    'module', 'titans_fifer_lsg_vs_gt',
                    'user_guid', v_user_guid,
                    'scenarios',
                    (
                        SELECT jsonb_agg(
                            jsonb_build_object(
                                'scenario_id', t.scenario_id,
                                'scenario_text', t.scenario_text,
                                'position', t.scenario_position
                            )
                            ORDER BY t.scenario_position
                        )
                        FROM labgt.labgt_titans_fifer_2026 t
                        WHERE t.user_guid = v_user_guid
                        AND lower(t.module_name) = 'titans_fifer_lsg_vs_gt'
                        AND t.created_at = (
                            SELECT MAX(created_at)
                            FROM labgt.labgt_titans_fifer_2026
                            WHERE user_guid = v_user_guid
                            AND lower(module_name) = 'titans_fifer_lsg_vs_gt'
                        )
                    )
                )
            );

        END IF;

        RETURN;

    ------------------------------------------------------------------
    -- 🟢 MODULE 2 : titans_fifer_gt_vs_rr
    ------------------------------------------------------------------
    ELSIF v_module_name = 'titans_fifer_gt_vs_rr' THEN

        IF NOT EXISTS (
            SELECT 1
            FROM labgt.labgt_titans_fifer_2026
            WHERE user_guid = v_user_guid
              AND lower(module_name) = 'titans_fifer_gt_vs_rr'
        ) THEN

            p_data := jsonb_build_object(
                'data', jsonb_build_object(
                    'status','1',
                    'message','Not Exists'
                )
            );

        ELSE

            p_data := jsonb_build_object(
                'data',
                jsonb_build_object(
                    'status', '1',
                    'module', 'titans_fifer_gt_vs_rr',
                    'user_guid', v_user_guid,
                    'scenarios',
                    (
                        SELECT jsonb_agg(
                            jsonb_build_object(
                                'scenario_id', t.scenario_id,
                                'scenario_text', t.scenario_text,
                                'position', t.scenario_position
                            )
                            ORDER BY t.scenario_position
                        )
                        FROM labgt.labgt_titans_fifer_2026 t
                        WHERE t.user_guid = v_user_guid
                        AND lower(t.module_name) = 'titans_fifer_gt_vs_rr'
                        AND t.created_at = (
                            SELECT MAX(created_at)
                            FROM labgt.labgt_titans_fifer_2026
                            WHERE user_guid = v_user_guid
                            AND lower(module_name) = 'titans_fifer_gt_vs_rr'
                        )
                    )
                )
            );

        END IF;

        RETURN;

    ------------------------------------------------------------------
    -- 🟡 OTHER MODULES (UNCHANGED)
    ------------------------------------------------------------------
    ELSIF v_module_name <> 'auction_activation_2026' THEN
        
        IF EXISTS (
            SELECT 1
            FROM labgt.labgt_custom_web_json
            WHERE user_guid = v_user_guid
              AND lower(module_name) = v_module_name
        ) THEN
            
            p_data := jsonb_build_object(
                'data', jsonb_build_object(
                    'status','1',
                    'message','Already Exists'
                )
            );

        ELSE

            p_data := jsonb_build_object(
                'data', jsonb_build_object(
                    'status','1',
                    'message','Not Exists'
                )
            );
        END IF;

        RETURN;

    ------------------------------------------------------------------
    -- 🟣 AUCTION MODULE (UNCHANGED)
    ------------------------------------------------------------------
    ELSIF v_module_name = 'auction_activation_2026' THEN

        IF NOT EXISTS (
            SELECT 1
            FROM labgt.labgt_custom_web_json
            WHERE user_guid = v_user_guid
              AND lower(module_name) = 'auction_activation_2026'
        ) THEN

            p_data := jsonb_build_object(
                'data', jsonb_build_object(
                    'status','1',
                    'message','Not Exists'
                )
            );

            RETURN;
        END IF;

        p_data :=
            jsonb_build_object(
                'data',
                jsonb_build_object(
                    'status', '1',
                    'module', 'auction_activation_2026',
                    'user_guid', v_user_guid,
                    'scenarios',
                    (
                        SELECT jsonb_agg(
                            jsonb_build_object(
                                'scenario_id_' || rn, scenario_id,
                                'scenario_'   || rn, scenario_text,
                                'scenario_'   || rn || '_position', scenario_position
                            )
                        )
                        FROM (
                            SELECT 
                                scenario_id,
                                scenario_text,
                                scenario_position,
                                ROW_NUMBER() OVER (ORDER BY id) AS rn
                            FROM labgt.labgt_auction_activation_2026
                            WHERE user_guid = v_user_guid
                        ) x
                    )
                )
            );

        RETURN;

    END IF;

END;
$$;


--
