-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: v_topicjsondata
-- Type: TABLE

-- Name: v_topicjsondata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.v_topicjsondata (
    topic_id numeric,
    title_alias character varying(4000),
    topic_guid character varying(256),
    status character varying(256),
    entity_id numeric,
    created_date timestamp without time zone,
    modified_date timestamp without time zone,
    version_number numeric
);


--
