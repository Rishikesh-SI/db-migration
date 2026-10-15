-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_author_action
-- Type: TABLE

-- Name: waf_author_action; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_author_action (
    author_action_id numeric NOT NULL,
    author_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    action_id numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
