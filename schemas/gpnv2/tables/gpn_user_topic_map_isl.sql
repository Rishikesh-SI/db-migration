-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_user_topic_map_isl
-- Type: TABLE

-- Name: gpn_user_topic_map_isl; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_user_topic_map_isl (
    user_topic_map_id numeric NOT NULL,
    user_id numeric NOT NULL,
    application_id numeric NOT NULL,
    topic_id numeric NOT NULL,
    subscription_arn text,
    status numeric DEFAULT 0 NOT NULL,
    created_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL,
    updated_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL,
    endpoint_arn text
);


--
