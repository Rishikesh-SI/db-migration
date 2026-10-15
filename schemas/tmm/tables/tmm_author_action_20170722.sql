-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_author_action_20170722
-- Type: TABLE

-- Name: tmm_author_action_20170722; Type: TABLE; Schema: tmm; Owner: -
--

CREATE TABLE tmm.tmm_author_action_20170722 (
    author_action_id numeric,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
