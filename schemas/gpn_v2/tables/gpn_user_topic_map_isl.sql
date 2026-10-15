-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_user_topic_map_isl
-- Type: TABLE

-- Name: gpn_user_topic_map_isl; Type: TABLE; Schema: gpn_v2; Owner: -
--

CREATE TABLE gpn_v2.gpn_user_topic_map_isl (
    user_topic_map_id numeric,
    user_id numeric,
    application_id numeric,
    topic_id numeric,
    applied_user_policy text,
    subscription_arn text,
    endpoint text,
    status numeric,
    new_user_policy text,
    failed_attempts numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
