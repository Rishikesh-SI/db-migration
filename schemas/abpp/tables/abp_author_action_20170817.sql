-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_author_action_20170817
-- Type: TABLE

-- Name: abp_author_action_20170817; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_author_action_20170817 (
    author_action_id numeric,
    author_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    action_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
