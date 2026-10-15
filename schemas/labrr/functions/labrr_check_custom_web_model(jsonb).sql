-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_check_custom_web_model(jsonb)
-- Type: FUNCTION

-- Name: labrr_check_custom_web_model(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_check_custom_web_model(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_module_name CHARACTER VARYING;
    v_user_guid CHARACTER VARYING;
BEGIN
    
    SELECT p_json->>'module',
           p_json->>'user_guid'
		   
    INTO v_module_name,
         v_user_guid;

    -- Check if the module is 'sunil-chettri-campaign'
-- IF lower(v_module_name) in ('ipl_2025_contest_1','send_a_wish_2','alan_walker_ticket_contest','send_a_wish_3',
-- 							'ipl_2025_contest_2','send_a_wish_4','sign_up_matchday_jersey','send_a_wish_5','send_a_wish_6'
-- 						   ,'lucky_draw_1','sign_up_matchday_jersey_hindi')THEN
        IF NOT EXISTS (
            SELECT 1
            FROM labrr.labrr_custom_web_json
            WHERE user_guid = v_user_guid
            AND LOWER(module_name) = lower(v_module_name)
        ) THEN
            p_data := '{
                "data": {
                    "status": "1",
                    "message": "Form not submitted"
                }
            }';
        ELSE
            p_data := '{
                "data": {
                    "status": "0",
                    "message": "Form Already Submitted"
                }
            }';
        END IF;

-- ELSE
--             p_data := '{
--                 "data": {
--                     "status": "0",
--                     "message": "unsucessfull"
--                 }
--             }';

--     END IF;

END;
$$;


--
