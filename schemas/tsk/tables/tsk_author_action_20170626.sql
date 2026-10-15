-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_author_action_20170626
-- Type: TABLE

-- Name: tsk_author_action_20170626; Type: TABLE; Schema: tsk; Owner: -
--

CREATE TABLE tsk.tsk_author_action_20170626 (
    author_action_id numeric,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
