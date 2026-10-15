-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: labecn_user_activity
-- Type: TABLE

-- Name: labecn_user_activity; Type: TABLE; Schema: labecn; Owner: -
--

CREATE TABLE labecn.labecn_user_activity (
    user_activity_id numeric NOT NULL,
    user_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    activity_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
