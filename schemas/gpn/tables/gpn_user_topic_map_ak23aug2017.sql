-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_user_topic_map_ak23aug2017
-- Type: TABLE

-- Name: gpn_user_topic_map_ak23aug2017; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_user_topic_map_ak23aug2017 (
    user_topic_map_id numeric,
    user_id numeric,
    topic_id numeric,
    status numeric,
    subscription_arn character varying(100),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
