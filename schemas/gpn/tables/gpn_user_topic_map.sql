-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_user_topic_map
-- Type: TABLE

-- Name: gpn_user_topic_map; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_user_topic_map (
    user_topic_map_id numeric NOT NULL,
    user_id numeric NOT NULL,
    topic_id numeric NOT NULL,
    status numeric NOT NULL,
    subscription_arn character varying(100),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
