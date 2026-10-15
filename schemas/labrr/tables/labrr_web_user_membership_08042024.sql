-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_web_user_membership_08042024
-- Type: TABLE

-- Name: labrr_web_user_membership_08042024; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_web_user_membership_08042024 (
    web_user_membership_id numeric,
    user_guid character varying,
    campaign_json jsonb,
    campaign_ids integer[]
);


--
