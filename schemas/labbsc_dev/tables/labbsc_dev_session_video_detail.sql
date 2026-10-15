-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_session_video_detail
-- Type: TABLE

-- Name: labbsc_dev_session_video_detail; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_session_video_detail (
    session_video_detail_id numeric NOT NULL,
    session_id numeric,
    user_id numeric,
    counseller_id numeric,
    video_id numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone
);


--
