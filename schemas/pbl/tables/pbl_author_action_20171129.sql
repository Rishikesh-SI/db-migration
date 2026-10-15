-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: pbl_author_action_20171129
-- Type: TABLE

-- Name: pbl_author_action_20171129; Type: TABLE; Schema: pbl; Owner: -
--

CREATE TABLE pbl.pbl_author_action_20171129 (
    author_action_id numeric,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
