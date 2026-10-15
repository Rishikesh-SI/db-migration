-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: labkxp_author_action
-- Type: TABLE

-- Name: labkxp_author_action; Type: TABLE; Schema: labkxp1; Owner: -
--

CREATE TABLE labkxp1.labkxp_author_action (
    author_action_id numeric NOT NULL,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
