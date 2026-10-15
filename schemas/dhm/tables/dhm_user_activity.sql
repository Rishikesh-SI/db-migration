-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_user_activity
-- Type: TABLE

-- Name: dhm_user_activity; Type: TABLE; Schema: dhm; Owner: -
--

CREATE TABLE dhm.dhm_user_activity (
    user_activity_id numeric NOT NULL,
    user_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    activity_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
