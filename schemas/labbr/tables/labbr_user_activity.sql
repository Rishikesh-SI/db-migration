-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_user_activity
-- Type: TABLE

-- Name: labbr_user_activity; Type: TABLE; Schema: labbr; Owner: -
--

CREATE TABLE labbr.labbr_user_activity (
    user_activity_id numeric NOT NULL,
    user_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    activity_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
