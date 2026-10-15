-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: tmm_author_action_20170721
-- Type: TABLE

-- Name: tmm_author_action_20170721; Type: TABLE; Schema: dhm; Owner: -
--

CREATE TABLE dhm.tmm_author_action_20170721 (
    author_action_id numeric,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
