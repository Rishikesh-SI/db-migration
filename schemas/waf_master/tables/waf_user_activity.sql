-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_user_activity
-- Type: TABLE

-- Name: waf_user_activity; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_user_activity (
    user_activity_id numeric NOT NULL,
    user_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    activity_id numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
