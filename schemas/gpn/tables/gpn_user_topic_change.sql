-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_user_topic_change
-- Type: TABLE

-- Name: gpn_user_topic_change; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_user_topic_change (
    user_topic_change_id numeric NOT NULL,
    user_id numeric NOT NULL,
    topic_id numeric NOT NULL,
    option numeric NOT NULL,
    subscription_arn character varying(100) NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
