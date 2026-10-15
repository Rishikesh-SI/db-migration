-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_user_poll_response
-- Type: TABLE

-- Name: labpkl_v1_user_poll_response; Type: TABLE; Schema: labpkl_v1; Owner: -
--

CREATE TABLE labpkl_v1.labpkl_v1_user_poll_response (
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
    is_active numeric
);


--
