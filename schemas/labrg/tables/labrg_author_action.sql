-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: labrg_author_action
-- Type: TABLE

-- Name: labrg_author_action; Type: TABLE; Schema: labrg; Owner: -
--

CREATE TABLE labrg.labrg_author_action (
    author_action_id numeric NOT NULL,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
