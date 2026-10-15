-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_author_action_20171027
-- Type: TABLE

-- Name: tcs_author_action_20171027; Type: TABLE; Schema: tcs; Owner: -
--

CREATE TABLE tcs.tcs_author_action_20171027 (
    author_action_id numeric,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
