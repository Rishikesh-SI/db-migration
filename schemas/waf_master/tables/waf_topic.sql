-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_topic
-- Type: TABLE

-- Name: waf_topic; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_topic (
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
    slug_url character varying(4000)
);


--
