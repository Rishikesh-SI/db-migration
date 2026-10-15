-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_topic
-- Type: TABLE

-- Name: swa_topic; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_topic (
    topic_id numeric NOT NULL,
    sport_id numeric NOT NULL,
    sport_name character varying(256) NOT NULL,
    edition character varying(256),
    edition_name character varying(256),
    match_id character varying(300),
    match_name character varying(500),
    channel_type character varying(300),
    channel_id numeric,
    channel_name character varying(300),
    channel_desc character varying(1000),
    handle_value character varying(1000),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    topic_guid character varying(256) NOT NULL,
    is_trashed numeric,
    published_version_number numeric,
    published_date timestamp without time zone,
    content_source_id numeric,
    title_alias character varying(500),
    slug_url character varying(4000),
    checked_out_by numeric,
    checked_out_date timestamp without time zone
);


--
