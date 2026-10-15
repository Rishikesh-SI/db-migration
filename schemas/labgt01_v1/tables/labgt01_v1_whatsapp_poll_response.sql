-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_whatsapp_poll_response
-- Type: TABLE

-- Name: labgt01_v1_whatsapp_poll_response; Type: TABLE; Schema: labgt01_v1; Owner: -
--

CREATE TABLE labgt01_v1.labgt01_v1_whatsapp_poll_response (
    whatsapp_poll_response_id numeric NOT NULL,
    poll_id numeric,
    response_option_id numeric,
    mobile_no character varying,
    response_date timestamp without time zone,
    is_flag numeric,
    gratification_seq numeric,
    is_ans numeric,
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
    ans numeric,
    response_count numeric
);


--
