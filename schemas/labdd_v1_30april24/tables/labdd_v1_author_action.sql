-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1_30april24
-- Object: labdd_v1_author_action
-- Type: TABLE

-- Name: labdd_v1_author_action; Type: TABLE; Schema: labdd_v1_30april24; Owner: -
--

CREATE TABLE labdd_v1_30april24.labdd_v1_author_action (
    author_action_id numeric NOT NULL,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
