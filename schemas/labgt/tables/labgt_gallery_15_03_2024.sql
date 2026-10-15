-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_gallery_15_03_2024
-- Type: TABLE

-- Name: labgt_gallery_15_03_2024; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_gallery_15_03_2024 (
    gallery_id numeric,
    gallery_name text,
    gallery_path text,
    gallery_type numeric,
    thumbnail text,
    season_id numeric,
    status numeric,
    gallery_guid character varying(256),
    is_active numeric,
    is_deleted numeric,
    created_by numeric,
    updated_by numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
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
    optype numeric,
    user_info jsonb,
    comment character varying,
    is_fav_comment numeric,
    additional_info jsonb
);


--
