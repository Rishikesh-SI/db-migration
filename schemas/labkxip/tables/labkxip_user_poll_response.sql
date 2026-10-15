-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_user_poll_response
-- Type: TABLE

-- Name: labkxip_user_poll_response; Type: TABLE; Schema: labkxip; Owner: -
--

CREATE TABLE labkxip.labkxip_user_poll_response (
    user_poll_response_id numeric NOT NULL,
    poll_id numeric,
    response_option_id numeric,
    user_id numeric,
    response_date timestamp without time zone,
    player_rating numeric,
    score numeric,
    player_id numeric,
    wickets numeric,
    image_path character varying(1000),
    video_path character varying(1000),
    extra character varying(1000),
    ans numeric
);


--
