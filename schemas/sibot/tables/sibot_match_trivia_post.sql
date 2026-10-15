-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_match_trivia_post
-- Type: TABLE

-- Name: sibot_match_trivia_post; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_match_trivia_post (
    match_trivia_post_id numeric,
    application_id numeric,
    image_url text,
    message_text text,
    file_type text,
    created_date timestamp with time zone,
    created_by text,
    sport_id numeric,
    league_id numeric
);


--
