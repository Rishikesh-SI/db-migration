-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_gallery
-- Type: TABLE

-- Name: labmi_v1_gallery; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_gallery (
    gallery_id numeric NOT NULL,
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
    reason_desc text
);


--
