-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: labkkr_user_poll_response
-- Type: TABLE

-- Name: labkkr_user_poll_response; Type: TABLE; Schema: labkkr_30012024; Owner: -
--

CREATE TABLE labkkr_30012024.labkkr_user_poll_response (
    user_poll_response_id numeric NOT NULL,
    poll_id numeric,
    response_option_id numeric,
    user_id numeric,
    response_date timestamp without time zone,
    is_flag numeric,
    gratification_seq numeric,
    player_rating numeric,
    score numeric,
    player_id numeric,
    wickets numeric,
    image_path character varying,
    video_path character varying,
    extra character varying,
    coins numeric,
    total_coins numeric,
    is_active numeric,
    ans numeric
);


--
