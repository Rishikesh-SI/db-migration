-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_session_video_detail
-- Type: TABLE

-- Name: labbsc_session_video_detail; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_session_video_detail (
    session_video_detail_id numeric NOT NULL,
    session_id numeric,
    user_id numeric,
    counseller_id numeric,
    video_id numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone
);


--
