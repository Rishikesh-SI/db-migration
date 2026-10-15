-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upstox
-- Object: upstox_author_action
-- Type: TABLE

-- Name: upstox_author_action; Type: TABLE; Schema: upstox; Owner: -
--

CREATE TABLE upstox.upstox_author_action (
    author_action_id numeric NOT NULL,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
