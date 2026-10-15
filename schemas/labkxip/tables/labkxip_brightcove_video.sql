-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_brightcove_video
-- Type: TABLE

-- Name: labkxip_brightcove_video; Type: TABLE; Schema: labkxip; Owner: -
--

CREATE TABLE labkxip.labkxip_brightcove_video (
    id bigint NOT NULL,
    brightcove_video_id character varying(64) NOT NULL,
    title text,
    original_filename text,
    duration numeric(12,3),
    thumbnail_url text,
    poster_url text,
    s3_path text,
    brightcove_created_at timestamp with time zone,
    brightcove_updated_at timestamp with time zone,
    sync_status character varying(32) DEFAULT 'pending'::character varying,
    last_synced_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
