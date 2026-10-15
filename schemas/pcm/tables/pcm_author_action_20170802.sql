-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_author_action_20170802
-- Type: TABLE

-- Name: pcm_author_action_20170802; Type: TABLE; Schema: pcm; Owner: -
--

CREATE TABLE pcm.pcm_author_action_20170802 (
    author_action_id numeric,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
