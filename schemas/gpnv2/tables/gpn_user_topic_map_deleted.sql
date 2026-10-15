-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_user_topic_map_deleted
-- Type: TABLE

-- Name: gpn_user_topic_map_deleted; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_user_topic_map_deleted (
    user_topic_map_id numeric,
    user_id numeric,
    application_id numeric,
    topic_id numeric,
    subscription_arn text,
    status numeric,
    created_date timestamp without time zone
);


--
