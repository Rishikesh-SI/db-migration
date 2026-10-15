-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_topic_chunk_map
-- Type: TABLE

-- Name: gpn_topic_chunk_map; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_topic_chunk_map (
    topic_chunk_map_id numeric NOT NULL,
    topic_id numeric NOT NULL,
    chunk_id numeric NOT NULL,
    chunk_start_value numeric NOT NULL,
    chunk_end_value numeric NOT NULL,
    status numeric NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
