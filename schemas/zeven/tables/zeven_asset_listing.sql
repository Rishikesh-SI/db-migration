-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_asset_listing
-- Type: TABLE

-- Name: zeven_asset_listing; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_asset_listing (
    id numeric,
    created_date timestamp without time zone,
    asset_type_id numeric,
    entity_role_id numeric,
    ordering numeric,
    slug_title character varying(4000),
    slug_url character varying(4000),
    title character varying(1000),
    alias character varying(510),
    descriptiontext text,
    fulltext text,
    modifieddate timestamp without time zone,
    extra_fields text,
    catid numeric,
    short_headline character varying(2000),
    showinapp numeric,
    content_source character varying(500),
    duration character varying(30),
    small_thumb character varying(4000),
    medium_thumb character varying(4000),
    big_thumb character varying(4000),
    ssid character varying(4000),
    video_type numeric,
    youtube_url character varying(4000),
    is_published numeric,
    is_deleted numeric,
    table_name character varying(20),
    si_client_id numeric
);


--
