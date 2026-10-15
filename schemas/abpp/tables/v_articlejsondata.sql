-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: v_articlejsondata
-- Type: TABLE

-- Name: v_articlejsondata; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.v_articlejsondata (
    article_id numeric,
    title character varying(4000),
    article_guid character varying(256),
    status character varying(256),
    entity_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    version_number numeric
);


--
