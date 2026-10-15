-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_video_upload
-- Type: TABLE

-- Name: labgt_video_upload; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_video_upload (
    video_upload_id numeric NOT NULL,
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
