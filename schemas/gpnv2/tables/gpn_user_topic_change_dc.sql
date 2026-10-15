-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_user_topic_change_dc
-- Type: TABLE

-- Name: gpn_user_topic_change_dc; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_user_topic_change_dc (
    user_topic_change_id numeric NOT NULL,
    user_id numeric NOT NULL,
    application_id numeric NOT NULL,
    topic_id numeric NOT NULL,
    subscription_arn text,
    user_topic_map_id numeric NOT NULL,
    is_success numeric DEFAULT 0 NOT NULL,
    created_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL,
    updated_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL,
    endpoint_arn text
);


--
