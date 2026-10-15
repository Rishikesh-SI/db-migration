-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_activity_master
-- Type: TABLE

-- Name: zeven_activity_master; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_activity_master (
    activityid numeric NOT NULL,
    activity_name character varying(100) NOT NULL,
    activity_desc character varying(200),
    activity_points numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
