-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ppb_author_action
-- Type: TABLE

-- Name: ppb_author_action; Type: TABLE; Schema: ppb; Owner: -
--

CREATE TABLE ppb.ppb_author_action (
    author_action_id numeric NOT NULL,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
