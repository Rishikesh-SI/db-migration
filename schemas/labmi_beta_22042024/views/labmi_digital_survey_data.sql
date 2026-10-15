-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_digital_survey_data
-- Type: VIEW

-- Name: labmi_digital_survey_data; Type: VIEW; Schema: labmi_beta_22042024; Owner: -
--

CREATE VIEW labmi_beta_22042024.labmi_digital_survey_data AS
 SELECT (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'contests_and_polls'::text) AS contests_and_polls,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'reason_for_supporting_mi'::text) AS reason_for_supporting_mi,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'twitter_rank'::text) AS twitter_rank,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'mobile_rank'::text) AS mobile_rank,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'preferred_duration_of_MITV_video'::text) AS preferred_duration_of_mitv_video,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'first_choice_of_live_match_updates'::text) AS first_choice_of_live_match_updates,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'age_bracket'::text) AS age_bracket,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'city'::text) AS city,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'scale'::text) AS scale,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'facebookGroup_rank'::text) AS facebookgroup_rank,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'most_engaging_app_feature'::text) AS most_engaging_app_feature,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'purchased_any_merchandise'::text) AS purchased_any_merchandise,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'snapchat_rank'::text) AS snapchat_rank,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'mi_social_visit_frequency'::text) AS mi_social_visit_frequency,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'youtube_rank'::text) AS youtube_rank,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'most_engaging_section'::text) AS most_engaging_section,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'facebook_rank'::text) AS facebook_rank,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'website_rank'::text) AS website_rank,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'favourite_player'::text) AS favourite_player,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'instagram_rank'::text) AS instagram_rank,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'gender'::text) AS gender,
    (((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) ->> 'mi_visit_frequency'::text) AS mi_visit_frequency,
    ((((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) -> 'type_of_videos_enjoy_watching'::text) ->> 0) AS type_of_videos_enjoy_watching,
    ((((labmi_client_web_cust_model.client_mod_json -> 'data'::text) -> 'user_data'::text) -> 'type_of_content'::text) ->> 0) AS type_of_content
   FROM labmi_beta_22042024.labmi_client_web_cust_model
  WHERE (labmi_client_web_cust_model.module_name = 'Digital Survey'::text);


--
