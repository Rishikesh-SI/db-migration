-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_user_activity
-- Type: TABLE

-- Name: labw88_user_activity; Type: TABLE; Schema: labw88; Owner: -
--

CREATE TABLE labw88.labw88_user_activity (
    user_activity_id numeric NOT NULL,
    user_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    activity_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
