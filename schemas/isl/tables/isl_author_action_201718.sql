-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_author_action_201718
-- Type: TABLE

-- Name: isl_author_action_201718; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_author_action_201718 (
    author_action_id numeric,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
