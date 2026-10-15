-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_author_action
-- Type: TABLE

-- Name: swa_author_action; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_author_action (
    author_action_id numeric NOT NULL,
    author_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    action_id numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
