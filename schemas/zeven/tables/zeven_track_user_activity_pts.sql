-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_track_user_activity_pts
-- Type: TABLE

-- Name: zeven_track_user_activity_pts; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_track_user_activity_pts (
    userid numeric NOT NULL,
    articleid numeric NOT NULL,
    activityid numeric NOT NULL,
    sportid numeric NOT NULL,
    categoryid numeric NOT NULL,
    sub_categoryid numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    points numeric,
    created_date timestamp(0) without time zone DEFAULT now(),
    updated_date timestamp(0) without time zone DEFAULT now()
);


--
