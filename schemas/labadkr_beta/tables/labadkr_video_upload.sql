-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr_beta
-- Object: labadkr_video_upload
-- Type: TABLE

-- Name: labadkr_video_upload; Type: TABLE; Schema: labadkr_beta; Owner: -
--

CREATE TABLE labadkr_beta.labadkr_video_upload (
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
