-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_track_user_activity
-- Type: TABLE

-- Name: zeven_track_user_activity; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_track_user_activity (
    track_user_activityid numeric NOT NULL,
    userid numeric NOT NULL,
    sportid numeric,
    categoryid numeric,
    sub_categoryid numeric,
    articleid numeric,
    activityid numeric,
    asset_type_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
