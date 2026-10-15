-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1_bkp
-- Object: labmi_v1_user_poll_response
-- Type: TABLE

-- Name: labmi_v1_user_poll_response; Type: TABLE; Schema: labmi_v1_bkp; Owner: -
--

CREATE TABLE labmi_v1_bkp.labmi_v1_user_poll_response (
    user_poll_response_id numeric NOT NULL,
    poll_id numeric,
    response_option_id numeric,
    user_id numeric,
    response_date timestamp without time zone,
    is_flag numeric,
    gratification_seq numeric,
    is_ans numeric,
    player_rating numeric,
    ans numeric,
    score numeric,
    player_id numeric,
    wickets numeric,
    image_path character varying,
    video_path character varying,
    extra character varying,
    coins numeric,
    total_coins numeric,
    is_active numeric
);


--
