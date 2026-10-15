-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_video_upload_04122024
-- Type: TABLE

-- Name: labdd_v1_video_upload_04122024; Type: TABLE; Schema: labdd_v1; Owner: -
--

CREATE TABLE labdd_v1.labdd_v1_video_upload_04122024 (
    video_upload_id numeric,
    asset_type_id numeric,
    videotype numeric,
    fullpath character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    published_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    asset_guid character varying(256),
    video_json jsonb
);


--
