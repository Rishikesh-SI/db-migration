-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_advertisement_20181026
-- Type: TABLE

-- Name: tsk_advertisement_20181026; Type: TABLE; Schema: tsk; Owner: -
--

CREATE TABLE tsk.tsk_advertisement_20181026 (
    ad_id numeric,
    ad_title text,
    ad_code text,
    ad_position numeric,
    is_published numeric,
    is_trashed numeric,
    published_version_number numeric,
    published_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    created_by numeric,
    updated_by numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    ad_guid character varying(256),
    is_default numeric,
    ad_client numeric[],
    is_detail numeric
);


--
