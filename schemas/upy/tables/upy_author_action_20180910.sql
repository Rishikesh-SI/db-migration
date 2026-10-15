-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_author_action_20180910
-- Type: TABLE

-- Name: upy_author_action_20180910; Type: TABLE; Schema: upy; Owner: -
--

CREATE TABLE upy.upy_author_action_20180910 (
    author_action_id numeric,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
