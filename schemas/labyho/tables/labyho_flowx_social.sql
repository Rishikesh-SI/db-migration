-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_flowx_social
-- Type: TABLE

-- Name: labyho_flowx_social; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_flowx_social (
    flowx_social_id numeric,
    id numeric,
    likes_cnt numeric,
    publisher character varying(1000),
    reference text,
    retweetcount numeric,
    text_desc text,
    orignal_post jsonb,
    profile_images text,
    user_desc text,
    user_id text,
    user_verified text,
    screen_name text,
    user_name text,
    reply jsonb,
    creation_date text,
    created_date timestamp without time zone,
    hashtags jsonb,
    mentions jsonb,
    targetmedia jsonb,
    links jsonb,
    flowx_json jsonb,
    source_object_id text
);


--
