-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_user_activity
-- Type: TABLE

-- Name: labiis_user_activity; Type: TABLE; Schema: labiis; Owner: -
--

CREATE TABLE labiis.labiis_user_activity (
    user_activity_id numeric NOT NULL,
    user_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    activity_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
