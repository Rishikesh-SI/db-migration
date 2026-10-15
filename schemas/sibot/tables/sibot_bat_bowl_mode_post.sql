-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_bat_bowl_mode_post
-- Type: TABLE

-- Name: sibot_bat_bowl_mode_post; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_bat_bowl_mode_post (
    bat_bowl_mode_post_id numeric,
    url text,
    message_text text,
    file_type text,
    opt_type text,
    created_date timestamp with time zone,
    created_by text
);


--
