-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_video_notification_map
-- Type: TABLE

-- Name: isl_video_notification_map; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_video_notification_map (
    video_notification_map_id numeric(38,0) NOT NULL,
    video_id numeric(38,0) NOT NULL,
    notification_json jsonb,
    status numeric(38,0) NOT NULL,
    is_active numeric(38,0) NOT NULL,
    is_deleted numeric(38,0) NOT NULL,
    created_by numeric(38,0) NOT NULL,
    updated_by numeric(38,0) NOT NULL,
    created_date timestamp(6) without time zone,
    updated_date timestamp(6) without time zone
);


--
