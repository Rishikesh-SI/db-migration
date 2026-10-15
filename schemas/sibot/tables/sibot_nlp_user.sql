-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_nlp_user
-- Type: TABLE

-- Name: sibot_nlp_user; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_nlp_user (
    nlp_user_id numeric,
    type character(2),
    user_id numeric,
    application_id numeric,
    image_id text,
    video_id text,
    video_url text,
    created_date timestamp with time zone,
    status numeric
);


--
