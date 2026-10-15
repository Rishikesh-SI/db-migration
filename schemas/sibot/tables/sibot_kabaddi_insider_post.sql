-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_kabaddi_insider_post
-- Type: TABLE

-- Name: sibot_kabaddi_insider_post; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_kabaddi_insider_post (
    sibot_kabaddi_insider_post_id numeric,
    image_url text,
    video_url text,
    message_text text,
    created_date timestamp with time zone,
    created_by text
);


--
