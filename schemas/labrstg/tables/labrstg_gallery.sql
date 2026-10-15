-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_gallery
-- Type: TABLE

-- Name: labrstg_gallery; Type: TABLE; Schema: labrstg; Owner: -
--

CREATE TABLE labrstg.labrstg_gallery (
    gallery_id numeric NOT NULL,
    gallery_name text NOT NULL,
    gallery_path text NOT NULL,
    gallery_type numeric NOT NULL,
    thumbnail text,
    season_id numeric,
    status numeric,
    gallery_guid character varying(256),
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    user_guid character varying(500),
    image_type numeric,
    is_gif_created numeric,
    gif_frame_path text,
    frame_id numeric,
    reason_desc text,
    is_mail_sent numeric,
    config_json json,
    process_id numeric,
    img_time character varying,
    is_read numeric,
    optype numeric DEFAULT 1
);


--
