-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_author_action
-- Type: TABLE

-- Name: u17wc_author_action; Type: TABLE; Schema: u17wc; Owner: -
--

CREATE TABLE u17wc.u17wc_author_action (
    author_action_id numeric NOT NULL,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
