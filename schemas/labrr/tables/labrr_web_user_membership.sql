-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_web_user_membership
-- Type: TABLE

-- Name: labrr_web_user_membership; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_web_user_membership (
    user_guid character varying,
    campaign_json jsonb,
    campaign_id numeric,
    is_expiry numeric
);


--
