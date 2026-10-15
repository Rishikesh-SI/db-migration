-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_topic_delete_log
-- Type: TABLE

-- Name: gpn_topic_delete_log; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_topic_delete_log (
    topic_id numeric[],
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
