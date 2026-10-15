-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: lablsg_topic
-- Type: TABLE

-- Name: lablsg_topic; Type: TABLE; Schema: lablsg; Owner: -
--

CREATE TABLE lablsg.lablsg_topic (
    topic_id numeric NOT NULL,
    sport_id numeric,
    sport_name character varying(256),
    edition character varying(256),
    edition_name character varying(256),
    match_id character varying(300),
    match_name character varying(500),
    channel_type character varying(300),
    channel_id numeric,
    channel_name character varying(300),
    channel_desc character varying(1000),
    handle_value character varying(1000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    topic_guid character varying(256),
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
