-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_user_poll_response_man_off_the_matchbk
-- Type: TABLE

-- Name: labstmp_user_poll_response_man_off_the_matchbk; Type: TABLE; Schema: labstmp; Owner: -
--

CREATE TABLE labstmp.labstmp_user_poll_response_man_off_the_matchbk (
    user_poll_response_id numeric,
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
    total_coins numeric
);


--
