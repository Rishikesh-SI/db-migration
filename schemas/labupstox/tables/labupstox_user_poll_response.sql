-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_user_poll_response
-- Type: TABLE

-- Name: labupstox_user_poll_response; Type: TABLE; Schema: labupstox; Owner: -
--

CREATE TABLE labupstox.labupstox_user_poll_response (
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
    image_path character varying(1000),
    video_path character varying(1000),
    extra character varying(1000),
    coins numeric,
    total_coins numeric,
    is_active numeric,
    email_id character varying(500),
    person_name character varying(500),
    mobile_no character varying(500),
    country_code numeric
);


--
