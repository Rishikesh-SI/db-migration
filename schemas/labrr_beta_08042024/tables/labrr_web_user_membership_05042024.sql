-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_web_user_membership_05042024
-- Type: TABLE

-- Name: labrr_web_user_membership_05042024; Type: TABLE; Schema: labrr_beta_08042024; Owner: -
--

CREATE TABLE labrr_beta_08042024.labrr_web_user_membership_05042024 (
    web_user_membership_id numeric,
    user_guid character varying,
    campaign_json jsonb,
    campaign_ids integer[]
);


--
